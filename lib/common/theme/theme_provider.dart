import 'package:authenticator/common/theme/theme.dart';
import 'package:authenticator/common/theme/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:material_color_utilities/material_color_utilities.dart';

class ThemeProvider extends InheritedWidget {
  const ThemeProvider(
      {super.key,
      required this.settings,
      required this.lightDynamic,
      required this.darkDynamic,
      required super.child});

  final ValueNotifier<ThemeSettings> settings;
  final ColorScheme? lightDynamic;
  final ColorScheme? darkDynamic;

  final pageTransitionsTheme = const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: NoAnimationPageTransitionsBuilder(),
      TargetPlatform.macOS: NoAnimationPageTransitionsBuilder(),
      TargetPlatform.windows: NoAnimationPageTransitionsBuilder(),
    },
  );

  Color custom(CustomColor custom) {
    if (custom.blend) {
      return blend(custom.color);
    } else {
      return custom.color;
    }
  }

  Color blend(Color targetColor) {
    return Color(
        Blend.harmonize(targetColor.value, settings.value.sourceColor.value));
  }

  Color source(Color? target) {
    Color source = settings.value.sourceColor;
    if (target != null) {
      source = blend(target);
    }
    return source;
  }

  ColorScheme colors(Brightness brightness, Color? targetColor) {
    final dynamicPrimary = brightness == Brightness.light
        ? lightDynamic?.primary
        : darkDynamic?.primary;
    return ColorScheme.fromSeed(
      seedColor: dynamicPrimary ?? source(targetColor),
      brightness: brightness,
    );
  }

  ShapeBorder get shapeMedium => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      );

  CardTheme cardTheme() {
    return CardTheme(
      elevation: 0,
      shape: shapeMedium,
      clipBehavior: Clip.antiAlias,
    );
  }

  ListTileThemeData listTileTheme(ColorScheme colors) {
    return ListTileThemeData(
      shape: shapeMedium,
      selectedColor: colors.secondary,
    );
  }

  AppBarTheme appBarTheme(Brightness brightness, ColorScheme colors) {
    return AppBarTheme(
        elevation: 0,
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        iconTheme: iconTheme(brightness, colors.primary),
        actionsIconTheme: iconTheme(brightness, colors.primary));
  }

  TabBarTheme tabBarTheme(ColorScheme colors) {
    return TabBarTheme(
      labelColor: colors.secondary,
      unselectedLabelColor: colors.onSurfaceVariant,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.secondary,
            width: 2,
          ),
        ),
      ),
    );
  }

  BottomAppBarTheme bottomAppBarTheme(ColorScheme colors) {
    return BottomAppBarTheme(
      color: colors.surface,
      elevation: 0,
    );
  }

  BottomNavigationBarThemeData bottomNavigationBarTheme(
      Brightness brightness, ColorScheme colors) {
    return BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: colors.surfaceVariant,
      selectedItemColor: colors.onSurface,
      unselectedItemColor: colors.onSurfaceVariant,
      elevation: 0,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      selectedIconTheme: iconTheme(brightness, colors.primary),
      unselectedIconTheme: iconTheme(brightness, colors.primary),
    );
  }

  NavigationRailThemeData navigationRailTheme(
      Brightness brightness, ColorScheme colors) {
    return NavigationRailThemeData(
      backgroundColor: colors.background,
      selectedIconTheme: iconTheme(brightness, colors.primary),
      unselectedIconTheme: iconTheme(brightness, colors.primary),
      selectedLabelTextStyle: textTheme(brightness, colors.primary).labelMedium,
      unselectedLabelTextStyle:
          textTheme(brightness, colors.onSurface).labelMedium,
    );
  }

  DrawerThemeData drawerTheme(ColorScheme colors) {
    return DrawerThemeData(
      backgroundColor: colors.surface,
    );
  }

  TextTheme textTheme(Brightness brightness, Color color) {
    final textThemeTemplate = brightness == Brightness.dark
        ? ThemeData.dark().textTheme
        : ThemeData.light().textTheme;
    final fontTextTheme = GoogleFonts.robotoTextTheme(textThemeTemplate);
    return fontTextTheme.copyWith(
      displayLarge: fontTextTheme.displayLarge?.copyWith(
        color: color,
      ),
      displayMedium: fontTextTheme.displayMedium?.copyWith(
        color: color,
      ),
      displaySmall: fontTextTheme.displaySmall?.copyWith(
        color: color,
      ),
      headlineLarge: fontTextTheme.headlineLarge?.copyWith(
        color: color,
      ),
      headlineMedium: fontTextTheme.headlineMedium?.copyWith(
        color: color,
      ),
      headlineSmall: fontTextTheme.headlineSmall?.copyWith(
        color: color,
      ),
      titleLarge: fontTextTheme.titleLarge?.copyWith(
        color: color,
      ),
      titleMedium: fontTextTheme.titleMedium?.copyWith(
        color: color,
      ),
      titleSmall: fontTextTheme.titleSmall?.copyWith(
        color: color,
      ),
      bodyLarge: fontTextTheme.bodyLarge?.copyWith(
        color: color,
      ),
      bodyMedium: fontTextTheme.bodyMedium?.copyWith(
        color: color,
      ),
      bodySmall: fontTextTheme.bodySmall?.copyWith(
        color: color,
      ),
      labelLarge: fontTextTheme.labelLarge?.copyWith(
        color: color,
      ),
      labelMedium: fontTextTheme.labelMedium?.copyWith(
        color: color,
      ),
      labelSmall: fontTextTheme.labelSmall?.copyWith(
        color: color,
      ),
    );
  }

  IconThemeData iconTheme(Brightness brightness, Color color) {
    final iconThemeTemplate = brightness == Brightness.dark
        ? ThemeData.dark().iconTheme
        : ThemeData.light().iconTheme;
    return iconThemeTemplate.copyWith(size: 16, color: color);
  }

  BottomSheetThemeData bottomSheetTheme(Brightness brightness, Color color) {
    final bottomSheetThemeTemplate = brightness == Brightness.dark
        ? ThemeData.dark().bottomSheetTheme
        : ThemeData.light().bottomSheetTheme;
    return bottomSheetThemeTemplate.copyWith(
      backgroundColor: color,
      modalBackgroundColor: color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  DialogTheme dialogTheme(Brightness brightness, ColorScheme colors) {
    final dialogThemeTemplate = brightness == Brightness.dark
        ? ThemeData.dark().dialogTheme
        : ThemeData.light().dialogTheme;
    return dialogThemeTemplate.copyWith(
      backgroundColor: colors.onSecondary,
      iconColor: colors.primary,
    );
  }

  FloatingActionButtonThemeData fabTheme(Brightness brightness) {
    final fabThemeTemplate = brightness == Brightness.dark
        ? ThemeData.dark().floatingActionButtonTheme
        : ThemeData.light().floatingActionButtonTheme;
    return fabThemeTemplate.copyWith(
      shape: const CircleBorder(),
      iconSize: 16.0,
    );
  }

  ThemeData light([Color? targetColor]) {
    final colorScheme = colors(Brightness.light, targetColor);
    return ThemeData.light().copyWith(
      // Add page transitions
      colorScheme: colorScheme,
      textTheme: textTheme(Brightness.light, colorScheme.onSurface),
      primaryTextTheme: textTheme(Brightness.light, colorScheme.primary),
      iconTheme: iconTheme(Brightness.light, colorScheme.onSurface),
      primaryIconTheme: iconTheme(Brightness.light, colorScheme.primary),
      appBarTheme: appBarTheme(Brightness.light, colorScheme),
      bottomSheetTheme:
          bottomSheetTheme(Brightness.light, colorScheme.onSurface),
      cardTheme: cardTheme(),
      listTileTheme: listTileTheme(colorScheme),
      bottomAppBarTheme: bottomAppBarTheme(colorScheme),
      bottomNavigationBarTheme:
          bottomNavigationBarTheme(Brightness.light, colorScheme),
      floatingActionButtonTheme: fabTheme(Brightness.light),
      navigationRailTheme: navigationRailTheme(Brightness.light, colorScheme),
      tabBarTheme: tabBarTheme(colorScheme),
      drawerTheme: drawerTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.background,
      dialogTheme: dialogTheme(Brightness.light, colorScheme),
      dividerColor: colorScheme.outlineVariant,
      useMaterial3: true,
    );
  }

  ThemeData dark([Color? targetColor]) {
    final colorScheme = colors(Brightness.dark, targetColor);
    return ThemeData.dark().copyWith(
      // Add page transitions
      colorScheme: colorScheme,
      textTheme: textTheme(Brightness.dark, colorScheme.onSurface),
      primaryTextTheme: textTheme(Brightness.dark, colorScheme.primary),
      iconTheme: iconTheme(Brightness.dark, colorScheme.onSurface),
      primaryIconTheme: iconTheme(Brightness.dark, colorScheme.primary),
      appBarTheme: appBarTheme(Brightness.dark, colorScheme),
      bottomSheetTheme:
          bottomSheetTheme(Brightness.light, colorScheme.onSurface),
      cardTheme: cardTheme(),
      listTileTheme: listTileTheme(colorScheme),
      bottomAppBarTheme: bottomAppBarTheme(colorScheme),
      bottomNavigationBarTheme:
          bottomNavigationBarTheme(Brightness.light, colorScheme),
      floatingActionButtonTheme: fabTheme(Brightness.dark),
      navigationRailTheme: navigationRailTheme(Brightness.dark, colorScheme),
      tabBarTheme: tabBarTheme(colorScheme),
      drawerTheme: drawerTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.background,
      dialogTheme: dialogTheme(Brightness.dark, colorScheme),
      dividerColor: colorScheme.outlineVariant,
      useMaterial3: true,
    );
  }

  ThemeMode themeMode() {
    return settings.value.themeMode;
  }

  ThemeData theme(BuildContext context, [Color? targetColor]) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.light
        ? light(targetColor)
        : dark(targetColor);
  }

  static ThemeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant ThemeProvider oldWidget) {
    return oldWidget.settings != settings;
  }
}
