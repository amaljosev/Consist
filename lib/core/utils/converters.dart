import 'dart:convert';
import 'package:flutter/material.dart';
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
      value = "0xFF$value"; // add alpha if missing
    }
    return Color(int.parse(value));
  } catch (_) {
    return null;
  }
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

}