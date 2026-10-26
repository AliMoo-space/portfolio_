import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/design_system/colors/app_colors.dart';
import '../../../../core/design_system/spacing/app_radius.dart';
import '../../../../core/design_system/spacing/app_spacing.dart';
import '../../../../core/design_system/typography/app_text_styles.dart';
import '../../../../core/design_system/widgets/layout/app_card.dart';
import '../../../../core/design_system/widgets/text/app_text.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  final List<Map<String, dynamic>> skills = const [
    {'name': 'Flutter', 'icon': Icons.flutter_dash},
    {'name': 'Dart', 'icon': Icons.code},
    {'name': 'Firebase', 'icon': Icons.local_fire_department, 'isFa': false},
    {'name': 'REST APIs', 'icon': Icons.api, 'isFa': false},
    {'name': 'Git & GitHub', 'icon': FontAwesomeIcons.github, 'isFa': true},
    {'name': 'Problem Solving', 'icon': Icons.lightbulb_outline, 'isFa': false},
  ];

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
            'My Skills',
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

    final categoryPill = Align(
      alignment: Alignment.centerLeft,
      child: Container(
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
              Icons.code_rounded,
              size: 16,
              color: AppColors.royalViolet,
            ),
            const SizedBox(width: AppSpacing.space8),
            Flexible(
              child: AppText(
                'Core Tech Stack & Engineering Competencies',
                style: AppTextStyles.labelSmall,
                color: AppColors.royalViolet,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
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
          const SizedBox(height: AppSpacing.space16),
          if (disableAnimations)
            categoryPill
          else
            categoryPill.animate(delay: 100.ms).fade(duration: 500.ms),
          const SizedBox(height: AppSpacing.space48),
          Center(
            child: Wrap(
              spacing: AppSpacing.space20,
              runSpacing: AppSpacing.space20,
              alignment: WrapAlignment.center,
              children: skills.asMap().entries.map((entry) {
                final index = entry.key;
                final skill = entry.value;
                final card = SkillCard(
                  name: skill['name'] as String,
                  icon: skill['icon'],
                  isFa: skill['isFa'] ?? false,
                );

                if (disableAnimations) return card;

                return card
                    .animate(delay: (100 * index).ms)
                    .fade(duration: 500.ms)
                    .scale(begin: const Offset(0.92, 0.92));
              }).toList(),
            ),
          ),
        ],
      ),
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

    final cardWidth = isMobile ? 145.0 : 175.0;
    final cardHeight = isMobile ? 140.0 : 160.0;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: (!disableAnimations && isHovered)
            ? Matrix4.translationValues(0.0, -6.0, 0.0)
            : Matrix4.identity(),
        child: AppCard(
          width: cardWidth,
          height: cardHeight,
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
                      alpha: isDarkMode ? 0.35 : 0.2,
                    ),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: isDarkMode ? 0.25 : 0.04,
                    ),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space12,
            vertical: AppSpacing.space16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: isMobile ? 52 : 60,
                height: isMobile ? 52 : 60,
                decoration: BoxDecoration(
                  color: isHovered
                      ? AppColors.electricBlue.withValues(
                          alpha: isDarkMode ? 0.2 : 0.12,
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
                          size: isMobile ? 26 : 30,
                          color: isHovered
                              ? AppColors.electricBlue
                              : (isDarkMode
                                  ? Colors.white
                                  : AppColors.textPrimary),
                        )
                      : Icon(
                          widget.icon,
                          size: isMobile ? 26 : 30,
                          color: isHovered
                              ? AppColors.electricBlue
                              : (isDarkMode
                                  ? Colors.white
                                  : AppColors.textPrimary),
                        ),
                ),
              ),
              const SizedBox(height: AppSpacing.space16),
              AppText(
                widget.name,
                style: AppTextStyles.titleMedium,
                fontWeight: FontWeight.w600,
                color: isHovered
                    ? AppColors.electricBlue
                    : (isDarkMode ? Colors.white : AppColors.textPrimary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
