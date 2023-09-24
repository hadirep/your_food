import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Colors.white;
const Color secondaryColor = Colors.red;
const Color darkPrimaryColor = Color(0xFF303030);
const Color darkSecondaryColor = Color(0xFF424242);
const Color dividerColor = Colors.grey;
const Color iconColor = Colors.blue;

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.poppins(
      fontSize: 79, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  displayMedium: GoogleFonts.poppins(
      fontSize: 49, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  displaySmall: GoogleFonts.poppins(fontSize: 39, fontWeight: FontWeight.w400),
  headlineMedium: GoogleFonts.poppins(
      fontSize: 28, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineSmall: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleMedium: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  titleSmall: GoogleFonts.poppins(
      fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyLarge: GoogleFonts.openSans(
      fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.openSans(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  labelLarge: GoogleFonts.openSans(
      fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  bodySmall: GoogleFonts.openSans(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  labelSmall: GoogleFonts.openSans(
      fontSize: 8, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

ThemeData lightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  appBarTheme: const AppBarTheme(elevation: 0, color: primaryColor),
  drawerTheme: const DrawerThemeData(backgroundColor: primaryColor),
  inputDecorationTheme: const InputDecorationTheme(fillColor: primaryColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondaryColor,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  appBarTheme: const AppBarTheme(elevation: 0),
  drawerTheme: const DrawerThemeData(backgroundColor: darkSecondaryColor),
  inputDecorationTheme: const InputDecorationTheme(fillColor: darkSecondaryColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondaryColor,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius:  BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
);