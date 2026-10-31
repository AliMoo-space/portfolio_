import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/core/theme/theme_cubit.dart';
import 'package:portfolio/core/di/injection.dart' as di;
import 'package:portfolio/features/portfolio/presentation/screens/home_page.dart';
import 'package:portfolio/features/portfolio/presentation/sections/hero_section.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await di.init(preferences: prefs);
  });

  Widget buildTestApp() {
    return BlocProvider.value(
      value: di.sl<ThemeCubit>(),
      child: const PortfolioApp(),
    );
  }

  const testViewports = [
    // Mobile Breakpoints
    Size(320, 640), // Ultra-compact mobile
    Size(360, 780), // Standard Android
    Size(375, 812), // Standard iPhone
    Size(414, 896), // Large Mobile / Phablet
    // Tablet Breakpoints
    Size(768, 1024), // iPad Mini / Standard Tablet
    Size(820, 1180), // iPad Air / Pro
    // Desktop / Web Breakpoints
    Size(1200, 800), // Laptop / Small Desktop
    Size(1440, 900), // Standard Desktop
    Size(1920, 1080), // Full HD Desktop
  ];

  for (final size in testViewports) {
    testWidgets('Renders without overflow at ${size.width}x${size.height} in light theme', (tester) async {
      tester.view.physicalSize = Size(size.width, size.height);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final themeCubit = di.sl<ThemeCubit>();
      if (themeCubit.state) {
        themeCubit.toggleTheme(); // switch to light
      }

      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);

      // Verify DownloadCvButton height
      final cvButtonFinder = find.byType(DownloadCvButton);
      if (cvButtonFinder.evaluate().isNotEmpty) {
        final buttonSize = tester.getSize(cvButtonFinder);
        final expectedHeight = size.width < 640 ? 48.0 : 54.0;
        expect(buttonSize.height, equals(expectedHeight));
      }

      // Verify ProfilePhotoHero dimension is healthy and not shrunken by screenutil
      final heroPhotoFinder = find.byType(ProfilePhotoHero);
      if (heroPhotoFinder.evaluate().isNotEmpty) {
        final photoSize = tester.getSize(heroPhotoFinder);
        if (size.width < 640) {
          expect(photoSize.width, greaterThanOrEqualTo(100.0));
          expect(photoSize.height, greaterThanOrEqualTo(100.0));
        } else if (size.width >= 1024) {
          expect(photoSize.width, greaterThanOrEqualTo(200.0));
          expect(photoSize.height, greaterThanOrEqualTo(200.0));
        }
      }
    });

    testWidgets('Renders without overflow at ${size.width}x${size.height} in dark theme', (tester) async {
      tester.view.physicalSize = Size(size.width, size.height);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final themeCubit = di.sl<ThemeCubit>();
      if (!themeCubit.state) {
        themeCubit.toggleTheme(); // switch to dark
      }

      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);

      // Verify DownloadCvButton height
      final cvButtonFinder = find.byType(DownloadCvButton);
      if (cvButtonFinder.evaluate().isNotEmpty) {
        final buttonSize = tester.getSize(cvButtonFinder);
        final expectedHeight = size.width < 640 ? 48.0 : 54.0;
        expect(buttonSize.height, equals(expectedHeight));
      }

      // Verify ProfilePhotoHero dimension is healthy and not shrunken by screenutil
      final heroPhotoFinder = find.byType(ProfilePhotoHero);
      if (heroPhotoFinder.evaluate().isNotEmpty) {
        final photoSize = tester.getSize(heroPhotoFinder);
        if (size.width < 640) {
          expect(photoSize.width, greaterThanOrEqualTo(100.0));
          expect(photoSize.height, greaterThanOrEqualTo(100.0));
        } else if (size.width >= 1024) {
          expect(photoSize.width, greaterThanOrEqualTo(200.0));
          expect(photoSize.height, greaterThanOrEqualTo(200.0));
        }
      }
    });
  }
}
