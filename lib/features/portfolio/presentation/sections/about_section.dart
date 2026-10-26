import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/design_system/colors/app_colors.dart';
import '../../../../core/design_system/spacing/app_radius.dart';
import '../../../../core/design_system/spacing/app_spacing.dart';
import '../../../../core/design_system/typography/app_text_styles.dart';
import '../../../../core/design_system/widgets/layout/app_card.dart';
import '../../../../core/design_system/widgets/text/app_text.dart';

class _AboutHighlight {
  final IconData icon;
  final String title;
  final String description;

  const _AboutHighlight({
    required this.icon,
    required this.title,
    required this.description,
  });
}

const List<_AboutHighlight> _highlights = [
  _AboutHighlight(
    icon: Icons.architecture_rounded,
    title: 'Clean Architecture',
    description:
        'Scalable, maintainable, and testable code adhering to strict separation of concerns.',
  ),
  _AboutHighlight(
    icon: Icons.devices_rounded,
    title: 'Cross-Platform',
    description:
        'Pixel-perfect, natively compiled apps across iOS, Android, Web, and Desktop.',
  ),
  _AboutHighlight(
    icon: Icons.bolt_rounded,
    title: 'State Management',
    description:
        'Deterministic and reactive architecture using Bloc and Cubit patterns.',
  ),
  _AboutHighlight(
    icon: Icons.auto_awesome_rounded,
    title: 'UI/UX & Performance',
    description:
        'Smooth 60fps animations, intuitive interfaces, and optimized rendering.',
  ),
];

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 640;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final disableAnimations = MediaQuery.of(context).disableAnimations;

    final headerRow = Row(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => AppColors.heroGradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: AppText(
            'About Me',
            style: isMobile ? AppTextStyles.displaySmall : AppTextStyles.displayMedium,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: AppSpacing.space16),
        Expanded(
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.electricBlue.withValues(alpha: 0.6),
                  AppColors.royalViolet.withValues(alpha: 0.1),
                  Colors.transparent,
                ],
              ),
              borderRadius: BorderRadius.circular(AppRadius.radiusFull),
            ),
          ),
        ),
      ],
    );

    final bioCard = AppCard(
      backgroundColor: isDarkMode ? AppColors.darkCardContainer : Colors.white,
      borderRadius: AppRadius.radius20,
      border: Border.all(
        color: isDarkMode ? AppColors.darkBorder : AppColors.outlineVariant,
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: isDarkMode ? 0.25 : 0.04),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
      padding: EdgeInsets.all(isMobile ? AppSpacing.space20 : AppSpacing.space32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.space12,
                vertical: AppSpacing.space4,
              ),
              decoration: BoxDecoration(
                color: AppColors.electricBlue.withValues(
                  alpha: isDarkMode ? 0.15 : 0.1,
                ),
                borderRadius: BorderRadius.circular(AppRadius.radiusFull),
                border: Border.all(
                  color: AppColors.electricBlue.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.person_pin_rounded,
                    size: 16,
                    color: AppColors.electricBlue,
                  ),
                  const SizedBox(width: AppSpacing.space8),
                  Flexible(
                    child: AppText(
                      'Software Engineer & Mobile Specialist',
                      style: AppTextStyles.labelSmall,
                      color: AppColors.electricBlue,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space20),
          AppText(
            "Hello! My name is Ali Mohamed, and I am a passionate Flutter Developer. I specialize in building beautiful, highly performant, and responsive natively compiled applications for mobile, web, and desktop from a single codebase.\n\nI am extremely dedicated to continuous learning and implementing the latest best practices in the Flutter ecosystem. From state management mastery to creating smooth seamless micro-animations, I always strive for perfect UI/UX and solid architectural design in every single project.",
            style: isMobile ? AppTextStyles.bodyMedium : AppTextStyles.bodyLarge,
            color: isDarkMode ? AppColors.textInverse : AppColors.textPrimary,
            height: 1.7,
          ),
        ],
      ),
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.space24 : size.width * 0.1,
        vertical: isMobile ? AppSpacing.space64 : AppSpacing.space72,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (disableAnimations)
            headerRow
          else
            headerRow.animate().fade(duration: 600.ms).slideX(begin: -0.05),
          const SizedBox(height: AppSpacing.space32),
          if (disableAnimations)
            bioCard
          else
            bioCard
                .animate(delay: 150.ms)
                .fade(duration: 600.ms)
                .slideY(begin: 0.05),
          const SizedBox(height: AppSpacing.space24),
          _buildHighlightCards(
            context,
            isMobile,
            isDarkMode,
            disableAnimations,
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightCards(
    BuildContext context,
    bool isMobile,
    bool isDarkMode,
    bool disableAnimations,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final int columns = totalWidth >= 960 ? 4 : (totalWidth >= 560 ? 2 : 1);
        final cardWidth =
            (totalWidth - ((columns - 1) * AppSpacing.space16)) / columns;

        final cardsWrap = Wrap(
          spacing: AppSpacing.space16,
          runSpacing: AppSpacing.space16,
          children: _highlights.map((highlight) {
            return SizedBox(
              width: cardWidth,
              child: AppCard(
                backgroundColor:
                    isDarkMode ? AppColors.darkCardContainer : Colors.white,
                borderRadius: AppRadius.radius16,
                border: Border.all(
                  color: isDarkMode
                      ? AppColors.darkBorder
                      : AppColors.outlineVariant,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: isDarkMode ? 0.2 : 0.03,
                    ),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
                padding: const EdgeInsets.all(AppSpacing.space20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.radius12),
                        color: AppColors.electricBlue.withValues(
                          alpha: isDarkMode ? 0.15 : 0.1,
                        ),
                        border: Border.all(
                          color: AppColors.electricBlue.withValues(alpha: 0.25),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        highlight.icon,
                        color: AppColors.electricBlue,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space16),
                    AppText(
                      highlight.title,
                      style: AppTextStyles.titleMedium,
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : AppColors.textPrimary,
                    ),
                    const SizedBox(height: AppSpacing.space8),
                    AppText(
                      highlight.description,
                      style: AppTextStyles.bodySmall,
                      color: isDarkMode
                          ? AppColors.textInverse.withValues(alpha: 0.7)
                          : AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );

        if (disableAnimations) return cardsWrap;

        return cardsWrap
            .animate(delay: 250.ms)
            .fade(duration: 600.ms)
            .slideY(begin: 0.05);
      },
    );
  }
}
