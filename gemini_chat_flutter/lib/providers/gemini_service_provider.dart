import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../services/gemini_service.dart';

final geminiServiceProvider = Provider<GeminiService>((ref) {
  final apiKey = dotenv.env['API_KEY'] ?? '';
  return GeminiService(apiKey: apiKey);
});
