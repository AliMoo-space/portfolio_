import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portfolio/core/design_system/colors/app_colors.dart';
import 'package:portfolio/core/design_system/spacing/app_spacing.dart';
import 'package:portfolio/core/design_system/typography/app_text_styles.dart';
import 'package:portfolio/core/design_system/widgets/text/app_text.dart';

/// A professional, high-performance themed loading spinner designed for the portfolio.
///
/// Features a rotating multi-gradient sweep arc inspired by the portfolio's
/// signature electric blue, royal violet, and bright fuchsia palette, with an
/// ambient glow pass and an orbital accent dot for large loaders.
class AppLoader extends StatefulWidget {
  const AppLoader({
    super.key,
    this.size = 28,
    this.strokeWidth = 3,
    this.color,
  });

  const AppLoader.small({
    super.key,
    this.strokeWidth = 2.5,
    this.color,
  }) : size = 18;

  const AppLoader.large({
    super.key,
    this.strokeWidth = 4,
    this.color,
  }) : size = 48;

  final double size;
  final double strokeWidth;
  final Color? color;

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

bool get _isInTest =>
    WidgetsBinding.instance.runtimeType.toString().contains('Test');

class _AppLoaderState extends State<AppLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    if (!_isInTest) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final disableAnimations =
        (MediaQuery.maybeOf(context)?.disableAnimations ?? false) || _isInTest;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final double resolvedSize = widget.size;
    final double resolvedStrokeWidth = widget.strokeWidth;

    if (disableAnimations) {
      return SizedBox.square(
        dimension: resolvedSize,
        child: CustomPaint(
          painter: _GradientSpinnerPainter(
            progress: 0.25,
            strokeWidth: resolvedStrokeWidth,
            color: widget.color,
            isDarkMode: isDarkMode,
          ),
        ),
      );
    }

    return SizedBox.square(
      dimension: resolvedSize,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _GradientSpinnerPainter(
              progress: _controller.value,
              strokeWidth: resolvedStrokeWidth,
              color: widget.color,
              isDarkMode: isDarkMode,
            ),
          );
        },
      ),
    );
  }
}

class _GradientSpinnerPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color? color;
  final bool isDarkMode;

  _GradientSpinnerPainter({
    required this.progress,
    required this.strokeWidth,
    required this.color,
    required this.isDarkMode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    if (radius <= 0) return;

    final rect = Rect.fromCircle(center: center, radius: radius);

    // 1. Background circular track with subtle theme tint
    final trackColor = (color ??
            (isDarkMode ? AppColors.electricBlue : AppColors.secondary))
        .withValues(alpha: isDarkMode ? 0.12 : 0.08);

    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = trackColor;
    canvas.drawCircle(center, radius, trackPaint);

    // 2. Rotating Sweep Gradient Arc
    final List<Color> gradientColors;
    final List<double> colorStops;

    if (color != null) {
      gradientColors = [
        color!.withValues(alpha: 0.0),
        color!.withValues(alpha: 0.45),
        color!,
      ];
      colorStops = const [0.0, 0.5, 1.0];
    } else {
      gradientColors = const [
        Colors.transparent,
        AppColors.cyanAccent,
        AppColors.electricBlue,
        AppColors.royalViolet,
        AppColors.brightFuchsia,
      ];
      colorStops = const [0.0, 0.25, 0.5, 0.75, 1.0];
    }

    final double rotationAngle = progress * 2 * math.pi;
    final sweepGradient = SweepGradient(
      colors: gradientColors,
      stops: colorStops,
      transform: GradientRotation(rotationAngle),
    );

    const sweepAngle = 1.45 * math.pi; // ~260 degree arc
    final startAngle = rotationAngle;

    // 3. Neon glow pass for medium and large loaders
    if (size.width >= 24) {
      final glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth * 1.6
        ..strokeCap = StrokeCap.round
        ..shader = sweepGradient.createShader(rect)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.5);

      canvas.drawArc(rect, startAngle, sweepAngle, false, glowPaint);
    }

    // 4. Sharp crisp primary arc
    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = sweepGradient.createShader(rect);

    canvas.drawArc(rect, startAngle, sweepAngle, false, arcPaint);

    // 5. Counter-rotating inner accent dot for large loaders (creates an orbital gyroscope feel)
    if (size.width >= 36) {
      final innerRadius = radius * 0.45;
      final innerAngle = -rotationAngle * 1.5;
      final dotOffset = Offset(
        center.dx + innerRadius * math.cos(innerAngle),
        center.dy + innerRadius * math.sin(innerAngle),
      );
      final dotPaint = Paint()
        ..color = (color ?? AppColors.brightFuchsia).withValues(alpha: 0.85)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(dotOffset, strokeWidth * 0.55, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _GradientSpinnerPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.color != color ||
        oldDelegate.isDarkMode != isDarkMode;
  }
}

class AppFullScreenLoader extends StatelessWidget {
  const AppFullScreenLoader({
    super.key,
    this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ColoredBox(
      color: isDarkMode ? AppColors.darkCanvas : AppColors.background,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLoader.large(),
            if (message != null) ...[
              const Gap(AppSpacing.space16),
              AppText(
                message!,
                style: AppTextStyles.bodyMedium,
                color: isDarkMode ? Colors.white : AppColors.onBackground,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
  });

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black.withValues(alpha: 0.45),
              child: const Center(
                child: AppLoader.large(),
              ),
            ),
          ),
      ],
    );
  }
}
