import 'package:flutter/material.dart';

const Map<String, String> importanceString = {
  'U-I': 'Urgent & Important',
  'NU-I': 'Not Urgent & Important',
  'U-NI': 'Urgent & Not Important',
  'NU-NI': 'Not Urgent & Not Important',
};

const Map<String, String> importanceKey = {
  'Urgent & Important': 'U-I',
  'Not Urgent & Important': 'NU-I',
  'Urgent & Not Important': 'U-NI',
  'Not Urgent & Not Important': 'NU-NI',
};
const Map<String, Color> importanceColor = {
  'U-I': Colors.red,
  'NU-I': Colors.orange,
  'U-NI': Colors.yellow,
  'NU-NI': Colors.green,
};

const Map<String, String> timeTechnique = {
  '25': '25m Work 5m Breack',
  '45': '45m Work 10m Breack',
};
