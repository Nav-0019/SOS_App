allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.plugins.withId("com.android.library") {
        val androidExt = project.extensions.findByName("android")
        if (androidExt != null) {
            try {
                val getNamespace = androidExt.javaClass.getMethod("getNamespace")
                val ns = getNamespace.invoke(androidExt)
                if (project.name == "telephony") {
                    val setNamespace = androidExt.javaClass.getMethod("setNamespace", String::class.java)
                    setNamespace.invoke(androidExt, "com.shounakmulay.telephony")
                } else if (ns == null) {
                    val setNamespace = androidExt.javaClass.getMethod("setNamespace", String::class.java)
                    setNamespace.invoke(androidExt, "dev.isar." + project.name.replace("-", "_"))
                }
            } catch (e: Exception) {
                // ignore
            }
        }
    }

    afterEvaluate {
        val androidExt = project.extensions.findByName("android")
        if (androidExt != null) {
            for (m in androidExt.javaClass.methods) {
                if (m.name == "setCompileSdkVersion" && m.parameterCount == 1) {
                    try {
                        m.invoke(androidExt, 37)
                    } catch (e: Exception) {}
                } else if (m.name == "setCompileSdk" && m.parameterCount == 1) {
                    try {
                        m.invoke(androidExt, 37)
                    } catch (e: Exception) {}
                }
            }
        }


        val javaCompileTasks = tasks.withType<JavaCompile>()
        tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
            val matchingJavaCompile = javaCompileTasks.findByName(name.replace("Kotlin", "JavaWithJavac"))
            val target = matchingJavaCompile?.targetCompatibility ?: "11"
            compilerOptions {
                when {
                    target.contains("1.8") || target == "8" -> jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_1_8)
                    target.contains("11") -> jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_11)
                    else -> jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
                }
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
