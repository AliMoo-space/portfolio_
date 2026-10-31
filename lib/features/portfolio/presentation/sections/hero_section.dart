import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gap/gap.dart';
import '../../../../core/design_system/colors/app_colors.dart';
import '../../../../core/design_system/spacing/app_radius.dart';
import '../../../../core/design_system/spacing/app_spacing.dart';
import '../../../../core/design_system/typography/app_text_styles.dart';
import '../../../../core/design_system/widgets/media/profile_photo_viewer.dart';
import '../../../../core/design_system/widgets/text/app_text.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onCheckOutTap;
  final Widget? navBar;

  const HeroSection({super.key, required this.onCheckOutTap, this.navBar});

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
    final padding = MediaQuery.paddingOf(context);
    final isMobile = size.width < 640;
    final isDesktop = size.width >= 1024;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final disableAnimations = MediaQuery.of(context).disableAnimations;

    // Occupy 100% of visible screen height (100vh) within SafeArea
    final double availableHeight = size.height - padding.top - padding.bottom;
    final double navBarEstimatedHeight = navBar != null
        ? (isMobile ? 56.0 : 76.0)
        : 0.0;
    final double contentMinHeight = (availableHeight - navBarEstimatedHeight)
        .clamp(isMobile ? 440.0 : 580.0, double.infinity);
    final bool isShortMobile = isMobile && size.height < 720;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: availableHeight),
      child: Stack(
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
                constraints: BoxConstraints(minHeight: contentMinHeight),
                padding: EdgeInsets.only(
                  left: isMobile
                      ? (size.width < 360 ? 12.0 : 20.0)
                      : (size.width < 1024
                            ? size.width * 0.06
                            : size.width * 0.1),
                  right: isMobile
                      ? (size.width < 360 ? 12.0 : 20.0)
                      : (size.width < 1024
                            ? size.width * 0.06
                            : size.width * 0.1),
                  top: navBar != null
                      ? (isMobile ? (size.height < 700 ? 8.0 : 16.0) : 36.0)
                      : (isMobile ? 28.0 : 90.0),
                  bottom: isMobile
                      ? (size.height < 700 ? 16.0 : 24.0)
                      : (size.width < 1024 ? 64.0 : 90.0),
                ),
                child: isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildGreetingPill(
                                  context,
                                  isMobile,
                                  isDarkMode,
                                  disableAnimations,
                                ),
                                const Gap(AppSpacing.space16),
                                _buildGradientName(
                                  context,
                                  size,
                                  isMobile,
                                  disableAnimations,
                                ),
                                const Gap(AppSpacing.space12),
                                _buildTypewriterSubtitle(
                                  context,
                                  size,
                                  isMobile,
                                  isDarkMode,
                                  disableAnimations,
                                ),
                                const Gap(AppSpacing.space24),
                                _buildBioDescription(
                                  context,
                                  size,
                                  isMobile,
                                  isDarkMode,
                                  disableAnimations,
                                ),
                                const Gap(AppSpacing.space32),
                                _buildActionButtons(
                                  context,
                                  isMobile,
                                  isDarkMode,
                                  disableAnimations,
                                ),
                                const Gap(AppSpacing.space32),
                                _buildSocialChannels(
                                  context,
                                  isDarkMode,
                                  disableAnimations,
                                  isMobile,
                                ),
                              ],
                            ),
                          ),
                          const Gap(AppSpacing.space48),
                          Expanded(
                            flex: 4,
                            child: Center(
                              child: _buildAvatar(
                                context,
                                size,
                                isMobile,
                                isDarkMode,
                                disableAnimations,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0, top: 4.0),
                            child: _buildAvatar(
                              context,
                              size,
                              isMobile,
                              isDarkMode,
                              disableAnimations,
                            ),
                          ),
                          Gap(isShortMobile ? AppSpacing.space8 : AppSpacing.space12),

                          // Greeting Badge / Pill
                          _buildGreetingPill(
                            context,
                            isMobile,
                            isDarkMode,
                            disableAnimations,
                          ),
                          Gap(isShortMobile ? AppSpacing.space4 : AppSpacing.space8),

                          // Name with Creative Linear Gradient
                          _buildGradientName(
                            context,
                            size,
                            isMobile,
                            disableAnimations,
                          ),
                          Gap(isShortMobile ? AppSpacing.space4 : AppSpacing.space8),

                          // Typewriter Subtitle
                          _buildTypewriterSubtitle(
                            context,
                            size,
                            isMobile,
                            isDarkMode,
                            disableAnimations,
                          ),
                          Gap(isShortMobile ? AppSpacing.space8 : AppSpacing.space12),

                          // Bio Description
                          _buildBioDescription(
                            context,
                            size,
                            isMobile,
                            isDarkMode,
                            disableAnimations,
                          ),
                          Gap(isShortMobile ? AppSpacing.space12 : AppSpacing.space16),

                          // Action CTA Buttons
                          _buildActionButtons(
                            context,
                            isMobile,
                            isDarkMode,
                            disableAnimations,
                          ),
                          Gap(isShortMobile ? AppSpacing.space12 : AppSpacing.space16),

                          // Social Channel Icons
                          _buildSocialChannels(
                            context,
                            isDarkMode,
                            disableAnimations,
                            isMobile,
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(
    BuildContext context,
    Size size,
    bool isMobile,
    bool isDarkMode,
    bool disableAnimations,
  ) {
    return ProfilePhotoHero(
      size: size,
      isMobile: isMobile,
      isDarkMode: isDarkMode,
      disableAnimations: disableAnimations,
    );
  }

  Widget _buildGreetingPill(
    BuildContext context,
    bool isMobile,
    bool isDarkMode,
    bool disableAnimations,
  ) {
    final pillWidget = Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 10.0 : 14.0,
        vertical: isMobile ? 4.0 : 6.0,
      ),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.electricBlue.withValues(alpha: 0.15)
            : AppColors.electricBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.radiusFull),
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
            width: isMobile ? 6.0 : 8.0,
            height: isMobile ? 6.0 : 8.0,
            decoration: const BoxDecoration(
              color: AppColors.brightFuchsia,
              shape: BoxShape.circle,
            ),
          ),
          Gap(isMobile ? AppSpacing.space4 : AppSpacing.space8),
          AppText(
            'Hi, my name is',
            style: AppTextStyles.labelMedium.copyWith(
              fontSize: isMobile ? 11.5.sp : 14.sp,
            ),
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
        ? (size.width < 360 ? 28.sp : (size.width < 400 ? 32.sp : 36.sp))
        : (size.width < 1024 ? 54.0 : 72.0);

    final nameWidget = ShaderMask(
      shaderCallback: (bounds) => AppColors.heroGradient.createShader(bounds),
      child: AppText(
        'Ali Mohamed.',
        style: AppTextStyles.heroName(
          fontSize: nameFontSize,
          color: Colors.white,
        ).copyWith(letterSpacing: isMobile ? -0.8 : -1.5, height: 1.15),
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
        ? (size.width < 360 ? 15.sp : (size.width < 400 ? 16.5.sp : 18.sp))
        : (size.width < 1024 ? 28.0 : 36.0);
    final double subtitleHeight = isMobile
        ? (size.width < 360 ? 40.0 : 34.0)
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
    final isDesktop = size.width >= 1024;
    final double bioWidth = isMobile
        ? double.infinity
        : (isDesktop ? double.infinity : size.width * 0.78);
    final double bioFontSize = isMobile
        ? (size.width < 360 ? 12.5.sp : 13.5.sp)
        : (size.width < 1024 ? 16.5 : 18.0);

    final bioWidget = SizedBox(
      width: bioWidth,
      child: AppText(
        'I am actively seeking new opportunities where I can contribute, grow, and deliver high-quality results. I am available for both remote and on-site positions and committed to continuous improvement.',
        style: AppTextStyles.heroBio(
          fontSize: bioFontSize,
          color: isDarkMode ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
        ).copyWith(height: isMobile ? 1.45 : 1.6),
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
    final double buttonHeight = isMobile ? 48.0 : 54.0;
    final double buttonFontSize = isMobile ? 14.5.sp : 16.0;
    final double buttonIconSize = isMobile ? 17.sp : 18.0;

    final buttonsWidget = Wrap(
      spacing: isMobile ? 10.0 : 14.0,
      runSpacing: isMobile ? 10.0 : 14.0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // Primary Gradient Button
        Container(
          height: buttonHeight,
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(AppRadius.radius12),
            boxShadow: [
              BoxShadow(
                color: AppColors.electricBlue.withValues(
                  alpha: isDarkMode ? 0.4 : 0.25,
                ),
                blurRadius: isMobile ? 14 : 20,
                offset: Offset(0, isMobile ? 5 : 8),
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
                      fontSize: buttonFontSize,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                      color: AppColors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Gap(isMobile ? AppSpacing.space4 : AppSpacing.space8),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: buttonIconSize,
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
    bool isMobile,
  ) {
    final double btnSize = isMobile ? 38.0 : 44.0;
    final double icnSize = isMobile ? 16.0 : 20.0;

    final channelsWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SocialIconButton(
          icon: FontAwesomeIcons.whatsapp,
          tooltip: 'WhatsApp',
          onTap: () => _launchURL('https://wa.me/201551713043'),
          isDarkMode: isDarkMode,
          hoverColor: const Color(0xFF25D366),
          size: btnSize,
          iconSize: icnSize,
        ),
        Gap(isMobile ? AppSpacing.space8 : AppSpacing.space12),
        _SocialIconButton(
          icon: FontAwesomeIcons.linkedinIn,
          tooltip: 'LinkedIn',
          onTap: () =>
              _launchURL('https://www.linkedin.com/in/ali-flutter-dev/'),
          isDarkMode: isDarkMode,
          hoverColor: const Color(0xFF0077B5),
          size: btnSize,
          iconSize: icnSize,
        ),
        Gap(isMobile ? AppSpacing.space8 : AppSpacing.space12),
        _SocialIconButton(
          icon: FontAwesomeIcons.github,
          tooltip: 'GitHub',
          onTap: () => _launchURL('https://github.com/AliMoo-space'),
          isDarkMode: isDarkMode,
          hoverColor: AppColors.electricBlue,
          size: btnSize,
          iconSize: icnSize,
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
  final double size;
  final double iconSize;

  const _SocialIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    required this.isDarkMode,
    required this.hoverColor,
    this.size = 44,
    this.iconSize = 20,
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
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: isHovered
                  ? widget.hoverColor.withValues(alpha: 0.15)
                  : (widget.isDarkMode
                        ? AppColors.darkSurface
                        : const Color(0xFFF1F5F9)),
              borderRadius: BorderRadius.circular(AppRadius.radius12),
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
                size: widget.iconSize,
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
    final isDark =
        widget.isDarkMode ?? (Theme.of(context).brightness == Brightness.dark);
    final isMobile =
        widget.isMobile ?? (MediaQuery.of(context).size.width < 640);
    final disableAnimations =
        widget.disableAnimations ?? MediaQuery.of(context).disableAnimations;
    final isHoveredOrFocused = _isHovered || _isFocused;

    final Color backgroundColor = isDark
        ? (isHoveredOrFocused
              ? AppColors.darkCardContainer
              : AppColors.darkSurface.withValues(alpha: 0.85))
        : (isHoveredOrFocused ? const Color(0xFFF8FAFC) : AppColors.white);

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
            duration: disableAnimations
                ? Duration.zero
                : const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(AppRadius.radius12),
              border: Border.all(color: borderColor, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: isHoveredOrFocused ? 16 : 8,
                  offset: isHoveredOrFocused
                      ? const Offset(0, 4)
                      : const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: AppColors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                borderRadius: BorderRadius.circular(AppRadius.radius12),
                hoverColor: AppColors.transparent,
                splashColor:
                    (isDark ? AppColors.cyanAccent : AppColors.electricBlue)
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
                          size: isMobile ? 16.sp : 18,
                          color: foregroundColor,
                        ),
                      ),
                      Gap(isMobile ? AppSpacing.space4 : AppSpacing.space8),
                      Flexible(
                        child: AppText(
                          'Download CV',
                          style: AppTextStyles.titleSmall.copyWith(
                            fontSize: isMobile ? 13.5.sp : 16,
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

bool get _isInTest =>
    WidgetsBinding.instance.runtimeType.toString().contains('Test');

class ProfilePhotoHero extends StatefulWidget {
  final Size size;
  final bool isMobile;
  final bool isDarkMode;
  final bool disableAnimations;

  const ProfilePhotoHero({
    super.key,
    required this.size,
    required this.isMobile,
    required this.isDarkMode,
    required this.disableAnimations,
  });

  @override
  State<ProfilePhotoHero> createState() => _ProfilePhotoHeroState();
}

class _ProfilePhotoHeroState extends State<ProfilePhotoHero>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );
    if (!widget.disableAnimations && !_isInTest) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(covariant ProfilePhotoHero oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((widget.disableAnimations || _isInTest) &&
        _pulseController.isAnimating) {
      _pulseController.stop();
    } else if (!widget.disableAnimations &&
        !_isInTest &&
        !_pulseController.isAnimating) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = widget.isMobile;
    final isDarkMode = widget.isDarkMode;
    final size = widget.size;

    // Dimensions:
    final double avatarDimension = isMobile
        ? (size.height < 680 || size.width < 360
            ? 110.0
            : (size.height < 780 || size.width < 400
                ? 124.0
                : 138.0))
        : (size.width < 1024 ? 200.0 : 250.0);

    final double borderRadius = isMobile
        ? (size.width < 380 ? 24.0 : 28.0)
        : 44.0;

    final double innerRadius = borderRadius - (isMobile ? 2.5 : 3.5);

    // Outer container with interactive hover effect & tap to view
    final Widget photoCard = MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () =>
            showProfilePhotoViewer(context, imageAsset: 'assets/IMG_6021.jpeg'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _isHovered ? -8.0 : 0, 0),
          width: avatarDimension,
          height: avatarDimension,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: AppColors.heroGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.electricBlue.withValues(
                  alpha: isDarkMode
                      ? (_isHovered ? 0.55 : 0.35)
                      : (_isHovered ? 0.35 : 0.22),
                ),
                blurRadius: _isHovered ? 40.0 : 30.0,
                spreadRadius: _isHovered ? 0 : -3,
                offset: Offset(0, _isHovered ? 16.0 : 12.0),
              ),
              BoxShadow(
                color: AppColors.royalViolet.withValues(
                  alpha: isDarkMode
                      ? (_isHovered ? 0.45 : 0.25)
                      : (_isHovered ? 0.25 : 0.15),
                ),
                blurRadius: _isHovered ? 30.0 : 22.0,
                spreadRadius: _isHovered ? -2 : -6,
                offset: Offset(8.0, _isHovered ? 20.0 : 16.0),
              ),
            ],
          ),
          padding: EdgeInsets.all(isMobile ? 2.5 : 3.5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(innerRadius),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Base background
                Container(
                  color: isDarkMode ? AppColors.darkSurface : Colors.white,
                  child: AnimatedScale(
                    scale: _isHovered ? 1.05 : 1.0,
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeOutCubic,
                    child: Image.asset(
                      'assets/IMG_6021.jpeg',
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.person_rounded,
                          size: isMobile ? 48.0 : 88.0,
                          color: AppColors.electricBlue,
                        );
                      },
                    ),
                  ),
                ),

                // Crisp inner rim border for glassmorphic depth
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(innerRadius),
                    border: Border.all(
                      color: Colors.white.withValues(
                        alpha: isDarkMode ? 0.16 : 0.35,
                      ),
                      width: 1.2,
                    ),
                  ),
                ),

                // Subtle hover zoom pill indicator
                AnimatedOpacity(
                  opacity: _isHovered ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.4),
                          width: 1.2,
                        ),
                      ),
                      child: const Icon(
                        Icons.fullscreen_rounded,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Floating Flutter Tech Badge (top-left)
    final double flutterBadgeSize = isMobile ? 30.0 : 40.0;
    final flutterBadge = Container(
      width: flutterBadgeSize,
      height: flutterBadgeSize,
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.darkSurface.withValues(alpha: 0.92)
            : Colors.white.withValues(alpha: 0.95),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.cyanAccent.withValues(alpha: 0.6),
          width: isMobile ? 1.2 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyanAccent.withValues(
              alpha: isDarkMode ? 0.3 : 0.2,
            ),
            blurRadius: isMobile ? 8.0 : 10.0,
            offset: const Offset(0, 3.0),
          ),
        ],
      ),
      child: Center(
        child: FlutterLogo(size: isMobile ? 15.0 : 20.0),
      ),
    );

    // Floating Status Badge: "Available for work" (bottom-right)
    final statusBadge = Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8.0 : 14.0,
        vertical: isMobile ? 4.5 : 7.0,
      ),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppColors.darkSurface.withValues(alpha: 0.92)
            : Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(AppRadius.radiusFull),
        border: Border.all(
          color: isDarkMode ? AppColors.darkBorder : AppColors.outlineVariant,
          width: isMobile ? 1.0 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDarkMode ? 0.35 : 0.12),
            blurRadius: isMobile ? 10.0 : 14.0,
            offset: const Offset(0, 4.0),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LiveStatusIndicator(
            disableAnimations: widget.disableAnimations,
            isMobile: isMobile,
          ),
          Gap(isMobile ? AppSpacing.space4 : AppSpacing.space8),
          AppText(
            'Available for work',
            style: AppTextStyles.labelSmall.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: isMobile ? 10.5.sp : 12.5.sp,
              color: isDarkMode ? Colors.white : AppColors.onBackground,
            ),
          ),
        ],
      ),
    );

    // Presentation layout with glowing aura, main card, and floating badges
    final presentation = Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // 1. Ambient pulsing aura glow behind avatar
        if (!widget.disableAnimations)
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              final double pulseValue = _pulseController.value;
              final double auraSize =
                  avatarDimension + (isMobile ? 20.0 : 44.0) + (pulseValue * (isMobile ? 4.0 : 8.0));
              final double auraAlpha = isDarkMode
                  ? (0.2 + (pulseValue * 0.15))
                  : (0.12 + (pulseValue * 0.08));

              return Container(
                width: auraSize,
                height: auraSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.electricBlue.withValues(alpha: auraAlpha),
                      AppColors.brightFuchsia.withValues(
                        alpha: auraAlpha * 0.7,
                      ),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.55, 1.0],
                  ),
                ),
              );
            },
          )
        else
          Container(
            width: avatarDimension + (isMobile ? 20.0 : 44.0),
            height: avatarDimension + (isMobile ? 20.0 : 44.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.electricBlue.withValues(
                    alpha: isDarkMode ? 0.28 : 0.15,
                  ),
                  AppColors.brightFuchsia.withValues(
                    alpha: isDarkMode ? 0.18 : 0.1,
                  ),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.55, 1.0],
              ),
            ),
          ),

        // 2. Main Photo Card
        photoCard,

        // 3. Floating Flutter Tech Badge (Top Left)
        Positioned(
          top: isMobile ? -4.0 : -8.0,
          left: isMobile ? -4.0 : -8.0,
          child: flutterBadge,
        ),

        // 4. Floating Status Badge (Bottom Right)
        Positioned(
          bottom: isMobile ? -6.0 : -12.0,
          right: isMobile ? -2.0 : -4.0,
          child: statusBadge,
        ),
      ],
    );

    if (widget.disableAnimations) return presentation;

    return presentation
        .animate()
        .fade(duration: 600.ms)
        .scale(begin: const Offset(0.92, 0.92));
  }
}

class _LiveStatusIndicator extends StatefulWidget {
  final bool disableAnimations;
  final bool isMobile;

  const _LiveStatusIndicator({
    required this.disableAnimations,
    this.isMobile = false,
  });

  @override
  State<_LiveStatusIndicator> createState() => _LiveStatusIndicatorState();
}

class _LiveStatusIndicatorState extends State<_LiveStatusIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    if (!widget.disableAnimations && !_isInTest) {
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
    final Color activeColor = AppColors.liveIndicator;
    final double dotSize = widget.isMobile ? 6.0 : 8.0;
    final double pingSize = widget.isMobile ? 7.0 : 9.0;

    if (widget.disableAnimations) {
      return Container(
        width: dotSize,
        height: dotSize,
        decoration: BoxDecoration(color: activeColor, shape: BoxShape.circle),
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Outer expanding ping circle
            Transform.scale(
              scale: 1.0 + (_controller.value * 1.4),
              child: Container(
                width: pingSize,
                height: pingSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: activeColor.withValues(
                    alpha: (1.0 - _controller.value) * 0.6,
                  ),
                ),
              ),
            ),
            // Inner solid dot with glowing shadow
            Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: activeColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: activeColor.withValues(alpha: 0.4),
                    blurRadius: 6.0,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
