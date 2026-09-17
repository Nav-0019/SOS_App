package com.jaldrishti.app

import android.Manifest
import android.bluetooth.*
import android.bluetooth.le.*
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.ParcelUuid
import android.util.Log
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.UUID
import java.util.concurrent.ConcurrentHashMap

class MainActivity : FlutterActivity() {
    private val TAG = "BlePeripheral"
    private val CHANNEL = "com.jaldrishti.app/ble_peripheral"

    private val SERVICE_UUID = UUID.fromString("6E400001-B5A3-F393-E0A9-E50E24DCCA9E")
    private val TX_CHAR_UUID = UUID.fromString("6E400002-B5A3-F393-E0A9-E50E24DCCA9E")
    private val RX_CHAR_UUID = UUID.fromString("6E400003-B5A3-F393-E0A9-E50E24DCCA9E")
    private val CCCD_UUID = UUID.fromString("00002902-0000-1000-8000-00805f9b34fb")

    private var methodChannel: MethodChannel? = null
    private var bluetoothManager: BluetoothManager? = null
    private var bluetoothAdapter: BluetoothAdapter? = null
    private var bluetoothLeAdvertiser: BluetoothLeAdvertiser? = null
    private var gattServer: BluetoothGattServer? = null
    private var txCharacteristic: BluetoothGattCharacteristic? = null

    private val connectedCentrals = ConcurrentHashMap<String, BluetoothDevice>()
    private var isAdvertising = false

    private val advertiseCallback = object : AdvertiseCallback() {
        override fun onStartSuccess(settingsInEffect: AdvertiseSettings?) {
            super.onStartSuccess(settingsInEffect)
            isAdvertising = true
            Log.i(TAG, "BLE Advertising started successfully for service: $SERVICE_UUID")
        }

        override fun onStartFailure(errorCode: Int) {
            super.onStartFailure(errorCode)
            isAdvertising = false
            Log.e(TAG, "BLE Advertising failed with error code: $errorCode")
        }
    }

    private val gattServerCallback = object : BluetoothGattServerCallback() {
        override fun onConnectionStateChange(device: BluetoothDevice, status: Int, newState: Int) {
            super.onConnectionStateChange(device, status, newState)
            val address = device.address
            if (newState == BluetoothProfile.STATE_CONNECTED) {
                Log.i(TAG, "Central connected to GATT Server: $address")
                connectedCentrals[address] = device
            } else if (newState == BluetoothProfile.STATE_DISCONNECTED) {
                Log.i(TAG, "Central disconnected from GATT Server: $address")
                connectedCentrals.remove(address)
            }
        }

        override fun onCharacteristicWriteRequest(
            device: BluetoothDevice,
            requestId: Int,
            characteristic: BluetoothGattCharacteristic,
            preparedWrite: Boolean,
            responseNeeded: Boolean,
            offset: Int,
            value: ByteArray?
        ) {
            super.onCharacteristicWriteRequest(
                device, requestId, characteristic, preparedWrite, responseNeeded, offset, value
            )

            if (responseNeeded) {
                try {
                    if (ActivityCompat.checkSelfPermission(
                            this@MainActivity, Manifest.permission.BLUETOOTH_CONNECT
                        ) == PackageManager.PERMISSION_GRANTED || Build.VERSION.SDK_INT < Build.VERSION_CODES.S
                    ) {
                        gattServer?.sendResponse(device, requestId, BluetoothGatt.GATT_SUCCESS, offset, value)
                    }
                } catch (e: SecurityException) {
                    Log.e(TAG, "SecurityException sending response: ${e.message}")
                }
            }

            if (value != null && value.isNotEmpty()) {
                Log.i(TAG, "Received packet on characteristic ${characteristic.uuid} (${value.size} bytes)")
                runOnUiThread {
                    methodChannel?.invokeMethod("onPacketReceived", value)
                }
            }
        }

        override fun onDescriptorWriteRequest(
            device: BluetoothDevice,
            requestId: Int,
            descriptor: BluetoothGattDescriptor,
            preparedWrite: Boolean,
            responseNeeded: Boolean,
            offset: Int,
            value: ByteArray?
        ) {
            super.onDescriptorWriteRequest(
                device, requestId, descriptor, preparedWrite, responseNeeded, offset, value
            )
            if (responseNeeded) {
                try {
                    if (ActivityCompat.checkSelfPermission(
                            this@MainActivity, Manifest.permission.BLUETOOTH_CONNECT
                        ) == PackageManager.PERMISSION_GRANTED || Build.VERSION.SDK_INT < Build.VERSION_CODES.S
                    ) {
                        gattServer?.sendResponse(device, requestId, BluetoothGatt.GATT_SUCCESS, offset, value)
                    }
                } catch (e: SecurityException) {
                    Log.e(TAG, "SecurityException sending descriptor response: ${e.message}")
                }
            }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).apply {
            setMethodCallHandler { call, result ->
                when (call.method) {
                    "startAdvertising" -> {
                        val success = startBlePeripheral()
                        result.success(success)
                    }
                    "stopAdvertising" -> {
                        stopBlePeripheral()
                        result.success(true)
                    }
                    "startBleForeground" -> {
                        try {
                            val intent = Intent(this@MainActivity, BleMeshForegroundService::class.java)
                            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                                startForegroundService(intent)
                            } else {
                                startService(intent)
                            }
                            result.success(true)
                        } catch (e: Exception) {
                            Log.e(TAG, "Error starting BleMeshForegroundService: ${e.message}")
                            result.success(false)
                        }
                    }
                    "stopBleForeground" -> {
                        try {
                            val intent = Intent(this@MainActivity, BleMeshForegroundService::class.java)
                            stopService(intent)
                            result.success(true)
                        } catch (e: Exception) {
                            Log.e(TAG, "Error stopping BleMeshForegroundService: ${e.message}")
                            result.success(false)
                        }
                    }
                    "notifyCentrals" -> {
                        val bytes = call.arguments as? ByteArray
                        if (bytes != null) {
                            notifyConnectedCentrals(bytes)
                            result.success(true)
                        } else {
                            result.error("INVALID_ARGS", "Expected ByteArray", null)
                        }
                    }
                    else -> result.notImplemented()
                }
            }
        }
    }

    private fun startBlePeripheral(): Boolean {
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                if (ActivityCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH_ADVERTISE) != PackageManager.PERMISSION_GRANTED ||
                    ActivityCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH_CONNECT) != PackageManager.PERMISSION_GRANTED) {
                    Log.w(TAG, "Missing Bluetooth permissions for peripheral operation")
                    return false
                }
            }

            bluetoothManager = getSystemService(Context.BLUETOOTH_SERVICE) as? BluetoothManager
            bluetoothAdapter = bluetoothManager?.adapter

            if (bluetoothAdapter == null || !bluetoothAdapter!!.isEnabled) {
                Log.w(TAG, "Bluetooth is disabled or unavailable")
                return false
            }

            bluetoothLeAdvertiser = bluetoothAdapter?.bluetoothLeAdvertiser
            if (bluetoothLeAdvertiser == null) {
                Log.w(TAG, "Device does not support BLE Advertising")
                return false
            }

            // Setup GATT Server if not already opened
            if (gattServer == null) {
                gattServer = bluetoothManager?.openGattServer(this, gattServerCallback)
                if (gattServer == null) {
                    Log.e(TAG, "Failed to open GATT Server")
                    return false
                }

                val service = BluetoothGattService(SERVICE_UUID, BluetoothGattService.SERVICE_TYPE_PRIMARY)

                // RX: Central writes to Peripheral
                val rxChar = BluetoothGattCharacteristic(
                    RX_CHAR_UUID,
                    BluetoothGattCharacteristic.PROPERTY_WRITE or BluetoothGattCharacteristic.PROPERTY_WRITE_NO_RESPONSE,
                    BluetoothGattCharacteristic.PERMISSION_WRITE
                )
                service.addCharacteristic(rxChar)

                // TX: Peripheral notifies Central
                val txChar = BluetoothGattCharacteristic(
                    TX_CHAR_UUID,
                    BluetoothGattCharacteristic.PROPERTY_NOTIFY or BluetoothGattCharacteristic.PROPERTY_READ,
                    BluetoothGattCharacteristic.PERMISSION_READ
                )
                val cccd = BluetoothGattDescriptor(
                    CCCD_UUID,
                    BluetoothGattDescriptor.PERMISSION_WRITE or BluetoothGattDescriptor.PERMISSION_READ
                )
                txChar.addDescriptor(cccd)
                service.addCharacteristic(txChar)
                txCharacteristic = txChar

                gattServer?.addService(service)
                Log.i(TAG, "GATT Server configured with Nordic UART Service")
            }

            // Start Advertising
            val settings = AdvertiseSettings.Builder()
                .setAdvertiseMode(AdvertiseSettings.ADVERTISE_MODE_LOW_LATENCY)
                .setTxPowerLevel(AdvertiseSettings.ADVERTISE_TX_POWER_HIGH)
                .setConnectable(true)
                .build()

            val data = AdvertiseData.Builder()
                .setIncludeDeviceName(false)
                .addServiceUuid(ParcelUuid(SERVICE_UUID))
                .build()

            bluetoothLeAdvertiser?.startAdvertising(settings, data, advertiseCallback)
            return true
        } catch (e: Exception) {
            Log.e(TAG, "Error starting BLE peripheral: ${e.message}", e)
            return false
        }
    }

    private fun stopBlePeripheral() {
        try {
            if (bluetoothLeAdvertiser != null && isAdvertising) {
                if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S ||
                    ActivityCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH_ADVERTISE) == PackageManager.PERMISSION_GRANTED) {
                    bluetoothLeAdvertiser?.stopAdvertising(advertiseCallback)
                }
                isAdvertising = false
            }

            if (gattServer != null) {
                if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S ||
                    ActivityCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH_CONNECT) == PackageManager.PERMISSION_GRANTED) {
                    gattServer?.close()
                }
                gattServer = null
            }
            connectedCentrals.clear()
            Log.i(TAG, "BLE Peripheral stopped")
        } catch (e: Exception) {
            Log.e(TAG, "Error stopping BLE peripheral: ${e.message}", e)
        }
    }

    private fun notifyConnectedCentrals(bytes: ByteArray) {
        try {
            val server = gattServer ?: return
            val char = txCharacteristic ?: return
            char.value = bytes

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S &&
                ActivityCompat.checkSelfPermission(this, Manifest.permission.BLUETOOTH_CONNECT) != PackageManager.PERMISSION_GRANTED) {
                return
            }

            for ((_, device) in connectedCentrals) {
                server.notifyCharacteristicChanged(device, char, false)
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error notifying centrals: ${e.message}")
        }
    }

    override fun onDestroy() {
        stopBlePeripheral()
        super.onDestroy()
    }
}
