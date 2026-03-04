import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl = "https://cybrains.co.in/scan";

  static Future<String> scanUrl(String url) async {

    try {

      // Normalize URL
      url = url
          .replaceAll("https://", "")
          .replaceAll("http://", "")
          .split("/")[0];

      final uri = Uri.parse(baseUrl).replace(
        queryParameters: {"url": url},
      );

      debugPrint("API CALL: $uri");

      final response = await http
          .get(uri)
          .timeout(const Duration(seconds: 10));

      debugPrint("API RESPONSE: ${response.body}");

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        // Extract Gemini verdict
        String verdict =
            data["candidates"][0]["content"]["parts"][0]["text"]
                .toString()
                .trim()
                .toUpperCase();

        return verdict;

      }

      return "ERROR";

    } catch (e) {

      debugPrint("API ERROR: $e");

      return "ERROR";

    }
  }
}