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

class _ExperienceItem {
  final String company;
  final String role;
  final String period;
  final String location;
  final String description;
  final List<String> tags;

  const _ExperienceItem({
    required this.company,
    required this.role,
    required this.period,
    required this.location,
    required this.description,
    required this.tags,
  });
}

const List<_ExperienceItem> _experiences = [
  _ExperienceItem(
    company: 'Serv5',
    role: 'Flutter Developer',
    period: 'Aug 2026 – Present',
    location: 'Mansoura, Egypt',
    description:
        'Developing and maintaining Flutter features using Clean Architecture, BLoC/Cubit, and GetIt; integrating REST APIs with Dio, authentication interceptors, token refresh, and error handling; implementing location-based attendance and push/local notifications.',
    tags: [
      'Clean Architecture',
      'BLoC/Cubit',
      'GetIt',
      'Dio',
      'Token Refresh',
      'Location Attendance',
      'Push Notifications',
    ],
  ),
  _ExperienceItem(
    company: 'Growfet',
    role: 'Flutter Developer Intern',
    period: 'Oct 2025 – Jul 2026',
    location: 'Mansoura, Egypt',
    description:
        'Building feature-based Flutter modules using Clean Architecture and BLoC/Cubit; participating in code reviews, refactoring, and team workflows.',
    tags: [
      'Feature-Based',
      'Clean Architecture',
      'BLoC/Cubit',
      'Code Reviews',
      'Team Workflows',
    ],
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

    final headerWidget = isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => AppColors.heroGradient.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
                child: AppText(
                  'About Me',
                  style: AppTextStyles.sectionTitle(context),
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: AppSpacing.space12),
              Container(
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
            ],
          )
        : Row(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => AppColors.heroGradient.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
                child: AppText(
                  'About Me',
                  style: AppTextStyles.sectionTitle(context),
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
      padding: EdgeInsets.all(
        isMobile
            ? AppSpacing.space16
            : (size.width < 1024 ? AppSpacing.space24 : AppSpacing.space32),
      ),
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
                      'Flutter | Mobile Developer',
                      style: AppTextStyles.labelMedium.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      color: AppColors.electricBlue,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space16),
          AppText(
            'Computer Science graduate specializing in Flutter development, Dart, BLoC/Cubit, Clean Architecture, REST APIs, and Firebase. Focus on maintainable code and scalable, user-friendly applications.',
            style: isMobile
                ? AppTextStyles.bodyMedium.copyWith(fontSize: 15.0)
                : AppTextStyles.bodyLarge,
            color: isDarkMode ? AppColors.textInverse : AppColors.textPrimary,
            height: 1.65,
          ),
        ],
      ),
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile
            ? (size.width < 360 ? 12.0 : 20.0)
            : (size.width < 1024 ? size.width * 0.06 : size.width * 0.1),
        vertical: isMobile ? AppSpacing.space48 : AppSpacing.space72,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (disableAnimations)
            headerWidget
          else
            headerWidget.animate().fade(duration: 600.ms).slideX(begin: -0.05),
          SizedBox(height: isMobile ? AppSpacing.space24 : AppSpacing.space32),
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
          SizedBox(height: isMobile ? AppSpacing.space32 : AppSpacing.space48),
          _buildExperienceSection(
            context,
            isMobile,
            isDarkMode,
            disableAnimations,
          ),
          SizedBox(height: isMobile ? AppSpacing.space32 : AppSpacing.space48),
          _buildEducationAndTrainingSection(
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
        final int columns =
            totalWidth >= 960 ? 4 : (totalWidth >= 560 ? 2 : 1);
        final cardWidth =
            (totalWidth - ((columns - 1) * AppSpacing.space16)) / columns;

        final cardsWrap = Wrap(
          spacing: AppSpacing.space16,
          runSpacing: AppSpacing.space16,
          children: _highlights.map((highlight) {
            final iconWidget = Container(
              width: isMobile ? 40 : 44,
              height: isMobile ? 40 : 44,
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
                size: isMobile ? 20 : 22,
              ),
            );

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
                padding: EdgeInsets.all(
                  isMobile ? AppSpacing.space16 : AppSpacing.space20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isMobile)
                      Row(
                        children: [
                          iconWidget,
                          const SizedBox(width: AppSpacing.space12),
                          Expanded(
                            child: AppText(
                              highlight.title,
                              style: AppTextStyles.titleMedium.copyWith(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                              fontWeight: FontWeight.w700,
                              color: isDarkMode
                                  ? Colors.white
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      )
                    else ...[
                      iconWidget,
                      const SizedBox(height: AppSpacing.space16),
                      AppText(
                        highlight.title,
                        style: AppTextStyles.titleMedium.copyWith(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w700,
                        ),
                        fontWeight: FontWeight.w700,
                        color: isDarkMode
                            ? Colors.white
                            : AppColors.textPrimary,
                      ),
                    ],
                    const SizedBox(height: AppSpacing.space8),
                    AppText(
                      highlight.description,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: isMobile ? 13.5 : 14.0,
                        height: 1.55,
                      ),
                      color: isDarkMode
                          ? const Color(0xFFCBD5E1)
                          : AppColors.textSecondary,
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

  Widget _buildExperienceSection(
    BuildContext context,
    bool isMobile,
    bool isDarkMode,
    bool disableAnimations,
  ) {
    final titlePill = Container(
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
            Icons.business_center_rounded,
            size: 16,
            color: AppColors.electricBlue,
          ),
          const SizedBox(width: AppSpacing.space8),
          Flexible(
            child: AppText(
              'Work Experience',
              style: AppTextStyles.labelMedium.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              color: AppColors.electricBlue,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titlePill,
        const SizedBox(height: AppSpacing.space16),
        ..._experiences.map((exp) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.space16),
            child: AppCard(
              backgroundColor:
                  isDarkMode ? AppColors.darkCardContainer : Colors.white,
              borderRadius: AppRadius.radius20,
              border: Border.all(
                color: isDarkMode
                    ? AppColors.darkBorder
                    : AppColors.outlineVariant,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: isDarkMode ? 0.25 : 0.04,
                  ),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
              padding: EdgeInsets.all(
                isMobile ? AppSpacing.space16 : AppSpacing.space24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isMobile) ...[
                    AppText(
                      exp.role,
                      style: AppTextStyles.titleMedium.copyWith(
                        fontSize: 16.5,
                        fontWeight: FontWeight.bold,
                      ),
                      fontWeight: FontWeight.bold,
                      color: isDarkMode
                          ? Colors.white
                          : AppColors.textPrimary,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.space8,
                        vertical: AppSpacing.space4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.royalViolet.withValues(
                          alpha: isDarkMode ? 0.2 : 0.1,
                        ),
                        borderRadius:
                            BorderRadius.circular(AppRadius.radiusFull),
                        border: Border.all(
                          color: AppColors.royalViolet
                              .withValues(alpha: 0.3),
                        ),
                      ),
                      child: AppText(
                        exp.period,
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                        color: isDarkMode
                            ? Colors.white
                            : AppColors.royalViolet,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space8),
                    Wrap(
                      spacing: AppSpacing.space12,
                      runSpacing: AppSpacing.space4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.business_rounded,
                              size: 15,
                              color: AppColors.electricBlue,
                            ),
                            const SizedBox(width: AppSpacing.space4),
                            AppText(
                              exp.company,
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w600,
                              ),
                              fontWeight: FontWeight.w600,
                              color: AppColors.electricBlue,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 15,
                              color: isDarkMode
                                  ? const Color(0xFF94A3B8)
                                  : AppColors.textSecondary,
                            ),
                            const SizedBox(width: AppSpacing.space4),
                            AppText(
                              exp.location,
                              style: AppTextStyles.bodySmall.copyWith(
                                fontSize: 13.0,
                              ),
                              color: isDarkMode
                                  ? const Color(0xFF94A3B8)
                                  : AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ] else ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                exp.role,
                                style: AppTextStyles.titleLarge,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode
                                    ? Colors.white
                                    : AppColors.textPrimary,
                              ),
                              const SizedBox(height: AppSpacing.space4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.business_rounded,
                                    size: 15,
                                    color: AppColors.electricBlue,
                                  ),
                                  const SizedBox(width: AppSpacing.space4),
                                  AppText(
                                    exp.company,
                                    style: AppTextStyles.bodyMedium,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.electricBlue,
                                  ),
                                  const SizedBox(width: AppSpacing.space12),
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 15,
                                    color: isDarkMode
                                        ? Colors.white60
                                        : AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: AppSpacing.space4),
                                  Flexible(
                                    child: AppText(
                                      exp.location,
                                      style: AppTextStyles.bodySmall,
                                      color: isDarkMode
                                          ? Colors.white60
                                          : AppColors.textSecondary,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.space12,
                            vertical: AppSpacing.space4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.royalViolet.withValues(
                              alpha: isDarkMode ? 0.2 : 0.1,
                            ),
                            borderRadius:
                                BorderRadius.circular(AppRadius.radiusFull),
                            border: Border.all(
                              color: AppColors.royalViolet
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          child: AppText(
                            exp.period,
                            style: AppTextStyles.labelSmall.copyWith(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                            color: isDarkMode
                                ? Colors.white
                                : AppColors.royalViolet,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: AppSpacing.space16),
                  AppText(
                    exp.description,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontSize: isMobile ? 14.0 : 15.0,
                      height: 1.6,
                    ),
                    color: isDarkMode
                        ? const Color(0xFFCBD5E1)
                        : AppColors.textSecondary,
                    height: 1.6,
                  ),
                  const SizedBox(height: AppSpacing.space16),
                  Wrap(
                    spacing: AppSpacing.space8,
                    runSpacing: AppSpacing.space8,
                    children: exp.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: (isDarkMode ? Colors.white : Colors.black)
                              .withValues(alpha: 0.05),
                          borderRadius:
                              BorderRadius.circular(AppRadius.radiusFull),
                          border: Border.all(
                            color: isDarkMode
                                ? AppColors.darkBorder
                                : AppColors.outlineVariant,
                          ),
                        ),
                        child: AppText(
                          tag,
                          style: AppTextStyles.labelSmall.copyWith(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                          color: isDarkMode
                              ? const Color(0xFFE2E8F0)
                              : AppColors.textSecondary,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );

    if (disableAnimations) return content;

    return content
        .animate(delay: 300.ms)
        .fade(duration: 600.ms)
        .slideY(begin: 0.05);
  }

  Widget _buildEducationAndTrainingSection(
    BuildContext context,
    bool isMobile,
    bool isDarkMode,
    bool disableAnimations,
  ) {
    final titlePill = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space12,
        vertical: AppSpacing.space4,
      ),
      decoration: BoxDecoration(
        color: AppColors.royalViolet.withValues(
          alpha: isDarkMode ? 0.15 : 0.1,
        ),
        borderRadius: BorderRadius.circular(AppRadius.radiusFull),
        border: Border.all(
          color: AppColors.royalViolet.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.school_rounded,
            size: 16,
            color: AppColors.royalViolet,
          ),
          const SizedBox(width: AppSpacing.space8),
          Flexible(
            child: AppText(
              'Education, Training & Languages',
              style: AppTextStyles.labelMedium.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              color: AppColors.royalViolet,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );

    final educationCard = AppCard(
      backgroundColor:
          isDarkMode ? AppColors.darkCardContainer : Colors.white,
      borderRadius: AppRadius.radius20,
      border: Border.all(
        color: isDarkMode ? AppColors.darkBorder : AppColors.outlineVariant,
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: isDarkMode ? 0.25 : 0.04),
          blurRadius: 14,
          offset: const Offset(0, 4),
        ),
      ],
      padding: EdgeInsets.all(
        isMobile ? AppSpacing.space16 : AppSpacing.space24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.radius12),
                  color: AppColors.electricBlue.withValues(
                    alpha: isDarkMode ? 0.2 : 0.1,
                  ),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: AppColors.electricBlue,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.space12),
              Expanded(
                child: AppText(
                  'Education',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontSize: isMobile ? 16.5 : 17.5,
                    fontWeight: FontWeight.bold,
                  ),
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space16),
          AppText(
            'B.Sc. Computer Science — Information Systems',
            style: AppTextStyles.titleSmall.copyWith(
              fontSize: isMobile ? 15.0 : 15.5,
              fontWeight: FontWeight.w700,
            ),
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : AppColors.textPrimary,
          ),
          const SizedBox(height: AppSpacing.space4),
          AppText(
            'Kafr El-Sheikh University',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: isMobile ? 14.0 : 14.5,
              fontWeight: FontWeight.w600,
            ),
            fontWeight: FontWeight.w500,
            color: AppColors.electricBlue,
          ),
          const SizedBox(height: AppSpacing.space2),
          AppText(
            '2022 – 2026 • Egypt',
            style: AppTextStyles.bodySmall.copyWith(fontSize: 13.0),
            color: isDarkMode
                ? const Color(0xFF94A3B8)
                : AppColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.space24),
          Divider(
            color: isDarkMode ? AppColors.darkBorder : AppColors.outlineVariant,
            height: 1,
          ),
          const SizedBox(height: AppSpacing.space20),
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.radius12),
                  color: AppColors.royalViolet.withValues(
                    alpha: isDarkMode ? 0.2 : 0.1,
                  ),
                ),
                child: const Icon(
                  Icons.translate_rounded,
                  color: AppColors.royalViolet,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.space12),
              Expanded(
                child: AppText(
                  'Languages',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontSize: isMobile ? 16.5 : 17.5,
                    fontWeight: FontWeight.bold,
                  ),
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.space12),
                  decoration: BoxDecoration(
                    color: (isDarkMode ? Colors.white : Colors.black)
                        .withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(AppRadius.radius12),
                    border: Border.all(
                      color: isDarkMode
                          ? AppColors.darkBorder
                          : AppColors.outlineVariant,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'Arabic',
                        style: AppTextStyles.titleSmall,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : AppColors.textPrimary,
                      ),
                      const SizedBox(height: AppSpacing.space2),
                      AppText(
                        'Native',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                        ),
                        color: AppColors.electricBlue,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.space12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.space12),
                  decoration: BoxDecoration(
                    color: (isDarkMode ? Colors.white : Colors.black)
                        .withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(AppRadius.radius12),
                    border: Border.all(
                      color: isDarkMode
                          ? AppColors.darkBorder
                          : AppColors.outlineVariant,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'English',
                        style: AppTextStyles.titleSmall,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : AppColors.textPrimary,
                      ),
                      const SizedBox(height: AppSpacing.space2),
                      AppText(
                        'Intermediate',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                        ),
                        color: AppColors.royalViolet,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final trainingCard = AppCard(
      backgroundColor:
          isDarkMode ? AppColors.darkCardContainer : Colors.white,
      borderRadius: AppRadius.radius20,
      border: Border.all(
        color: isDarkMode ? AppColors.darkBorder : AppColors.outlineVariant,
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: isDarkMode ? 0.25 : 0.04),
          blurRadius: 14,
          offset: const Offset(0, 4),
        ),
      ],
      padding: EdgeInsets.all(
        isMobile ? AppSpacing.space16 : AppSpacing.space24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.radius12),
                  color: AppColors.electricBlue.withValues(
                    alpha: isDarkMode ? 0.2 : 0.1,
                  ),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: AppColors.electricBlue,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.space12),
              Expanded(
                child: AppText(
                  'Training & Certifications',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontSize: isMobile ? 16.0 : 17.5,
                    fontWeight: FontWeight.bold,
                  ),
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space16),
          _buildTrainingItem(
            title: 'ITI Summer Internship — Flutter Track',
            period: 'Jul – Aug 2025',
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: AppSpacing.space12),
          _buildTrainingItem(
            title: 'Flutter Intensive Training — Tharwat Samy',
            period: 'Mar – Jun 2025',
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: AppSpacing.space12),
          _buildTrainingItem(
            title: 'Complete Flutter & Dart Development Course',
            period: 'Sep 2024',
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titlePill,
        const SizedBox(height: AppSpacing.space16),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 768) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: educationCard),
                  const SizedBox(width: AppSpacing.space20),
                  Expanded(child: trainingCard),
                ],
              );
            }
            return Column(
              children: [
                educationCard,
                const SizedBox(height: AppSpacing.space20),
                trainingCard,
              ],
            );
          },
        ),
      ],
    );

    if (disableAnimations) return content;

    return content
        .animate(delay: 350.ms)
        .fade(duration: 600.ms)
        .slideY(begin: 0.05);
  }

  Widget _buildTrainingItem({
    required String title,
    required String period,
    required bool isDarkMode,
  }) {
    return Builder(
      builder: (context) {
        final isMobile = MediaQuery.of(context).size.width < 640;
        return Container(
          padding: const EdgeInsets.all(AppSpacing.space12),
          decoration: BoxDecoration(
            color: (isDarkMode ? Colors.white : Colors.black).withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(AppRadius.radius12),
            border: Border.all(
              color: isDarkMode ? AppColors.darkBorder : AppColors.outlineVariant,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.check_circle_outline_rounded,
                  color: AppColors.electricBlue,
                  size: 16,
                ),
              ),
              const SizedBox(width: AppSpacing.space8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      title,
                      style: AppTextStyles.titleSmall.copyWith(
                        fontSize: isMobile ? 14.5 : 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : AppColors.textPrimary,
                    ),
                    const SizedBox(height: AppSpacing.space2),
                    AppText(
                      period,
                      style: AppTextStyles.labelSmall.copyWith(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                      ),
                      color: AppColors.royalViolet,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
