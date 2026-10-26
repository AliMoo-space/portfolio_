import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/design_system/colors/app_colors.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onCheckOutTap;

  const HeroSection({super.key, required this.onCheckOutTap});

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

        // Hero Main Content
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 640),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : size.width * 0.1,
            vertical: isMobile ? 60 : 90,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with glowing gradient frame
              _buildAvatar(context, isMobile, isDarkMode, disableAnimations),
              const SizedBox(height: 28),

              // Greeting Badge / Pill
              _buildGreetingPill(context, isDarkMode, disableAnimations),
              const SizedBox(height: 16),

              // Name with Creative Linear Gradient
              _buildGradientName(context, isMobile, disableAnimations),
              const SizedBox(height: 14),

              // Typewriter Subtitle
              _buildTypewriterSubtitle(
                context,
                isMobile,
                isDarkMode,
                disableAnimations,
              ),
              const SizedBox(height: 24),

              // Bio Description
              _buildBioDescription(
                context,
                size,
                isMobile,
                isDarkMode,
                disableAnimations,
              ),
              // Action CTA Buttons
              _buildActionButtons(
                context,
                isMobile,
                isDarkMode,
                disableAnimations,
              ),
              const SizedBox(height: 36),

              // Social Channel Icons
              _buildSocialChannels(context, isDarkMode, disableAnimations),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(
    BuildContext context,
    bool isMobile,
    bool isDarkMode,
    bool disableAnimations,
  ) {
    final avatarDimension = isMobile ? 160.0 : 220.0;

    final avatarWidget = Container(
      width: avatarDimension,
      height: avatarDimension,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isMobile ? 32 : 44),
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
        borderRadius: BorderRadius.circular(isMobile ? 28.5 : 40.5),
        child: Container(
          color: isDarkMode ? AppColors.darkSurface : Colors.white,
          child: Image.asset(
            'assets/IMG_6021.jpeg',
            fit: BoxFit.cover,
            alignment: Alignment.center,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.person_rounded,
                size: isMobile ? 64 : 88,
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
    bool isDarkMode,
    bool disableAnimations,
  ) {
    final pillWidget = Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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
          Text(
            'Hi, my name is',
            style: TextStyle(
              color: isDarkMode
                  ? AppColors.electricBlue
                  : const Color(0xFF2563EB),
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
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
    bool isMobile,
    bool disableAnimations,
  ) {
    final nameWidget = ShaderMask(
      shaderCallback: (bounds) => AppColors.heroGradient.createShader(bounds),
      child: Text(
        'Ali Mohamed.',
        style: TextStyle(
          fontSize: isMobile ? 46 : 78,
          fontWeight: FontWeight.w900,
          letterSpacing: -1.5,
          color: Colors.white,
          height: 1.1,
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
    bool isMobile,
    bool isDarkMode,
    bool disableAnimations,
  ) {
    final subtitleWidget = SizedBox(
      height: isMobile ? 48 : 64,
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            'Flutter Developer',
            textStyle: TextStyle(
              fontSize: isMobile ? 28 : 46,
              color: isDarkMode
                  ? const Color(0xFF94A3B8)
                  : const Color(0xFF475569),
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
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
    final bioWidget = SizedBox(
      width: isMobile ? double.infinity : size.width * 0.55,
      child: Text(
        'I am actively seeking new opportunities where I can contribute, grow, and deliver high-quality results. I am available for both remote and on-site positions and committed to continuous improvement.',
        style: TextStyle(
          fontSize: isMobile ? 16 : 19,
          height: 1.6,
          color: isDarkMode ? const Color(0xFFCBD5E1) : const Color(0xFF334155),
          fontWeight: FontWeight.w400,
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
      spacing: 16,
      runSpacing: 16,
      children: [
        // Primary Gradient Button
        Container(
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(12),
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
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 36,
                vertical: isMobile ? 14 : 18,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    'Check out my work!',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),

        // Outlined Download CV Button
        OutlinedButton.icon(
          onPressed: () => _launchURL(
            'https://drive.google.com/drive/folders/1axHapRU2vwj_838B8KlsThV3VgEh1oTa?usp=sharing',
          ),
          icon: Icon(
            Icons.download_rounded,
            size: 18,
            color: isDarkMode ? Colors.white : const Color(0xFF0F172A),
          ),
          label: Text(
            'Download CV',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white : const Color(0xFF0F172A),
            ),
            overflow: TextOverflow.ellipsis,
          ),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 36,
              vertical: isMobile ? 14 : 18,
            ),
            side: BorderSide(
              color: isDarkMode
                  ? AppColors.darkBorder
                  : const Color(0xFFCBD5E1),
              width: 1.5,
            ),
            backgroundColor: isDarkMode
                ? AppColors.darkSurface.withValues(alpha: 0.6)
                : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
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
