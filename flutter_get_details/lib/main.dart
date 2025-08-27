import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/package_details_page.dart';

void main() {
  runApp(const ColisApp());
}

class ColisApp extends StatelessWidget {
  const ColisApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = const Color(0xFF335CFF);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Colis Détails',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
          primary: primaryBlue,
          secondary: const Color(0xFF0F172A),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
            fontSize: 18,
          ),
          iconTheme: IconThemeData(color: Color(0xFF0F172A)),
        ),
      ),
      home: const PackageDetailsPage(),
    );
  }
}
