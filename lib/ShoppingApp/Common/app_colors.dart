import 'dart:ui';

class AppColors {
  // Primary Colors - Modern Blue Gradient
  static const Color primary = Color(0xff667eea);
  static const Color primaryDark = Color(0xff764ba2);
  static const Color primaryLight = Color(0xff89a3f5);
  static const Color primaryGradientStart = Color(0xff667eea);
  static const Color primaryGradientEnd = Color(0xff764ba2);
  
  // Background Colors
  static const Color background = Color(0xfff8fafc);
  static const Color backgroundDark = Color(0xff1a202c);
  static const Color surface = Color(0xffffffff);
  static const Color surfaceDark = Color(0xff2d3748);
  
  // Text Colors
  static const Color textPrimary = Color(0xff1a202c);
  static const Color textSecondary = Color(0xff4a5568);
  static const Color textTertiary = Color(0xff718096);
  static const Color textLight = Color(0xffa0aec0);
  
  // Status Colors
  static const Color success = Color(0xff48bb78);
  static const Color successLight = Color(0xffc6f6d5);
  static const Color error = Color(0xfff56565);
  static const Color errorLight = Color(0xfffed7d7);
  static const Color warning = Color(0xffed8936);
  static const Color warningLight = Color(0xfffbd38d);
  static const Color info = Color(0xff4299e1);
  static const Color infoLight = Color(0xffbee3f8);
  
  // Border and Divider Colors
  static const Color border = Color(0xffe2e8f0);
  static const Color borderLight = Color(0xfff7fafc);
  static const Color divider = Color(0xffe2e8f0);
  
  // Shadow Colors
  static const Color shadow = Color(0x1a000000);
  static const Color shadowLight = Color(0x0a000000);
  
  // Gradient Colors
  static const List<Color> primaryGradient = [primaryGradientStart, primaryGradientEnd];
  static const List<Color> backgroundGradient = [Color(0xfff8fafc), Color(0xffe2e8f0)];
  static const List<Color> cardGradient = [Color(0xffffffff), Color(0xfff7fafc)];
  
  // Social Media Colors
  static const Color googleRed = Color(0xffdb4437);
  static const Color facebookBlue = Color(0xff4267b2);
  static const Color twitterBlue = Color(0xff1da1f2);
}