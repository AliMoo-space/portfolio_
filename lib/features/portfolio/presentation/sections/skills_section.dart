import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/design_system/colors/app_colors.dart';
import '../../../../core/design_system/spacing/app_radius.dart';
import '../../../../core/design_system/spacing/app_spacing.dart';
import '../../../../core/design_system/typography/app_text_styles.dart';
import '../../../../core/design_system/widgets/layout/app_card.dart';
import '../../../../core/design_system/widgets/text/app_text.dart';

class SkillCategory {
  final String title;
  final IconData icon;
  final List<String> skills;

  const SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
  });
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  final List<Map<String, dynamic>> featuredSkills = const [
    {'name': 'Flutter', 'icon': Icons.flutter_dash, 'isFa': false},
    {'name': 'Dart', 'icon': Icons.code, 'isFa': false},
    {'name': 'BLoC / Cubit', 'icon': Icons.bolt_rounded, 'isFa': false},
    {
      'name': 'Clean Architecture',
      'icon': Icons.architecture_rounded,
      'isFa': false,
    },
    {'name': 'REST APIs & Dio', 'icon': Icons.api_rounded, 'isFa': false},
    {
      'name': 'Firebase & FCM',
      'icon': Icons.local_fire_department_rounded,
      'isFa': false,
    },
    {
      'name': 'Git & GitHub',
      'icon': FontAwesomeIcons.github,
      'isFa': true,
    },
    {
      'name': 'Google Maps & GPS',
      'icon': Icons.location_on_rounded,
      'isFa': false,
    },
  ];

  final List<SkillCategory> categories = const [
    SkillCategory(
      title: 'Architecture & Principles',
      icon: Icons.architecture_rounded,
      skills: [
        'Dart',
        'OOP',
        'SOLID',
        'Clean Architecture',
        'Feature-based Architecture',
      ],
    ),
    SkillCategory(
      title: 'State Management & Routing',
      icon: Icons.alt_route_rounded,
      skills: ['BLoC', 'Cubit', 'GetIt', 'GoRouter'],
    ),
    SkillCategory(
      title: 'Networking & APIs',
      icon: Icons.cloud_sync_rounded,
      skills: [
        'REST APIs',
        'Dio',
        'JSON Parsing',
        'Interceptors',
        'Token Refresh',
        'Error Handling',
      ],
    ),
    SkillCategory(
      title: 'Cloud & Local Storage',
      icon: Icons.storage_rounded,
      skills: [
        'Firebase Authentication',
        'FCM',
        'Supabase',
        'Hive',
        'SharedPreferences',
        'Flutter Secure Storage',
      ],
    ),
    SkillCategory(
      title: 'UI & Native Capabilities',
      icon: Icons.devices_rounded,
      skills: [
        'Responsive/Adaptive UI',
        'Localization',
        'Material Design',
        'GPS/Location',
        'Google Maps',
        'Push/Local Notifications',
      ],
    ),
    SkillCategory(
      title: 'Tools & Development',
      icon: Icons.terminal_rounded,
      skills: [
        'Git',
        'GitHub',
        'Postman',
        'VS Code',
        'Android Studio',
        'Xcode',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 640;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final disableAnimations = MediaQuery.of(context).disableAnimations;

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
          _buildHeader(context, isMobile, isDarkMode, disableAnimations),
          const SizedBox(height: AppSpacing.space16),
          _buildPill(isDarkMode, disableAnimations),
          SizedBox(height: isMobile ? AppSpacing.space32 : AppSpacing.space40),
          _buildSubSectionHeader(
            label: 'FEATURED CORE STACK',
            icon: Icons.stars_rounded,
            isDarkMode: isDarkMode,
            disableAnimations: disableAnimations,
          ),
          const SizedBox(height: AppSpacing.space20),
          _buildFeaturedGrid(isMobile, isDarkMode, disableAnimations),
          SizedBox(height: isMobile ? AppSpacing.space32 : AppSpacing.space48),
          _buildSubSectionHeader(
            label: 'DOMAINS & COMPETENCIES',
            icon: Icons.hub_rounded,
            badge: '31 Technologies',
            isDarkMode: isDarkMode,
            disableAnimations: disableAnimations,
          ),
          const SizedBox(height: AppSpacing.space20),
          _buildCategorizedSkills(
            context,
            isMobile,
            isDarkMode,
            disableAnimations,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    bool isMobile,
    bool isDarkMode,
    bool disableAnimations,
  ) {
    final titleWidget = ShaderMask(
      shaderCallback: (bounds) => AppColors.heroGradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: AppText(
        'My Skills',
        style: AppTextStyles.sectionTitle(context),
        color: Colors.white,
      ),
    );

    final dividerWidget = Container(
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
    );

    final header = isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleWidget,
              const SizedBox(height: AppSpacing.space12),
              dividerWidget,
            ],
          )
        : Row(
            children: [
              Flexible(child: titleWidget),
              const SizedBox(width: AppSpacing.space16),
              Expanded(child: dividerWidget),
            ],
          );

    if (disableAnimations) return header;

    return header.animate().fade(duration: 600.ms).slideX(begin: -0.05);
  }

  Widget _buildPill(bool isDarkMode, bool disableAnimations) {
    final pill = Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.space12,
          vertical: AppSpacing.space4,
        ),
        decoration: BoxDecoration(
          color: AppColors.royalViolet.withValues(
            alpha: isDarkMode ? 0.15 : 0.08,
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
              Icons.code_rounded,
              size: 16,
              color: AppColors.royalViolet,
            ),
            const SizedBox(width: AppSpacing.space8),
            Flexible(
              child: AppText(
                'Core Tech Stack & Engineering Competencies',
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
      ),
    );

    if (disableAnimations) return pill;

    return pill.animate(delay: 100.ms).fade(duration: 500.ms);
  }

  Widget _buildSubSectionHeader({
    required String label,
    required IconData icon,
    String? badge,
    required bool isDarkMode,
    required bool disableAnimations,
  }) {
    final widget = Row(
      children: [
        Container(
          width: 3,
          height: 18,
          decoration: BoxDecoration(
            gradient: AppColors.heroGradient,
            borderRadius: BorderRadius.circular(AppRadius.radiusFull),
          ),
        ),
        const SizedBox(width: AppSpacing.space8),
        Icon(
          icon,
          size: 17,
          color: isDarkMode ? AppColors.cyanAccent : AppColors.electricBlue,
        ),
        const SizedBox(width: AppSpacing.space8),
        Expanded(
          child: AppText(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
            color: isDarkMode ? AppColors.cyanAccent : AppColors.electricBlue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (badge != null) ...[
          const SizedBox(width: AppSpacing.space4),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 7,
              vertical: AppSpacing.space2,
            ),
            decoration: BoxDecoration(
              color: AppColors.royalViolet.withValues(
                alpha: isDarkMode ? 0.2 : 0.08,
              ),
              borderRadius: BorderRadius.circular(AppRadius.radiusFull),
              border: Border.all(
                color: AppColors.royalViolet.withValues(alpha: 0.3),
              ),
            ),
            child: AppText(
              badge,
              style: AppTextStyles.labelSmall.copyWith(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
              ),
              color: isDarkMode ? const Color(0xFFE2E8F0) : AppColors.royalViolet,
            ),
          ),
        ],
      ],
    );

    if (disableAnimations) return widget;

    return widget.animate().fade(duration: 400.ms);
  }

  Widget _buildFeaturedGrid(
    bool isMobile,
    bool isDarkMode,
    bool disableAnimations,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final int crossAxisCount = totalWidth >= 780 ? 4 : 2;
        final double mainAxisExtent = crossAxisCount == 4
            ? 152.0
            : (totalWidth < 360 ? 150.0 : 148.0);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSpacing.space16,
            mainAxisSpacing: AppSpacing.space16,
            mainAxisExtent: mainAxisExtent,
          ),
          itemCount: featuredSkills.length,
          itemBuilder: (context, index) {
            final skill = featuredSkills[index];
            final card = SkillCard(
              name: skill['name'] as String,
              icon: skill['icon'],
              isFa: skill['isFa'] ?? false,
            );

            if (disableAnimations) return card;

            return card
                .animate(delay: (60 * index).ms)
                .fade(duration: 400.ms)
                .scale(begin: const Offset(0.94, 0.94));
          },
        );
      },
    );
  }

  Widget _buildCategorizedSkills(
    BuildContext context,
    bool isMobile,
    bool isDarkMode,
    bool disableAnimations,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;

        if (totalWidth < 680) {
          // Mobile: Vertical flow for clean, non-clipped cards with zero wasted space
          return Column(
            children: categories.asMap().entries.map((entry) {
              final index = entry.key;
              final category = entry.value;
              final card = Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.space16),
                child: _CategoryCard(
                  category: category,
                  isDarkMode: isDarkMode,
                  disableAnimations: disableAnimations,
                ),
              );

              if (disableAnimations) return card;

              return card
                  .animate(delay: (70 * index).ms)
                  .fade(duration: 450.ms)
                  .slideY(begin: 0.05);
            }).toList(),
          );
        }

        // Tablet & Desktop: Balanced multi-column grid with aligned height
        final int columns = totalWidth >= 1080 ? 3 : 2;
        final double mainAxisExtent = totalWidth >= 1080 ? 335.0 : 345.0;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: AppSpacing.space20,
            mainAxisSpacing: AppSpacing.space20,
            mainAxisExtent: mainAxisExtent,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final card = _CategoryCard(
              category: category,
              isDarkMode: isDarkMode,
              disableAnimations: disableAnimations,
            );

            if (disableAnimations) return card;

            return card
                .animate(delay: (70 * index).ms)
                .fade(duration: 450.ms)
                .slideY(begin: 0.05);
          },
        );
      },
    );
  }
}

class SkillCard extends StatefulWidget {
  final String name;
  final dynamic icon;
  final bool isFa;

  const SkillCard({
    super.key,
    required this.name,
    required this.icon,
    this.isFa = false,
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 640;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final disableAnimations = MediaQuery.of(context).disableAnimations;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: (!disableAnimations && isHovered)
            ? Matrix4.translationValues(0.0, -5.0, 0.0)
            : Matrix4.identity(),
        child: AppCard(
          borderRadius: AppRadius.radius20,
          backgroundColor:
              isDarkMode ? AppColors.darkCardContainer : Colors.white,
          border: Border.all(
            color: isHovered
                ? AppColors.electricBlue
                : (isDarkMode ? AppColors.darkBorder : AppColors.outlineVariant),
            width: isHovered ? 1.5 : 1.0,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: AppColors.electricBlue.withValues(
                      alpha: isDarkMode ? 0.35 : 0.18,
                    ),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: isDarkMode ? 0.22 : 0.03,
                    ),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? AppSpacing.space8 : AppSpacing.space12,
            vertical: isMobile ? AppSpacing.space8 : AppSpacing.space12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: isMobile ? 44 : 52,
                height: isMobile ? 44 : 52,
                decoration: BoxDecoration(
                  color: isHovered
                      ? AppColors.electricBlue.withValues(
                          alpha: isDarkMode ? 0.22 : 0.12,
                        )
                      : (isDarkMode
                            ? AppColors.darkSurface
                            : const Color(0xFFF1F5F9)),
                  borderRadius: BorderRadius.circular(AppRadius.radius16),
                  border: Border.all(
                    color: isHovered
                        ? AppColors.electricBlue.withValues(alpha: 0.4)
                        : (isDarkMode
                              ? AppColors.darkBorder
                              : Colors.transparent),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: widget.isFa
                      ? FaIcon(
                          widget.icon,
                          size: isMobile ? 22 : 26,
                          color: isHovered
                              ? AppColors.electricBlue
                              : (isDarkMode
                                    ? Colors.white
                                    : AppColors.textPrimary),
                        )
                      : Icon(
                          widget.icon,
                          size: isMobile ? 22 : 26,
                          color: isHovered
                              ? AppColors.electricBlue
                              : (isDarkMode
                                    ? Colors.white
                                    : AppColors.textPrimary),
                        ),
                ),
              ),
              SizedBox(height: isMobile ? AppSpacing.space8 : AppSpacing.space12),
              AppText(
                widget.name,
                style: isMobile
                    ? AppTextStyles.titleSmall.copyWith(
                        fontSize: size.width < 360 ? 13.5 : 14.5,
                        fontWeight: FontWeight.bold,
                        height: 1.25,
                      )
                    : AppTextStyles.titleMedium,
                fontWeight: FontWeight.bold,
                color: isHovered
                    ? AppColors.electricBlue
                    : (isDarkMode ? Colors.white : AppColors.textPrimary),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.space4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: isHovered ? 24 : 0,
                height: 2,
                decoration: BoxDecoration(
                  gradient: AppColors.heroGradient,
                  borderRadius: BorderRadius.circular(AppRadius.radiusFull),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatefulWidget {
  final SkillCategory category;
  final bool isDarkMode;
  final bool disableAnimations;

  const _CategoryCard({
    required this.category,
    required this.isDarkMode,
    required this.disableAnimations,
  });

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: (!widget.disableAnimations && isHovered)
            ? Matrix4.translationValues(0.0, -4.0, 0.0)
            : Matrix4.identity(),
        child: AppCard(
          backgroundColor: widget.isDarkMode
              ? AppColors.darkCardContainer
              : Colors.white,
          borderRadius: AppRadius.radius20,
          border: Border.all(
            color: isHovered
                ? AppColors.electricBlue
                : (widget.isDarkMode
                      ? AppColors.darkBorder
                      : AppColors.outlineVariant),
            width: isHovered ? 1.5 : 1.0,
          ),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: AppColors.electricBlue.withValues(
                      alpha: widget.isDarkMode ? 0.25 : 0.12,
                    ),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: widget.isDarkMode ? 0.2 : 0.03,
                    ),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
          padding: EdgeInsets.all(
            (MediaQuery.of(context).size.width < 640)
                ? AppSpacing.space16
                : AppSpacing.space20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.radius12),
                      color: isHovered
                          ? AppColors.electricBlue.withValues(alpha: 0.25)
                          : AppColors.electricBlue.withValues(
                              alpha: widget.isDarkMode ? 0.15 : 0.08,
                            ),
                      border: Border.all(
                        color: isHovered
                            ? AppColors.electricBlue.withValues(alpha: 0.5)
                            : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      widget.category.icon,
                      color: AppColors.electricBlue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space12),
                  Expanded(
                    child: AppText(
                      widget.category.title,
                      style: AppTextStyles.titleSmall.copyWith(
                        fontSize: (MediaQuery.of(context).size.width < 640)
                            ? 15.5
                            : 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      fontWeight: FontWeight.bold,
                      color: isHovered
                          ? AppColors.electricBlue
                          : (widget.isDarkMode
                                ? Colors.white
                                : AppColors.textPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.space8,
                      vertical: AppSpacing.space2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.royalViolet.withValues(
                        alpha: widget.isDarkMode ? 0.2 : 0.08,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppRadius.radiusFull,
                      ),
                      border: Border.all(
                        color: AppColors.royalViolet.withValues(alpha: 0.25),
                      ),
                    ),
                    child: AppText(
                      '${widget.category.skills.length}',
                      style: AppTextStyles.labelSmall.copyWith(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                      ),
                      color: widget.isDarkMode
                          ? const Color(0xFFE2E8F0)
                          : AppColors.royalViolet,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.space12),
              Container(
                height: 1,
                color: widget.isDarkMode
                    ? AppColors.darkBorder.withValues(alpha: 0.5)
                    : AppColors.outlineVariant.withValues(alpha: 0.6),
              ),
              const SizedBox(height: AppSpacing.space12),
              Wrap(
                spacing: AppSpacing.space8,
                runSpacing: AppSpacing.space8,
                children: widget.category.skills.map((skillName) {
                  return _SkillChip(
                    name: skillName,
                    isDarkMode: widget.isDarkMode,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String name;
  final bool isDarkMode;

  const _SkillChip({
    required this.name,
    required this.isDarkMode,
  });

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 640;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.space12,
          vertical: isMobile ? 6.0 : AppSpacing.space4,
        ),
        decoration: BoxDecoration(
          color: isHovered
              ? AppColors.royalViolet.withValues(
                  alpha: widget.isDarkMode ? 0.25 : 0.12,
                )
              : (widget.isDarkMode ? Colors.white : Colors.black).withValues(
                  alpha: 0.05,
                ),
          borderRadius: BorderRadius.circular(AppRadius.radiusFull),
          border: Border.all(
            color: isHovered
                ? AppColors.royalViolet.withValues(alpha: 0.5)
                : (widget.isDarkMode
                      ? AppColors.darkBorder
                      : AppColors.outlineVariant),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isHovered
                    ? AppColors.royalViolet
                    : (widget.isDarkMode
                          ? AppColors.cyanAccent
                          : AppColors.electricBlue),
              ),
            ),
            const SizedBox(width: AppSpacing.space8),
            Flexible(
              child: AppText(
                widget.name,
                style: isMobile
                    ? AppTextStyles.labelSmall.copyWith(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                      )
                    : AppTextStyles.labelSmall.copyWith(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                color: isHovered
                    ? (widget.isDarkMode ? Colors.white : AppColors.royalViolet)
                    : (widget.isDarkMode
                          ? const Color(0xFFF1F5F9)
                          : AppColors.textPrimary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
