import 'dart:convert';
import 'package:flutter/services.dart';

class MedicalQaItem {
  final String id;
  final String category;
  final String? categoryHi;
  final String title;
  final String? titleHi;
  final List<String> keywords;
  final List<String> keywordsHi;
  final List<String> steps;
  final List<String> stepsHi;
  final List<String> warnings;
  final List<String> warningsHi;

  MedicalQaItem({
    required this.id,
    required this.category,
    this.categoryHi,
    required this.title,
    this.titleHi,
    required this.keywords,
    this.keywordsHi = const [],
    required this.steps,
    this.stepsHi = const [],
    required this.warnings,
    this.warningsHi = const [],
  });

  factory MedicalQaItem.fromJson(Map<String, dynamic> json) {
    return MedicalQaItem(
      id: json['id'] as String,
      category: json['category'] as String,
      categoryHi: json['category_hi'] as String?,
      title: json['title'] as String,
      titleHi: json['title_hi'] as String?,
      keywords: List<String>.from(json['keywords'] ?? []),
      keywordsHi: List<String>.from(json['keywords_hi'] ?? []),
      steps: List<String>.from(json['steps'] ?? []),
      stepsHi: List<String>.from(json['steps_hi'] ?? []),
      warnings: List<String>.from(json['warnings'] ?? []),
      warningsHi: List<String>.from(json['warnings_hi'] ?? []),
    );
  }

  String localizedTitle(String langCode) {
    if (langCode == 'hi' && titleHi != null && titleHi!.isNotEmpty) {
      return titleHi!;
    }
    return title;
  }

  String localizedCategory(String langCode) {
    if (langCode == 'hi' && categoryHi != null && categoryHi!.isNotEmpty) {
      return categoryHi!;
    }
    return category;
  }

  List<String> localizedSteps(String langCode) {
    if (langCode == 'hi' && stepsHi.isNotEmpty) {
      return stepsHi;
    }
    return steps;
  }

  List<String> localizedWarnings(String langCode) {
    if (langCode == 'hi' && warningsHi.isNotEmpty) {
      return warningsHi;
    }
    return warnings;
  }

  /// Builds a speech-friendly transcript for offline TTS readout
  String buildSpeechTranscript(String langCode) {
    final t = localizedTitle(langCode);
    final w = localizedWarnings(langCode);
    final s = localizedSteps(langCode);

    final buffer = StringBuffer();
    buffer.writeln(t);
    buffer.writeln();

    if (w.isNotEmpty) {
      buffer.writeln(langCode == 'hi' ? 'महत्वपूर्ण चेतावनी:' : 'Critical warnings:');
      for (final warning in w) {
        buffer.writeln(warning);
      }
      buffer.writeln();
    }

    buffer.writeln(langCode == 'hi' ? 'कार्रवाई के चरण:' : 'Action steps:');
    for (final step in s) {
      buffer.writeln(step);
    }

    return buffer.toString();
  }
}

class AssistantSearchService {
  static final AssistantSearchService _instance =
      AssistantSearchService._internal();
  factory AssistantSearchService() => _instance;
  AssistantSearchService._internal();

  List<MedicalQaItem> _qaDatabase = [];
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/medical_qa.json');
      final Map<String, dynamic> decodedJson = json.decode(jsonString);
      final List<dynamic> topics = decodedJson['topics'] ?? [];
      _qaDatabase = topics.map((item) => MedicalQaItem.fromJson(item)).toList();
      _isInitialized = true;
    } catch (_) {}
  }

  /// Fast deterministic keyword search supporting both English and Hindi.
  List<MedicalQaItem> search(String query) {
    if (query.trim().isEmpty) return _qaDatabase;
    final q = query.toLowerCase().trim();
    return _qaDatabase.where((item) {
      return item.title.toLowerCase().contains(q) ||
          (item.titleHi != null && item.titleHi!.toLowerCase().contains(q)) ||
          item.category.toLowerCase().contains(q) ||
          (item.categoryHi != null && item.categoryHi!.toLowerCase().contains(q)) ||
          item.keywords.any((kw) => kw.toLowerCase().contains(q)) ||
          item.keywordsHi.any((kw) => kw.toLowerCase().contains(q));
    }).toList();
  }

  List<MedicalQaItem> getByCategory(String categoryName) {
    return _qaDatabase
        .where(
            (item) => item.category.toLowerCase() == categoryName.toLowerCase())
        .toList();
  }
}
