import 'package:flutter/material.dart';

abstract class CreateRepository {
  Future<void> chooseColor(Color color);
  Future<void> chooseIcon(IconData icon);
}