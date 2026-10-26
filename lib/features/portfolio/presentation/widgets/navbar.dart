import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/design_system/colors/app_colors.dart';
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
    final horizontalPadding = isMobile ? 24.0 : size.width * 0.1;

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: isMobile ? 18 : 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              // Logo with Creative Gradient
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onHeroTap,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) =>
                            AppColors.heroGradient.createShader(bounds),
                        child: Text(
                          'Ali Mohamed',
                          style: TextStyle(
                            fontSize: isDesktop ? 22 : 18,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                            color: Colors.white,
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
                    PopupMenuButton<String>(
                      icon: Icon(
                        Icons.menu_rounded,
                        color: isDarkMode
                            ? Colors.white
                            : const Color(0xFF0F172A),
                      ),
                      color: isDarkMode ? AppColors.darkSurface : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isDarkMode
                              ? AppColors.darkBorder
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      onSelected: (value) {
                        switch (value) {
                          case 'Hero':
                            onHeroTap();
                            break;
                          case 'About':
                            onAboutTap();
                            break;
                          case 'Skills':
                            onSkillsTap();
                            break;
                          case 'Projects':
                            onProjectsTap();
                            break;
                          case 'Contact':
                            onContactTap();
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'Hero', child: Text('Home')),
                        const PopupMenuItem(
                          value: 'About',
                          child: Text('About'),
                        ),
                        const PopupMenuItem(
                          value: 'Skills',
                          child: Text('Skills'),
                        ),
                        const PopupMenuItem(
                          value: 'Projects',
                          child: Text('Projects'),
                        ),
                        const PopupMenuItem(
                          value: 'Contact',
                          child: Text('Contact'),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
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
            style: TextStyle(
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
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
