import 'package:dears/utils/icons.dart';
import 'package:flutter/material.dart';

// COLOR
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

// TYPOGRAPHY

// TITLE
const TextStyle titleLarge = TextStyle(
  color: black,
  fontSize: 18,
  fontWeight: FontWeight.w600,
  letterSpacing: 0,
  height: 24 / 18,
);
const TextStyle titleMedium = TextStyle(
  color: black,
  fontSize: 16,
  fontWeight: FontWeight.w700,
  letterSpacing: 0,
  height: 20 / 16,
);
const TextStyle titleSmall = TextStyle(
  color: black,
  fontSize: 14,
  fontWeight: FontWeight.w600,
  letterSpacing: 0,
  height: 18 / 14,
);

// BODY
const TextStyle bodyLarge = TextStyle(
  color: black,
  fontSize: 16,
  fontWeight: FontWeight.w500,
  letterSpacing: 0,
  height: 20 / 16,
);
const TextStyle bodyMedium = TextStyle(
  color: black,
  fontSize: 15,
  fontWeight: FontWeight.w500,
  letterSpacing: 0,
  height: 18 / 15,
);
const TextStyle bodyMediumLong = TextStyle(
  color: black,
  fontSize: 15,
  fontWeight: FontWeight.w500,
  letterSpacing: -0.15,
  height: 24 / 15,
);
const TextStyle bodySmall = TextStyle(
  color: black,
  fontSize: 14,
  fontWeight: FontWeight.w500,
  letterSpacing: 0,
  height: 18 / 14,
);
const TextStyle bodySmallLong = TextStyle(
  color: black,
  fontSize: 14,
  fontWeight: FontWeight.w500,
  letterSpacing: -0.3,
  height: 20 / 14,
);

// CAPTION
const TextStyle captionLarge = TextStyle(
  color: black,
  fontSize: 13,
  fontWeight: FontWeight.w500,
  letterSpacing: 0,
  height: 16 / 13,
);
const TextStyle captionSmall = TextStyle(
  color: black,
  fontSize: 11,
  fontWeight: FontWeight.w400,
  letterSpacing: 0,
  height: 14 / 11,
);

// DIMENSION
const double toolbarHeight = 44;
const double tabHeight = 44;

// SHADOW
const List<BoxShadow> boxShadow = [
  BoxShadow(
    color: Color(0x1A364FC7),
    offset: Offset(0, 1),
    blurRadius: 4,
  ),
  BoxShadow(
    color: Color(0x26364FC7),
    offset: Offset(0, 1),
    blurRadius: 4,
  ),
];

final ThemeData theme = ThemeData(
  // For the sanity of the reader, make sure these properties are in the same
  // order in every place that they are separated by section comments (e.g.
  // GENERAL CONFIGURATION). Each section except for deprecations should be
  // alphabetical by symbol name.

  // GENERAL CONFIGURATION
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  platform: TargetPlatform.iOS,

  // COLOR
  colorSchemeSeed: blue500,
  scaffoldBackgroundColor: white,

  // TYPOGRAPHY & ICONOGRAPHY
  textTheme: const TextTheme(
    titleLarge: bodyLarge, // default text style for AppBar title
  ),

  // COMPONENT THEMES
  actionIconTheme: ActionIconThemeData(
    backButtonIconBuilder: (context) => const Icon(DearsIcons.caret_left),
    closeButtonIconBuilder: (context) => const Icon(DearsIcons.close),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: white,
    surfaceTintColor: white,
    centerTitle: false,
    titleSpacing: 0,
    toolbarHeight: toolbarHeight,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: white,
    selectedIconTheme: IconThemeData(size: 28),
    unselectedIconTheme: IconThemeData(size: 28),
    selectedItemColor: gray600,
    unselectedItemColor: gray600,
    selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
    unselectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
    type: BottomNavigationBarType.fixed,
    enableFeedback: false,
    landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
  ),
  chipTheme: const ChipThemeData(
    color: WidgetStatePropertyAll(white),
    labelPadding: EdgeInsets.zero,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    labelStyle: bodySmall,
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
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      padding: const EdgeInsets.all(10),
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
