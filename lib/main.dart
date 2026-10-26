import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'core/di/injection.dart' as di;
import 'features/portfolio/presentation/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    BlocProvider(
      create: (_) => di.sl<ThemeCubit>(),
      child: const PortfolioApp(),
    ),
  );
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      fontSizeResolver: (fontSize, instance) {
        final width = instance.screenWidth;
        if (width <= 0) return fontSize.toDouble();

        if (width < 640) {
          // Mobile devices (phones up to 639px wide):
          // Scale based on standard 390pt mobile design width, gently clamped
          // to ensure clear, readable typography on mobile without shrinking.
          final scale = (width / 390.0).clamp(0.95, 1.08);
          return fontSize * scale;
        } else {
          // Tablet & Desktop / Web:
          // Keep font sizes exact (1.0) to preserve the web design and prevent any grid overflows!
          return fontSize.toDouble();
        }
      },
      builder: (context, child) {
        return BlocBuilder<ThemeCubit, bool>(
          builder: (context, isDarkMode) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              home: const HomePage(),
            );
          },
        );
      },
    );
  }
}
