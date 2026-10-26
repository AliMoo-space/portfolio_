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
}
