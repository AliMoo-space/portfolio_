import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/design_system/colors/app_colors.dart';
import '../../../../core/design_system/typography/app_text_styles.dart';
import '../../../../core/theme/theme_cubit.dart';

class NavBar extends StatelessWidget {
  final VoidCallback onHeroTap;
  final VoidCallback onAboutTap;
  final VoidCallback onSkillsTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  const NavBar({
    super.key,
    required this.onHeroTap,
    required this.onAboutTap,
    required this.onSkillsTap,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().state;
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 640;
    final isDesktop = size.width > 840;
    final horizontalPadding = isMobile
        ? (size.width < 360 ? 12.0 : 20.0)
        : (size.width < 1024 ? size.width * 0.06 : size.width * 0.1);

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: isMobile ? 14 : 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo with Creative Gradient
          Flexible(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: onHeroTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: ShaderMask(
                        shaderCallback: (bounds) =>
                            AppColors.heroGradient.createShader(bounds),
                        child: Text(
                          'Ali Mohamed',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.navLogo(
                            fontSize: isDesktop
                                ? 22.0
                                : (size.width < 360 ? 16.0 : 18.0),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 4, top: 2),
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.brightFuchsia,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Desktop Navigation Links
          if (isDesktop)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _NavTextButton(
                  title: 'About',
                  onTap: onAboutTap,
                  isDarkMode: isDarkMode,
                ),
                _NavTextButton(
                  title: 'Skills',
                  onTap: onSkillsTap,
                  isDarkMode: isDarkMode,
                ),
                _NavTextButton(
                  title: 'Projects',
                  onTap: onProjectsTap,
                  isDarkMode: isDarkMode,
                ),
                _NavTextButton(
                  title: 'Contact',
                  onTap: onContactTap,
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(width: 12),
                _ThemeToggleButton(isDarkMode: isDarkMode),
              ],
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ThemeToggleButton(isDarkMode: isDarkMode),
                const SizedBox(width: 8),
                _MobileMenuButton(
                  isDarkMode: isDarkMode,
                  onOpen: () => _openMobileMenu(context, isDarkMode),
                ),
              ],
            ),
        ],
      ),
    );
  }

  void _openMobileMenu(BuildContext context, bool isDarkMode) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (modalContext) {
        return Container(
          decoration: BoxDecoration(
            color: isDarkMode ? AppColors.darkCardContainer : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(
              top: BorderSide(
                color: isDarkMode
                    ? AppColors.darkBorder
                    : const Color(0xFFE2E8F0),
                width: 1.5,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDarkMode ? 0.4 : 0.12),
                blurRadius: 24,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? AppColors.darkBorder
                        : const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.heroGradient.createShader(bounds),
                      child: Text(
                        'Navigation',
                        style: AppTextStyles.titleLarge.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close_rounded,
                        size: 22,
                        color: isDarkMode
                            ? Colors.white70
                            : const Color(0xFF64748B),
                      ),
                      onPressed: () => Navigator.of(modalContext).pop(),
                      tooltip: 'Close menu',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _MobileNavItem(
                  icon: Icons.home_rounded,
                  title: 'Home',
                  isDarkMode: isDarkMode,
                  onTap: () {
                    Navigator.of(modalContext).pop();
                    onHeroTap();
                  },
                ),
                _MobileNavItem(
                  icon: Icons.person_rounded,
                  title: 'About',
                  isDarkMode: isDarkMode,
                  onTap: () {
                    Navigator.of(modalContext).pop();
                    onAboutTap();
                  },
                ),
                _MobileNavItem(
                  icon: Icons.code_rounded,
                  title: 'Skills',
                  isDarkMode: isDarkMode,
                  onTap: () {
                    Navigator.of(modalContext).pop();
                    onSkillsTap();
                  },
                ),
                _MobileNavItem(
                  icon: Icons.auto_awesome_rounded,
                  title: 'Projects',
                  isDarkMode: isDarkMode,
                  onTap: () {
                    Navigator.of(modalContext).pop();
                    onProjectsTap();
                  },
                ),
                _MobileNavItem(
                  icon: Icons.mail_rounded,
                  title: 'Contact',
                  isDarkMode: isDarkMode,
                  onTap: () {
                    Navigator.of(modalContext).pop();
                    onContactTap();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onOpen;

  const _MobileMenuButton({
    required this.isDarkMode,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkSurface : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDarkMode ? AppColors.darkBorder : const Color(0xFFE2E8F0),
        ),
      ),
      child: IconButton(
        icon: Icon(
          Icons.menu_rounded,
          size: 20,
          color: isDarkMode ? Colors.white : const Color(0xFF0F172A),
        ),
        onPressed: onOpen,
        tooltip: 'Open navigation menu',
        constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
        padding: EdgeInsets.zero,
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isDarkMode;
  final VoidCallback onTap;

  const _MobileNavItem({
    required this.icon,
    required this.title,
    required this.isDarkMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: (isDarkMode ? Colors.white : Colors.black)
                  .withValues(alpha: 0.03),
              border: Border.all(
                color: isDarkMode
                    ? AppColors.darkBorder.withValues(alpha: 0.5)
                    : const Color(0xFFE2E8F0),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.electricBlue.withValues(
                      alpha: isDarkMode ? 0.18 : 0.1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: AppColors.electricBlue,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: isDarkMode ? Colors.white38 : const Color(0xFF94A3B8),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavTextButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool isDarkMode;

  const _NavTextButton({
    required this.title,
    required this.onTap,
    required this.isDarkMode,
  });

  @override
  State<_NavTextButton> createState() => _NavTextButtonState();
}

class _NavTextButtonState extends State<_NavTextButton> {
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
        child: AnimatedContainer(
          duration: disableAnimations
              ? Duration.zero
              : const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isHovered
                ? (widget.isDarkMode
                      ? AppColors.electricBlue.withValues(alpha: 0.15)
                      : AppColors.electricBlue.withValues(alpha: 0.1))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isHovered
                  ? AppColors.electricBlue.withValues(alpha: 0.4)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Text(
            widget.title,
            style: AppTextStyles.navItem(
              fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
              fontSize: 15,
              color: isHovered
                  ? (widget.isDarkMode
                        ? AppColors.electricBlue
                        : const Color(0xFF2563EB))
                  : (widget.isDarkMode
                        ? const Color(0xFFCBD5E1)
                        : const Color(0xFF475569)),
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemeToggleButton extends StatelessWidget {
  final bool isDarkMode;

  const _ThemeToggleButton({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkSurface : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDarkMode ? AppColors.darkBorder : const Color(0xFFE2E8F0),
        ),
      ),
      child: IconButton(
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, anim) =>
              RotationTransition(turns: anim, child: child),
          child: Icon(
            isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            key: ValueKey(isDarkMode),
            size: 20,
            color: isDarkMode
                ? const Color(0xFFFACC15)
                : const Color(0xFF6366F1),
          ),
        ),
        onPressed: () {
          context.read<ThemeCubit>().toggleTheme();
        },
        tooltip: isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
        constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
