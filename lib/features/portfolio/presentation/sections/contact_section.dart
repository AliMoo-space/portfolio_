import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/design_system/colors/app_colors.dart';
import '../../../../core/design_system/spacing/app_radius.dart';
import '../../../../core/design_system/spacing/app_spacing.dart';
import '../../../../core/design_system/typography/app_text_styles.dart';
import '../../../../core/design_system/widgets/buttons/app_button.dart';
import '../../../../core/design_system/widgets/layout/app_card.dart';
import '../../../../core/design_system/widgets/text/app_text.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri)) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 640;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final disableAnimations = MediaQuery.of(context).disableAnimations;

    final headerTitle = ShaderMask(
      shaderCallback: (bounds) => AppColors.heroGradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: AppText(
        'Get In Touch',
        style: AppTextStyles.sectionTitle(context),
        color: Colors.white,
        textAlign: TextAlign.center,
      ),
    );

    final subtitle = SizedBox(
      width: isMobile
          ? double.infinity
          : (size.width < 1024 ? size.width * 0.8 : 600),
      child: AppText(
        "I'm currently looking for new opportunities. Whether you have a question or just want to say hi, I'll try my best to get back to you!",
        style: isMobile
            ? AppTextStyles.bodyMedium.copyWith(fontSize: 15.0)
            : AppTextStyles.bodyLarge,
        color: isDarkMode
            ? AppColors.textInverse.withValues(alpha: 0.8)
            : AppColors.textSecondary,
        textAlign: TextAlign.center,
        height: 1.6,
      ),
    );

    final showcaseCard = AppCard(
      width: isMobile
          ? double.infinity
          : (size.width < 1024 ? size.width * 0.82 : 640),
      backgroundColor: isDarkMode ? AppColors.darkCardContainer : Colors.white,
      borderRadius: AppRadius.radius24,
      border: Border.all(
        color: isDarkMode ? AppColors.darkBorder : AppColors.outlineVariant,
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: isDarkMode ? 0.3 : 0.05),
          offset: const Offset(0, 8),
          blurRadius: 24,
        ),
      ],
      padding: EdgeInsets.all(
        isMobile
            ? AppSpacing.space16
            : (size.width < 1024 ? AppSpacing.space24 : AppSpacing.space32),
      ),
      child: Column(
        children: [
          // Availability Pill
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? AppSpacing.space12 : AppSpacing.space16,
              vertical: isMobile ? 6.0 : AppSpacing.space8,
            ),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(
                alpha: isDarkMode ? 0.2 : 0.12,
              ),
              borderRadius: BorderRadius.circular(AppRadius.radiusFull),
              border: Border.all(
                color: AppColors.success.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(width: AppSpacing.space8),
                Flexible(
                  child: AppText(
                    'Available for Full-Time & Freelance Roles',
                    style: AppTextStyles.labelMedium.copyWith(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                    ),
                    color: isDarkMode ? Colors.white : AppColors.success,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                    maxLines: isMobile ? 2 : 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: isMobile ? AppSpacing.space20 : AppSpacing.space24),

          // Contact Action Tiles
          ContactTile(
            icon: FontAwesomeIcons.envelope,
            label: 'Email Address',
            value: 'ali5553754@gmail.com',
            onTap: () => _launchURL('mailto:ali5553754@gmail.com'),
          ),
          SizedBox(height: isMobile ? AppSpacing.space12 : AppSpacing.space16),
          ContactTile(
            icon: FontAwesomeIcons.phone,
            label: 'Phone / Direct Line',
            value: '+20 155 171 3043',
            onTap: () => _launchURL('tel:+201551713043'),
          ),
          SizedBox(height: isMobile ? AppSpacing.space12 : AppSpacing.space16),
          ContactTile(
            icon: FontAwesomeIcons.locationDot,
            label: 'Location',
            value: 'Cairo, Egypt',
            onTap: () => _launchURL('https://maps.google.com/?q=Cairo,Egypt'),
          ),
          SizedBox(height: isMobile ? AppSpacing.space12 : AppSpacing.space16),
          ContactTile(
            icon: FontAwesomeIcons.linkedinIn,
            label: 'LinkedIn Profile',
            value: 'ali-flutter-dev',
            onTap: () => _launchURL(
              'https://www.linkedin.com/in/ali-flutter-dev/',
            ),
          ),
          SizedBox(height: isMobile ? AppSpacing.space12 : AppSpacing.space16),
          ContactTile(
            icon: FontAwesomeIcons.github,
            label: 'GitHub Profile',
            value: 'AliMoo-space',
            onTap: () => _launchURL('https://github.com/AliMoo-space'),
          ),
          SizedBox(height: isMobile ? AppSpacing.space20 : AppSpacing.space24),

          // Direct WhatsApp Action Button
          AppButton(
            text: 'Message on WhatsApp',
            variant: AppButtonVariant.primary,
            backgroundColor: const Color(0xFF25D366),
            leading: const FaIcon(
              FontAwesomeIcons.whatsapp,
              size: 20,
              color: Colors.white,
            ),
            onPressed: () => _launchURL('https://wa.me/201551713043'),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (disableAnimations)
            headerTitle
          else
            headerTitle.animate().fade(duration: 600.ms).slideY(begin: 0.1),
          const SizedBox(height: AppSpacing.space16),
          if (disableAnimations)
            subtitle
          else
            subtitle
                .animate(delay: 150.ms)
                .fade(duration: 600.ms)
                .slideY(begin: 0.1),
          SizedBox(height: isMobile ? AppSpacing.space32 : AppSpacing.space40),
          if (disableAnimations)
            showcaseCard
          else
            showcaseCard
                .animate(delay: 300.ms)
                .fade(duration: 600.ms)
                .slideY(begin: 0.1),
          const SizedBox(height: AppSpacing.space48),
          AppText(
            'Designed & Built with Flutter by Ali Mohamed',
            style: AppTextStyles.bodySmall.copyWith(fontSize: 13.0),
            color: isDarkMode
                ? const Color(0xFF94A3B8)
                : AppColors.textSecondary,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.space16),
        ],
      ),
    );
  }
}

class ContactTile extends StatefulWidget {
  final dynamic icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const ContactTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
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
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: (!disableAnimations && isHovered)
            ? Matrix4.translationValues(0.0, -3.0, 0.0)
            : Matrix4.identity(),
        child: AppCard(
          onTap: widget.onTap,
          borderRadius: AppRadius.radius16,
          backgroundColor: isHovered
              ? AppColors.electricBlue.withValues(
                  alpha: isDarkMode ? 0.12 : 0.05,
                )
              : (isDarkMode ? AppColors.darkSurface : const Color(0xFFF8FAFC)),
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
                      alpha: isDarkMode ? 0.25 : 0.15,
                    ),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                  ),
                ]
              : [],
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? AppSpacing.space12 : AppSpacing.space20,
            vertical: isMobile ? AppSpacing.space12 : AppSpacing.space16,
          ),
          child: Row(
            children: [
              Container(
                width: isMobile ? 38 : 44,
                height: isMobile ? 38 : 44,
                decoration: BoxDecoration(
                  color: isHovered
                      ? AppColors.electricBlue.withValues(alpha: 0.2)
                      : AppColors.electricBlue.withValues(
                          alpha: isDarkMode ? 0.15 : 0.1,
                        ),
                  borderRadius: BorderRadius.circular(AppRadius.radius12),
                  border: Border.all(
                    color: AppColors.electricBlue.withValues(alpha: 0.3),
                  ),
                ),
                child: Center(
                  child: FaIcon(
                    widget.icon,
                    size: isMobile ? 18 : 20,
                    color: AppColors.electricBlue,
                  ),
                ),
              ),
              SizedBox(
                width: isMobile ? AppSpacing.space12 : AppSpacing.space16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      widget.label,
                      style: AppTextStyles.labelSmall.copyWith(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                      ),
                      color: isDarkMode
                          ? const Color(0xFF94A3B8)
                          : AppColors.textSecondary,
                    ),
                    const SizedBox(height: AppSpacing.space2),
                    AppText(
                      widget.value,
                      style: isMobile
                          ? AppTextStyles.titleSmall.copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              color: isHovered
                                  ? AppColors.electricBlue
                                  : (isDarkMode
                                        ? Colors.white
                                        : AppColors.textPrimary),
                            )
                          : AppTextStyles.titleMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isHovered
                                  ? AppColors.electricBlue
                                  : (isDarkMode
                                        ? Colors.white
                                        : AppColors.textPrimary),
                            ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                size: isMobile ? 18 : 20,
                color: isHovered
                    ? AppColors.electricBlue
                    : AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
