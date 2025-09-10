import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppConverters {
  /// 2. String → DateTime
  static DateTime? stringToDateTime(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      return DateTime.tryParse(dateString);
    } catch (_) {
      return null;
    }
  }

  /// 3. String → Color
  static Color? stringToColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) return null;
    try {
      // Example input: "#FF5733" or "0xFF5733"
      String value = colorString.replaceAll("#", "");
      if (!value.startsWith("0x")) {
        value = "0xFF$value"; 
      }
      return Color(int.parse(value));
    } catch (_) {
      return null;
    }
  }


static Color stringToColorDiary(String? colorString) {
  if (colorString == null || colorString.isEmpty) {
    return Colors.white; // Default if null or empty
  }

  final regex = RegExp(
    r'alpha:\s*([0-9.]+),\s*red:\s*([0-9.]+),\s*green:\s*([0-9.]+),\s*blue:\s*([0-9.]+)',
  );
  final match = regex.firstMatch(colorString);

  if (match != null) {
    try {
      double alpha = double.parse(match.group(1)!);
      double red = double.parse(match.group(2)!);
      double green = double.parse(match.group(3)!);
      double blue = double.parse(match.group(4)!);

      return Color.fromARGB(
        (alpha * 255).round().clamp(0, 255),
        (red * 255).round().clamp(0, 255),
        (green * 255).round().clamp(0, 255),
        (blue * 255).round().clamp(0, 255),
      );
    } catch (e) {
      return Colors.white; // If parsing fails
    }
  }

  return Colors.white; // Default if pattern not found
}


  static List<String>? stringToList(String? listString) {
    if (listString == null || listString.isEmpty) return null;
    try {
      // If JSON encoded: '["one","two","three"]'
      final decoded = jsonDecode(listString);
      if (decoded is List) {
        return decoded.map((e) => e.toString()).toList();
      }
    } catch (_) {
      // If simple comma-separated string: "one,two,three"
      return listString.split(',').map((e) => e.trim()).toList();
    }
    return null;
  }
  static String formatRelativeDate(String dateString) {
    try {
      // Parse your stored date (assuming ISO format like "2025-09-09")
      final DateTime entryDate = DateTime.parse(dateString);
      final DateTime now = DateTime.now();

      final Duration diff = now.difference(entryDate);
      if (diff.inDays == 0) {
        return "Today";
      } else if (diff.inDays == 1) {
        return "Yesterday";
      } else if (diff.inDays < 7) {
        return "${diff.inDays} days ago";
      } else {
        return DateFormat('dd MMM yyyy').format(entryDate);
      }
    } catch (_) {
      return dateString; // fallback if parsing fails
    }
  }
}
