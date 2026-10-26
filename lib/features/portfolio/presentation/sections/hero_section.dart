import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gap/gap.dart';
import '../../../../core/design_system/colors/app_colors.dart';
import '../../../../core/design_system/spacing/app_radius.dart';
import '../../../../core/design_system/spacing/app_spacing.dart';
import '../../../../core/design_system/typography/app_text_styles.dart';
import '../../../../core/design_system/widgets/text/app_text.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onCheckOutTap;
  final Widget? navBar;

  const HeroSection({
    super.key,
    required this.onCheckOutTap,
    this.navBar,
  });

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri);
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

    return Stack(
      children: [
        // Ambient Gradient Background
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppColors.darkCanvas
                  : const Color(0xFFF8FAFC),
              gradient: RadialGradient(
                center: const Alignment(-0.6, -0.6),
                radius: 1.2,
                colors: isDarkMode
                    ? [
                        AppColors.electricBlue.withValues(alpha: 0.14),
                        AppColors.royalViolet.withValues(alpha: 0.08),
                        AppColors.darkCanvas,
                      ]
                    : [
                        AppColors.electricBlue.withValues(alpha: 0.08),
                        const Color(0xFFF8FAFC),
                      ],
              ),
            ),
          ),
        ),

        // Ambient Violet Lighting Accent (Right Side)
        if (isDarkMode)
          Positioned(
            right: -100,
            top: 50,
            child: IgnorePointer(
              child: Container(
                width: 450,
                height: 450,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.royalViolet.withValues(alpha: 0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

        // Hero Main Content with integrated NavBar
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ?navBar,
            Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: isMobile ? 540 : 640),
              padding: EdgeInsets.only(
                left: isMobile
                    ? (size.width < 360 ? 12.0 : 20.0)
                    : (size.width < 1024 ? size.width * 0.06 : size.width * 0.1),
                right: isMobile
                    ? (size.width < 360 ? 12.0 : 20.0)
                    : (size.width < 1024 ? size.width * 0.06 : size.width * 0.1),
                top: navBar != null
                    ? (isMobile ? 16.0 : 36.0)
                    : (isMobile ? 48.0 : 90.0),
                bottom: isMobile ? 48 : (size.width < 1024 ? 64 : 90),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar with glowing gradient frame
                  _buildAvatar(
                    context,
                    size,
                    isMobile,
                    isDarkMode,
                    disableAnimations,
                  ),
                  SizedBox(height: isMobile ? 20 : 28),

                  // Greeting Badge / Pill
                  _buildGreetingPill(
                    context,
                    isMobile,
                    isDarkMode,
                    disableAnimations,
                  ),
                  SizedBox(height: isMobile ? 12 : 16),

                  // Name with Creative Linear Gradient
                  _buildGradientName(
                    context,
                    size,
                    isMobile,
                    disableAnimations,
                  ),
                  SizedBox(height: isMobile ? 10 : 14),

                  // Typewriter Subtitle
                  _buildTypewriterSubtitle(
                    context,
                    size,
                    isMobile,
                    isDarkMode,
                    disableAnimations,
                  ),
                  SizedBox(height: isMobile ? 16 : 24),

                  // Bio Description
                  _buildBioDescription(
                    context,
                    size,
                    isMobile,
                    isDarkMode,
                    disableAnimations,
                  ),
                  SizedBox(height: isMobile ? 24 : 32),

                  // Action CTA Buttons
                  _buildActionButtons(
                    context,
                    isMobile,
                    isDarkMode,
                    disableAnimations,
                  ),
                  SizedBox(height: isMobile ? 28 : 36),

                  // Social Channel Icons
                  _buildSocialChannels(context, isDarkMode, disableAnimations),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAvatar(
    BuildContext context,
    Size size,
    bool isMobile,
    bool isDarkMode,
    bool disableAnimations,
  ) {
    final avatarDimension = isMobile
        ? (size.width < 380 ? 140.0 : 160.0)
        : 220.0;
    final borderRadius = isMobile
        ? (size.width < 380 ? 28.0 : 32.0)
        : 44.0;
    final innerRadius = isMobile
        ? (size.width < 380 ? 24.5 : 28.5)
        : 40.5;

    final avatarWidget = Container(
      width: avatarDimension,
      height: avatarDimension,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: AppColors.heroGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.electricBlue.withValues(
              alpha: isDarkMode ? 0.35 : 0.2,
            ),
            blurRadius: 32,
            spreadRadius: -4,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: AppColors.royalViolet.withValues(
              alpha: isDarkMode ? 0.25 : 0.15,
            ),
            blurRadius: 24,
            spreadRadius: -6,
            offset: const Offset(8, 16),
          ),
        ],
      ),
      padding: const EdgeInsets.all(3.5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(innerRadius),
        child: Container(
          color: isDarkMode ? AppColors.darkSurface : Colors.white,
          child: Image.asset(
            'assets/IMG_6021.jpeg',
            fit: BoxFit.cover,
            alignment: Alignment.center,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.person_rounded,
                size: isMobile ? 60 : 88,
                color: AppColors.electricBlue,
              );
            },
          ),
        ),
      ),
    );

    if (disableAnimations) return avatarWidget;

    return avatarWidget
        .animate()
        .fade(duration: 600.ms)
        .scale(begin: const Offset(0.9, 0.9));
  }

  Widget _buildGreetingPill(
    BuildContext context,
    bool isMobile,
    bool isDarkMode,
    bool disableAnimations,
  ) {
    final pillWidget = Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 14,
        vertical: isMobile ? 5 : 6,
      ),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.electricBlue.withValues(alpha: 0.15)
            : AppColors.electricBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDarkMode
              ? AppColors.electricBlue.withValues(alpha: 0.3)
              : AppColors.electricBlue.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.brightFuchsia,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          AppText(
            'Hi, my name is',
            style: AppTextStyles.labelMedium,
            color: isDarkMode
                ? AppColors.electricBlue
                : const Color(0xFF2563EB),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ],
      ),
    );

    if (disableAnimations) return pillWidget;

    return pillWidget
        .animate(delay: 150.ms)
        .fade(duration: 500.ms)
        .slideY(begin: 0.15);
  }

  Widget _buildGradientName(
    BuildContext context,
    Size size,
    bool isMobile,
    bool disableAnimations,
  ) {
    final double nameFontSize = isMobile
        ? (size.width < 360 ? 36.0 : (size.width < 420 ? 42.0 : 48.0))
        : (size.width < 1024 ? 54.0 : 72.0);

    final nameWidget = ShaderMask(
      shaderCallback: (bounds) => AppColors.heroGradient.createShader(bounds),
      child: Text(
        'Ali Mohamed.',
        style: AppTextStyles.heroName(
          fontSize: nameFontSize,
          color: Colors.white,
        ).copyWith(
          letterSpacing: isMobile ? -1.0 : -1.5,
        ),
      ),
    );

    if (disableAnimations) return nameWidget;

    return nameWidget
        .animate(delay: 300.ms)
        .fade(duration: 500.ms)
        .slideY(begin: 0.15);
  }

  Widget _buildTypewriterSubtitle(
    BuildContext context,
    Size size,
    bool isMobile,
    bool isDarkMode,
    bool disableAnimations,
  ) {
    final double subtitleFontSize = isMobile
        ? (size.width < 380 ? 20.0 : 22.0)
        : (size.width < 1024 ? 28.0 : 36.0);
    // On small screens, text may wrap to two lines ("Flutter |" and "Mobile Developer")
    // requiring adequate height so it is never clipped.
    final double subtitleHeight = isMobile
        ? (size.width < 420 ? 64.0 : 54.0)
        : (size.width < 1024 ? 52.0 : 58.0);

    final subtitleWidget = SizedBox(
      height: subtitleHeight,
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            'Flutter | Mobile Developer',
            textStyle: AppTextStyles.heroSubtitle(
              fontSize: subtitleFontSize,
              color: isDarkMode
                  ? const Color(0xFF94A3B8)
                  : const Color(0xFF475569),
            ),
            speed: const Duration(milliseconds: 90),
          ),
        ],
        totalRepeatCount: 1,
        displayFullTextOnTap: true,
      ),
    );

    if (disableAnimations) return subtitleWidget;

    return subtitleWidget.animate(delay: 450.ms).fade(duration: 500.ms);
  }

  Widget _buildBioDescription(
    BuildContext context,
    Size size,
    bool isMobile,
    bool isDarkMode,
    bool disableAnimations,
  ) {
    final double bioWidth = isMobile
        ? double.infinity
        : (size.width < 1024 ? size.width * 0.78 : size.width * 0.55);
    final double bioFontSize = isMobile
        ? 15.0
        : (size.width < 1024 ? 16.5 : 18.0);

    final bioWidget = SizedBox(
      width: bioWidth,
      child: AppText(
        'I am actively seeking new opportunities where I can contribute, grow, and deliver high-quality results. I am available for both remote and on-site positions and committed to continuous improvement.',
        style: AppTextStyles.heroBio(
          fontSize: bioFontSize,
          color: isDarkMode ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
        ),
      ),
    );

    if (disableAnimations) return bioWidget;

    return bioWidget
        .animate(delay: 600.ms)
        .fade(duration: 500.ms)
        .slideY(begin: 0.15);
  }

  Widget _buildActionButtons(
    BuildContext context,
    bool isMobile,
    bool isDarkMode,
    bool disableAnimations,
  ) {
    final buttonsWidget = Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        // Primary Gradient Button
        Container(
          height: isMobile ? 48.0 : 54.0,
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(AppRadius.radius12),
            boxShadow: [
              BoxShadow(
                color: AppColors.electricBlue.withValues(
                  alpha: isDarkMode ? 0.4 : 0.25,
                ),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: onCheckOutTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.transparent,
              shadowColor: AppColors.transparent,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? AppSpacing.space20 : AppSpacing.space32,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.radius12),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: AppText(
                    'Check out my work!',
                    style: AppTextStyles.titleSmall.copyWith(
                      fontSize: isMobile ? 15 : 16,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                      color: AppColors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Gap(AppSpacing.space8),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
                  color: AppColors.white,
                ),
              ],
            ),
          ),
        ),

        // Download CV Button
        DownloadCvButton(
          onTap: () => _launchURL(
            'https://drive.google.com/drive/folders/1axHapRU2vwj_838B8KlsThV3VgEh1oTa?usp=sharing',
          ),
          isMobile: isMobile,
          isDarkMode: isDarkMode,
          disableAnimations: disableAnimations,
        ),
      ],
    );

    if (disableAnimations) return buttonsWidget;

    return buttonsWidget
        .animate(delay: 750.ms)
        .fade(duration: 500.ms)
        .slideY(begin: 0.15);
  }

  Widget _buildSocialChannels(
    BuildContext context,
    bool isDarkMode,
    bool disableAnimations,
  ) {
    final channelsWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SocialIconButton(
          icon: FontAwesomeIcons.whatsapp,
          tooltip: 'WhatsApp',
          onTap: () => _launchURL('https://wa.me/201551713043'),
          isDarkMode: isDarkMode,
          hoverColor: const Color(0xFF25D366),
        ),
        const SizedBox(width: 14),
        _SocialIconButton(
          icon: FontAwesomeIcons.linkedinIn,
          tooltip: 'LinkedIn',
          onTap: () =>
              _launchURL('https://www.linkedin.com/in/ali-flutter-dev/'),
          isDarkMode: isDarkMode,
          hoverColor: const Color(0xFF0077B5),
        ),
        const SizedBox(width: 14),
        _SocialIconButton(
          icon: FontAwesomeIcons.github,
          tooltip: 'GitHub',
          onTap: () => _launchURL('https://github.com/AliMoo-space'),
          isDarkMode: isDarkMode,
          hoverColor: AppColors.electricBlue,
        ),
      ],
    );

    if (disableAnimations) return channelsWidget;

    return channelsWidget
        .animate(delay: 900.ms)
        .fade(duration: 500.ms)
        .slideY(begin: 0.15);
  }
}

class _SocialIconButton extends StatefulWidget {
  final dynamic icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool isDarkMode;
  final Color hoverColor;

  const _SocialIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    required this.isDarkMode,
    required this.hoverColor,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.of(context).disableAnimations;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Tooltip(
          message: widget.tooltip,
          child: AnimatedContainer(
            duration: disableAnimations
                ? Duration.zero
                : const Duration(milliseconds: 200),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isHovered
                  ? widget.hoverColor.withValues(alpha: 0.15)
                  : (widget.isDarkMode
                        ? AppColors.darkSurface
                        : const Color(0xFFF1F5F9)),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isHovered
                    ? widget.hoverColor.withValues(alpha: 0.6)
                    : (widget.isDarkMode
                          ? AppColors.darkBorder
                          : const Color(0xFFE2E8F0)),
                width: 1,
              ),
              boxShadow: isHovered
                  ? [
                      BoxShadow(
                        color: widget.hoverColor.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: FaIcon(
                widget.icon,
                size: 20,
                color: isHovered
                    ? widget.hoverColor
                    : (widget.isDarkMode
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF475569)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A polished, responsive Download CV button that maintains identical geometry
/// across both light and dark themes, preventing layout shifts.
class DownloadCvButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool? isMobile;
  final bool? isDarkMode;
  final bool? disableAnimations;

  const DownloadCvButton({
    super.key,
    required this.onTap,
    this.isMobile,
    this.isDarkMode,
    this.disableAnimations,
  });

  @override
  State<DownloadCvButton> createState() => _DownloadCvButtonState();
}

class _DownloadCvButtonState extends State<DownloadCvButton> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode ?? (Theme.of(context).brightness == Brightness.dark);
    final isMobile = widget.isMobile ?? (MediaQuery.of(context).size.width < 640);
    final disableAnimations = widget.disableAnimations ?? MediaQuery.of(context).disableAnimations;
    final isHoveredOrFocused = _isHovered || _isFocused;

    final Color backgroundColor = isDark
        ? (isHoveredOrFocused
            ? AppColors.darkCardContainer
            : AppColors.darkSurface.withValues(alpha: 0.85))
        : (isHoveredOrFocused
            ? const Color(0xFFF8FAFC)
            : AppColors.white);

    final Color borderColor = isHoveredOrFocused
        ? (isDark ? AppColors.cyanAccent : AppColors.electricBlue)
        : (isDark ? AppColors.darkBorder : const Color(0xFFCBD5E1));

    final Color foregroundColor = isHoveredOrFocused
        ? (isDark ? AppColors.cyanAccent : AppColors.electricBlue)
        : (isDark ? AppColors.white : AppColors.textPrimary);

    final Color shadowColor = isHoveredOrFocused
        ? (isDark
            ? AppColors.cyanAccent.withValues(alpha: 0.22)
            : AppColors.electricBlue.withValues(alpha: 0.18))
        : (isDark
            ? Colors.black.withValues(alpha: 0.25)
            : Colors.black.withValues(alpha: 0.04));

    final double height = isMobile ? 48.0 : 54.0;
    final EdgeInsets padding = EdgeInsets.symmetric(
      horizontal: isMobile ? AppSpacing.space20 : AppSpacing.space32,
    );

    return Semantics(
      button: true,
      label: 'Download CV',
      enabled: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Focus(
          onFocusChange: (focused) => setState(() => _isFocused = focused),
          child: AnimatedContainer(
            duration: disableAnimations ? Duration.zero : const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(AppRadius.radius12),
              border: Border.all(
                color: borderColor,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: isHoveredOrFocused ? 16 : 8,
                  offset: isHoveredOrFocused ? const Offset(0, 4) : const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: AppColors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(AppRadius.radius12),
                hoverColor: AppColors.transparent,
                splashColor: (isDark ? AppColors.cyanAccent : AppColors.electricBlue)
                    .withValues(alpha: 0.12),
                highlightColor: AppColors.transparent,
                child: Padding(
                  padding: padding,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedSlide(
                        offset: isHoveredOrFocused
                            ? const Offset(0, 0.12)
                            : Offset.zero,
                        duration: disableAnimations
                            ? Duration.zero
                            : const Duration(milliseconds: 180),
                        curve: Curves.easeOutCubic,
                        child: Icon(
                          Icons.download_rounded,
                          size: 18,
                          color: foregroundColor,
                        ),
                      ),
                      const Gap(AppSpacing.space8),
                      Flexible(
                        child: AppText(
                          'Download CV',
                          style: AppTextStyles.titleSmall.copyWith(
                            fontSize: isMobile ? 15 : 16,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                            color: foregroundColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

