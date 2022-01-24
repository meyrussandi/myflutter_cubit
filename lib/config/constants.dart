import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


double scale = 1.w;

Widget verticalSpace(double v) {
  return SizedBox(height: v);
}

Widget horizontalSpace(double v) {
  return SizedBox(width: v);
}

class Times {
  static const Duration fastest = Duration(milliseconds: 150);
  static const fast = Duration(milliseconds: 250);
  static const medium = Duration(milliseconds: 350);
  static const slow = Duration(milliseconds: 700);
  static const slower = Duration(milliseconds: 1000);
}

class Sizes {
  static double get xs => 8 * scale;
  static double get sm => 12 * scale;
  static double get med => 20 * scale;
  static double get lg => 32 * scale;
  static double get xl => 48 * scale;
  static double get xxl => 80 * scale;
}

class IconSizes {
  static double get sm => 16 * scale;
  static double get med => 24 * scale;
  static double get lg => 32 * scale;
  static double get xl => 48 * scale;
  static double get xxl => 60 * scale;
}

class Insets {
  static double offsetScale = 1;
  static double get xs => 4 * scale;
  static double get sm => 8 * scale;
  static double get med => 12 * scale;
  static double get lg => 16 * scale;
  static double get xl => 20 * scale;
  static double get xxl => 32 * scale;
  // Offset, used for the edge of the window, or to separate large sections in the app
  static double get offset => 40 * offsetScale;
}

class Corners {
  static double sm = 3 * scale;
  static BorderRadius smBorder = BorderRadius.all(smRadius);
  static Radius smRadius = Radius.circular(sm);

  static double med = 5 * scale;
  static BorderRadius medBorder = BorderRadius.all(medRadius);
  static Radius medRadius = Radius.circular(med);

  static double lg = 8 * scale;
  static BorderRadius lgBorder = BorderRadius.all(lgRadius);
  static Radius lgRadius = Radius.circular(lg);

  static double xl = 16 * scale;
  static BorderRadius xlBorder = BorderRadius.all(xlRadius);
  static Radius xlRadius = Radius.circular(xl);

  static double xxl = 24 * scale;
  static BorderRadius xxlBorder = BorderRadius.all(xxlRadius);
  static Radius xxlRadius = Radius.circular(xxl);
}

class Strokes {
  static const double xthin = 0.7;
  static const double thin = 1;
  static const double med = 2;
  static const double thick = 4;
}

class FontSizes {
  /// Provides the ability to nudge the app-wide font scale in either direction
  static double get s9 => 9.sp;
  static double get s10 => 10.sp;
  static double get s11 => 11.sp;
  static double get s12 => 12.sp;
  static double get s14 => 14.sp;
  static double get s16 => 16.sp;
  static double get s18 => 18.sp;
  static double get s20 => 20.sp;
  static double get s24 => 24.sp;
  static double get s26 => 26.sp;
  static double get s32 => 32.sp;
  static double get s40 => 40.sp;
  static double get s56 => 56.sp;
}
