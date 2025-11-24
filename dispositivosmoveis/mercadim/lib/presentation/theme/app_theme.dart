import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    useMaterial3: true,

    // ============================
    // 🎨 PALETA DE CORES MERCADIM
    // ============================
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF2E7D32),      // Verde Mercadim
      onPrimary: Colors.white,

      secondary: Color(0xFFA5D6A7),    // Verde claro acento
      onSecondary: Color(0xFF1B1B1B),

      tertiary: Color(0xFF4DB6AC),     // Verde azulado
      onTertiary: Colors.white,

      surface: Colors.white,
      onSurface: Color(0xFF1B1B1B),

      background: Color(0xFFF0F3F1),   // Fundo esverdeado leve
      onBackground: Color(0xFF1B1B1B),

      error: Color(0xFFE53935),
      onError: Colors.white,

      outline: Color(0xFFDDE2DD),
    ),

    scaffoldBackgroundColor: const Color(0xFFF0F3F1),

    // ============================
    // 🔤 TIPOGRAFIA GLOBAL
    // ============================
    textTheme: Typography.blackMountainView.copyWith(
      bodyLarge: const TextStyle(fontFamily: "Poppins"),
      bodyMedium: const TextStyle(fontFamily: "Poppins"),
      bodySmall: const TextStyle(fontFamily: "Poppins"),
      titleLarge: const TextStyle(fontFamily: "Poppins"),
      titleMedium: const TextStyle(fontFamily: "Poppins"),
      titleSmall: const TextStyle(fontFamily: "Poppins"),
    ),

    // ============================
    // ⚡ ANIMAÇÕES / MOTION (M3)
    // ============================
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
      },
    ),

    // ============================
    // 💧 ANIMAÇÃO DE TOQUE GLOBAL
    // ============================
    splashFactory: InkSparkle
            .splashFactory, // se causar problemas, trocar para InkRipple.splashFactory

    // ============================
    // 📦 DENSIDADE & INTERAÇÃO
    // ============================
    visualDensity: VisualDensity.standard,

    // ============================
    // 🟩 APPBAR MODERNA
    // ============================
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF1B1B1B),
      elevation: 0.5,
      shadowColor: Colors.black12,
      centerTitle: true,
      surfaceTintColor: Colors.white,
      titleTextStyle: TextStyle(
        fontFamily: "Poppins",
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: Color(0xFF1B1B1B),
      ),
    ),

    // ============================
    // 🔘 BOTÕES
    // ============================
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        elevation: 1.5,
        textStyle: const TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    // ============================
    // ✏ TEXTFIELDS MODERNOS
    // ============================
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFDDE2DD)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 1.5),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),

    // ============================
    // 🧭 NAVIGATION BAR (BottomNav)
    // ============================
    navigationBarTheme: NavigationBarThemeData(
      elevation: 3,
      backgroundColor: Colors.white,
      indicatorColor: const Color(0xFFA5D6A7),
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(fontFamily: "Poppins"),
      ),
    ),

    // ============================
    // 🪟 BOTTOM SHEETS
    // ============================
    bottomSheetTheme: const BottomSheetThemeData(
      elevation: 2,
      backgroundColor: Colors.white,
      modalBackgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),

    // ============================
    // 🛎 SNACKBARS
    // ============================
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black87,
      contentTextStyle: TextStyle(fontFamily: "Poppins", color: Colors.white),
      elevation: 6,
    ),
  );
}
