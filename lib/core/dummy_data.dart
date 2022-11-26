import 'package:fake_dona_app/models/bar_model.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

final List<BarModel> barModels = [
  const BarModel(
    icon: Ionicons.home,
    total: 0,
    title: 'Home',
  ),
  const BarModel(
    icon: Ionicons.calendar_clear_outline,
    total: 0,
    title: 'Today',
  ),
  const BarModel(
    icon: Ionicons.checkbox_outline,
    total: 0,
    title: 'Completed',
  ),
  const BarModel(
    color: Colors.red,
    total: 0,
    title: 'Personal',
  ),
  const BarModel(
    color: Colors.blue,
    total: 0,
    title: 'Work',
  ),
  const BarModel(
    color: Colors.green,
    total: 1,
    title: 'Errands',
  ),
  const BarModel(
    emoji: '🏡',
    total: 0,
    title: 'House',
  ),
  const BarModel(
    emoji: '🚗',
    total: 0,
    title: 'Road trip list',
  ),
];

final List<BarModel> barModels2 = [
  const BarModel(
    icon: Ionicons.home,
    total: 0,
    title: 'Personal',
  ),
  const BarModel(
    icon: Ionicons.calendar_clear_outline,
    total: 0,
    title: 'Password',
  ),
  const BarModel(
    color: Colors.red,
    total: 0,
    title: 'Appearance',
  ),
  const BarModel(
    color: Colors.blue,
    total: 0,
    title: 'Shortcuts',
  ),
  const BarModel(
    color: Colors.green,
    total: 1,
    title: 'Misc',
  ),
];
