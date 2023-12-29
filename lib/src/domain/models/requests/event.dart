import 'package:flutter/material.dart';

class Eventos {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;
  final Icon icon;

  const Eventos({
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    this.backgroundColor = const Color(0xFF0F8644),
    this.isAllDay = false,
    required this.icon
  });
}