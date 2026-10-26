import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/core/theme/theme_cubit.dart';
import 'package:portfolio/core/di/injection.dart' as di;
import 'package:portfolio/features/portfolio/presentation/screens/home_page.dart';
import 'package:portfolio/features/portfolio/presentation/widgets/navbar.dart';
import 'package:portfolio/features/portfolio/presentation/sections/hero_section.dart';
import 'package:portfolio/features/portfolio/presentation/sections/about_section.dart';
import 'package:portfolio/features/portfolio/presentation/sections/skills_section.dart';
import 'package:portfolio/features/portfolio/presentation/sections/projects_section.dart';
import 'package:portfolio/features/portfolio/presentation/sections/contact_section.dart';
import 'package:portfolio/core/design_system/widgets/feedback/app_error_state.dart';
import 'package:portfolio/features/portfolio/data/models/project_model.dart';
import 'package:portfolio/core/design_system/theme/app_theme.dart';

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

  testWidgets('Portfolio app renders basic shell and HomePage', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.byType(PortfolioApp), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(NavBar), findsOneWidget);
    expect(find.byType(HeroSection), findsOneWidget);
    expect(find.byType(AboutSection), findsOneWidget);
    expect(find.byType(SkillsSection), findsOneWidget);
    expect(find.byType(ProjectsSection), findsOneWidget);
    expect(find.byType(ContactSection), findsOneWidget);
  });

  testWidgets('Renders properly on Mobile breakpoint (375x812)', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Renders properly on Tablet breakpoint (768x1024)', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(768, 1024);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Renders properly on Desktop breakpoint (1440x900)', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Theme switching toggles light and dark modes', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    final themeCubit = di.sl<ThemeCubit>();
    final initialTheme = themeCubit.state;

    // Toggle theme
    themeCubit.toggleTheme();
    await tester.pumpAndSettle();

    expect(themeCubit.state, equals(!initialTheme));

    // Toggle back
    themeCubit.toggleTheme();
    await tester.pumpAndSettle();

    expect(themeCubit.state, equals(initialTheme));
  });

  testWidgets('Reduced-motion accessibility renders without animation errors', (WidgetTester tester) async {
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('ProjectsSection displays error state when API fails in test environment', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.byType(AppErrorState), findsOneWidget);
  });

  testWidgets('ProjectCard renders project with image asset and Google Play badge', (WidgetTester tester) async {
    const projectWithImage = ProjectModel(
      name: 'workwise',
      description: 'HR Management Application',
      language: 'Dart',
      htmlUrl: 'https://github.com/AliMoo-space/workwise',
      fork: true,
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.alimohamed.workwise',
      imageAsset: 'assets/workwise.jpg',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 400,
            height: 420,
            child: ProjectCard(project: projectWithImage),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('workwise'), findsOneWidget);
    expect(find.text('Google Play'), findsWidgets);
    expect(find.text('Forked Repo'), findsOneWidget);
    expect(find.text('Dart'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('ProjectCard renders fallback placeholder for project without image', (WidgetTester tester) async {
    const projectWithoutImage = ProjectModel(
      name: 'Trendora',
      description: 'E-Commerce Application',
      language: 'Dart',
      htmlUrl: 'https://github.com/AliMoo-space/Trendora',
      fork: false,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 400,
            height: 420,
            child: ProjectCard(project: projectWithoutImage),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Trendora'), findsOneWidget);
    expect(find.text('E-Commerce App'), findsOneWidget);
    expect(find.byType(Image), findsNothing);
    expect(find.byIcon(Icons.shopping_bag_outlined), findsOneWidget);
  });

  testWidgets('SkillsSection renders all featured skill cards and category groups', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: SkillsSection(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('My Skills'), findsOneWidget);
    expect(find.text('FEATURED CORE STACK'), findsOneWidget);
    expect(find.text('DOMAINS & COMPETENCIES'), findsOneWidget);

    // Featured skills
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Dart'), findsWidgets);
    expect(find.text('BLoC / Cubit'), findsOneWidget);
    expect(find.text('Clean Architecture'), findsWidgets);

    // Categories
    expect(find.text('Architecture & Principles'), findsOneWidget);
    expect(find.text('State Management & Routing'), findsOneWidget);
    expect(find.text('Networking & APIs'), findsOneWidget);
    expect(find.text('Cloud & Local Storage'), findsOneWidget);
    expect(find.text('UI & Native Capabilities'), findsOneWidget);
    expect(find.text('Tools & Development'), findsOneWidget);
  });

  testWidgets('DownloadCvButton maintains identical dimensions between Light and Dark themes', (WidgetTester tester) async {
    // 1. Measure in Light Theme
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: Center(
            child: DownloadCvButton(
              onTap: () {},
              isDarkMode: false,
              disableAnimations: true,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final lightButtonFinder = find.byType(DownloadCvButton);
    expect(lightButtonFinder, findsOneWidget);
    final lightSize = tester.getSize(lightButtonFinder);

    // 2. Measure in Dark Theme
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: Scaffold(
          body: Center(
            child: DownloadCvButton(
              onTap: () {},
              isDarkMode: true,
              disableAnimations: true,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final darkButtonFinder = find.byType(DownloadCvButton);
    expect(darkButtonFinder, findsOneWidget);
    final darkSize = tester.getSize(darkButtonFinder);

    // Dimensions must be 100% identical
    expect(lightSize.height, equals(darkSize.height));
    expect(lightSize.width, equals(darkSize.width));
    expect(lightSize.height, equals(54.0));
  });

  testWidgets('DownloadCvButton maintains identical dimensions on mobile breakpoint', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: Center(
            child: DownloadCvButton(
              onTap: () {},
              isMobile: true,
              isDarkMode: false,
              disableAnimations: true,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final mobileLightSize = tester.getSize(find.byType(DownloadCvButton));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        home: Scaffold(
          body: Center(
            child: DownloadCvButton(
              onTap: () {},
              isMobile: true,
              isDarkMode: true,
              disableAnimations: true,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final mobileDarkSize = tester.getSize(find.byType(DownloadCvButton));

    expect(mobileLightSize.height, equals(mobileDarkSize.height));
    expect(mobileLightSize.width, equals(mobileDarkSize.width));
    expect(mobileLightSize.height, equals(48.0));
  });

  testWidgets('DownloadCvButton maintains identical dimensions when hovered and triggers onTap', (WidgetTester tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: Center(
            child: DownloadCvButton(
              onTap: () => tapped = true,
              isDarkMode: false,
              disableAnimations: false,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final buttonFinder = find.byType(DownloadCvButton);
    final initialSize = tester.getSize(buttonFinder);

    // Simulate mouse hover
    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: Offset.zero);
    addTearDown(gesture.removePointer);

    await gesture.moveTo(tester.getCenter(buttonFinder));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));

    // Size must not shift on hover
    final hoveredSize = tester.getSize(buttonFinder);
    expect(hoveredSize.height, equals(initialSize.height));
    expect(hoveredSize.width, equals(initialSize.width));

    // Test tap
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();
    expect(tapped, isTrue);
  });
}

