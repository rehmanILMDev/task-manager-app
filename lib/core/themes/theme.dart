import 'package:flutter/material.dart';

// Define  colors
const primaryColor = Colors.red;
const accentColor = Colors.green;

// Define  theme
final ThemeData myTheme = ThemeData(
    primaryColor: primaryColor,
    primarySwatch: primaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    hintColor: accentColor
    // Other theme properties like fontFamily, textTheme, etc.
    );
