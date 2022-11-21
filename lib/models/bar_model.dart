import 'package:flutter/material.dart';

class BarModel {
  final IconData? icon;
  final int? total;
  final Color? color;
  final String? emoji;
  final String title;
  const BarModel({
    this.icon,
    this.total,
    this.color,
    this.emoji,
    required this.title,
  });
}
