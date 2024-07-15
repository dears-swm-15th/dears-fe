import 'package:flutter/material.dart';

const Color blue500 = Color(0xFF0094FF);
const Color blue700 = Color(0xFF104EA5);
const Color blue200 = Color(0xFF9FC6F8);
const Color blue100 = Color(0xFFC3DEFF);
const Color blue50 = Color(0xFFE7F1FF);
const Color black = Color(0xFF17181A);
const Color gray800 = Color(0xFF30313E);
const Color gray600 = Color(0xFF97989E);
const Color gray100 = Color(0xFFEBECED);
const Color white = Colors.white;
const Color yellow = Color(0xFFFFBD35);
const Color red = Color(0xFFFC4032);

final ThemeData theme = ThemeData(
  // For the sanity of the reader, make sure these properties are in the same
  // order in every place that they are separated by section comments (e.g.
  // GENERAL CONFIGURATION). Each section except for deprecations should be
  // alphabetical by symbol name.

  // GENERAL CONFIGURATION
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  platform: TargetPlatform.iOS,

  // COLOR
  scaffoldBackgroundColor: white,

  // TYPOGRAPHY & ICONOGRAPHY
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: black,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  ),

  // COMPONENT THEMES
  appBarTheme: const AppBarTheme(
    backgroundColor: white,
    surfaceTintColor: white,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: white,
    selectedIconTheme: IconThemeData(size: 28),
    unselectedIconTheme: IconThemeData(size: 28),
    selectedItemColor: blue500,
    unselectedItemColor: gray600,
    selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
    unselectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
    type: BottomNavigationBarType.fixed,
    enableFeedback: false,
    landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
  ),
  chipTheme: const ChipThemeData(
    color: WidgetStatePropertyAll(white),
    checkmarkColor: blue500,
    labelPadding: EdgeInsets.zero,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    side: BorderSide(color: blue500),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    labelStyle: TextStyle(color: blue500, fontWeight: FontWeight.w500),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      foregroundColor: white,
      backgroundColor: blue500,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: blue500,
      textStyle: const TextStyle(fontWeight: FontWeight.w600),
      side: const BorderSide(color: blue500),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    ),
  ),
  tabBarTheme: const TabBarTheme(
    indicatorColor: black,
    labelStyle: TextStyle(
      color: black,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
    unselectedLabelStyle: TextStyle(
      color: gray600,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  ),
);
