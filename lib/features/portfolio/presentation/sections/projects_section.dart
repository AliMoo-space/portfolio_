import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/design_system/colors/app_colors.dart';
import '../../../../core/design_system/spacing/app_radius.dart';
import '../../../../core/design_system/spacing/app_spacing.dart';
import '../../../../core/design_system/typography/app_text_styles.dart';
import '../../../../core/design_system/widgets/buttons/app_button.dart';
import '../../../../core/design_system/widgets/empty_view/empty_view.dart';
import '../../../../core/design_system/widgets/feedback/app_error_state.dart';
import '../../../../core/design_system/widgets/feedback/app_loader.dart';
import '../../../../core/design_system/widgets/layout/app_card.dart';
import '../../../../core/design_system/widgets/text/app_text.dart';
import '../../../../core/di/injection.dart';
import '../../data/models/project_model.dart';
import '../cubit/projects_cubit.dart';
import '../cubit/projects_state.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  Future<void> _openAllProjects() async {
    final uri = Uri.parse('https://github.com/AliMoo-space?tab=repositories');
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      debugPrint('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 640;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final disableAnimations = MediaQuery.of(context).disableAnimations;

    return BlocProvider(
      create: (context) => sl<ProjectsCubit>()..fetchProjects(),
      child: Container(
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
            const SizedBox(height: AppSpacing.space48),
            BlocBuilder<ProjectsCubit, ProjectsState>(
              builder: (context, state) {
                if (state is ProjectsLoading) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.space64),
                    child: Center(child: AppLoader.large()),
                  );
                } else if (state is ProjectsError) {
                  return AppErrorState(
                    message: state.message,
                    buttonText: 'Try Again',
                    onRetry: () =>
                        context.read<ProjectsCubit>().fetchProjects(),
                  );
                } else if (state is ProjectsLoaded) {
                  return _buildProjectsGrid(
                    context,
                    state.projects,
                    isMobile,
                    isDarkMode,
                    disableAnimations,
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: AppSpacing.space48),
            Center(
              child: SizedBox(
                width: isMobile ? double.infinity : 320,
                child: AppButton(
                  text: 'View All Projects on GitHub',
                  variant: AppButtonVariant.outlined,
                  leading: const Icon(Icons.code_rounded, size: 20),
                  onPressed: _openAllProjects,
                ),
              ),
            ),
          ],
        ),
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
        "Some Things I've Built",
        style: AppTextStyles.sectionTitle(context),
        color: Colors.white,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
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

  Widget _buildProjectsGrid(
    BuildContext context,
    List<ProjectModel> projects,
    bool isMobile,
    bool isDarkMode,
    bool disableAnimations,
  ) {
    if (projects.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.space48),
        child: EmptyView(
          title: 'No projects found.',
          message: 'Check back soon for new repositories.',
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final int crossAxisCount = isMobile
            ? 1
            : (width > 1050 ? 3 : (width > 680 ? 2 : 1));
        final double mainAxisExtent = isMobile ? 395.0 : 420.0;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSpacing.space24,
            mainAxisSpacing: AppSpacing.space24,
            mainAxisExtent: mainAxisExtent,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            final card = ProjectCard(project: project);

            if (disableAnimations) return card;

            return card
                .animate(delay: (100 * index).ms)
                .fade(duration: 500.ms)
                .slideY(begin: 0.1);
          },
        );
      },
    );
  }
}

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      debugPrint('Could not launch $url');
    }
  }

  IconData _getProjectIcon(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('trendora') ||
        lower.contains('store') ||
        lower.contains('shop') ||
        lower.contains('cosmetics')) {
      return Icons.shopping_bag_outlined;
    }
    if (lower.contains('rental') || lower.contains('home')) {
      return Icons.home_work_outlined;
    }
    if (lower.contains('tranqulity') || lower.contains('meditat')) {
      return Icons.spa_outlined;
    }
    if (lower.contains('fit') || lower.contains('scale')) {
      return Icons.fitness_center_outlined;
    }
    if (lower.contains('news')) {
      return Icons.newspaper_outlined;
    }
    return Icons.devices_rounded;
  }

  String _getProjectCategory(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('trendora')) return 'E-Commerce App';
    if (lower.contains('cosmetics')) return 'Store & Delivery';
    if (lower.contains('rental')) return 'Sharing Platform';
    if (lower.contains('tranqulity')) return 'Mindfulness App';
    if (lower.contains('tharad')) return 'Mobile Application';
    return 'Flutter Application';
  }

  Widget _buildFallbackThumbnail(
    BuildContext context,
    bool isDarkMode,
    bool isHovered,
    bool disableAnimations, {
    double height = 180,
  }) {
    final iconData = _getProjectIcon(widget.project.name);
    final categoryText = _getProjectCategory(widget.project.name);

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [
                  const Color(0xFF0F172A),
                  AppColors.darkSurface,
                  const Color(0xFF1E293B),
                ]
              : [
                  const Color(0xFFF8FAFC),
                  const Color(0xFFF1F5F9),
                  const Color(0xFFE2E8F0),
                ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -25,
            right: -25,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.electricBlue.withValues(
                      alpha: isDarkMode ? 0.22 : 0.12,
                    ),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -25,
            left: -25,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.royalViolet.withValues(
                      alpha: isDarkMode ? 0.18 : 0.10,
                    ),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: isHovered
                        ? AppColors.heroGradient
                        : LinearGradient(
                            colors: isDarkMode
                                ? [
                                    AppColors.darkCardContainer,
                                    AppColors.darkSurface,
                                  ]
                                : [
                                    Colors.white,
                                    const Color(0xFFF1F5F9),
                                  ],
                          ),
                    borderRadius: BorderRadius.circular(AppRadius.radius16),
                    border: Border.all(
                      color: isHovered
                          ? AppColors.electricBlue
                          : (isDarkMode
                                ? AppColors.darkBorder
                                : AppColors.outlineVariant),
                      width: 1.2,
                    ),
                    boxShadow: isHovered
                        ? [
                            BoxShadow(
                              color: AppColors.electricBlue.withValues(
                                alpha: 0.35,
                              ),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Center(
                    child: Icon(
                      iconData,
                      size: 26,
                      color: isHovered
                          ? Colors.white
                          : (isDarkMode
                                ? AppColors.cyanAccent
                                : AppColors.electricBlue),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.space12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.space12,
                    vertical: AppSpacing.space4,
                  ),
                  decoration: BoxDecoration(
                    color: (isDarkMode ? Colors.black : Colors.white)
                        .withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(AppRadius.radiusFull),
                    border: Border.all(
                      color: (isDarkMode
                              ? AppColors.darkBorder
                              : AppColors.outlineVariant)
                          .withValues(alpha: 0.6),
                    ),
                  ),
                  child: AppText(
                    categoryText,
                    style: AppTextStyles.labelSmall.copyWith(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                    color: isDarkMode
                        ? const Color(0xFFE2E8F0)
                        : AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardThumbnail(
    BuildContext context,
    bool isMobile,
    bool isDarkMode,
    bool isHovered,
    bool disableAnimations,
  ) {
    final double thumbHeight = isMobile ? 155.0 : 180.0;
    Widget content;
    if (widget.project.imageAsset != null) {
      content = Image.asset(
        widget.project.imageAsset!,
        width: double.infinity,
        height: thumbHeight,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            _buildFallbackThumbnail(
              context,
              isDarkMode,
              isHovered,
              disableAnimations,
              height: thumbHeight,
            ),
      );
    } else if (widget.project.imageUrl != null &&
        widget.project.imageUrl!.startsWith('http')) {
      content = CachedNetworkImage(
        imageUrl: widget.project.imageUrl!,
        width: double.infinity,
        height: thumbHeight,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          height: thumbHeight,
          color: isDarkMode
              ? AppColors.darkSurface
              : const Color(0xFFF1F5F9),
          child: const Center(child: AppLoader()),
        ),
        errorWidget: (context, url, error) => _buildFallbackThumbnail(
          context,
          isDarkMode,
          isHovered,
          disableAnimations,
          height: thumbHeight,
        ),
      );
    } else {
      content = _buildFallbackThumbnail(
        context,
        isDarkMode,
        isHovered,
        disableAnimations,
        height: thumbHeight,
      );
    }

    return SizedBox(
      height: thumbHeight,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedScale(
              scale: (isHovered && !disableAnimations) ? 1.05 : 1.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              child: content,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 1,
              color: isDarkMode
                  ? AppColors.darkBorder
                  : AppColors.outlineVariant,
            ),
          ),
          if (widget.project.playStoreUrl != null)
            Positioned(
              top: AppSpacing.space12,
              left: AppSpacing.space12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space8,
                  vertical: AppSpacing.space4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF00865F).withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(AppRadius.radiusFull),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.shop_rounded, size: 13, color: Colors.white),
                    const SizedBox(width: AppSpacing.space4),
                    AppText(
                      'Google Play',
                      style: AppTextStyles.labelSmall.copyWith(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                      ),
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),
          if (widget.project.fork)
            Positioned(
              top: AppSpacing.space12,
              right: AppSpacing.space12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space8,
                  vertical: AppSpacing.space4,
                ),
                decoration: BoxDecoration(
                  color: (isDarkMode ? AppColors.darkSurface : Colors.white)
                      .withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(AppRadius.radiusFull),
                  border: Border.all(
                    color: isDarkMode
                        ? AppColors.darkBorder
                        : AppColors.outlineVariant,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.fork_right_rounded,
                      size: 14,
                      color: isDarkMode
                          ? Colors.white70
                          : AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppSpacing.space4),
                    AppText(
                      'Forked Repo',
                      style: AppTextStyles.labelSmall.copyWith(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                      color: isDarkMode
                          ? const Color(0xFFE2E8F0)
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 640;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final disableAnimations = MediaQuery.of(context).disableAnimations;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (widget.project.htmlUrl.isNotEmpty) {
            _launchURL(widget.project.htmlUrl);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          transform: (!disableAnimations && isHovered)
              ? Matrix4.translationValues(0.0, -6.0, 0.0)
              : Matrix4.identity(),
          child: AppCard(
            backgroundColor: isDarkMode
                ? AppColors.darkCardContainer
                : Colors.white,
            borderRadius: AppRadius.radius20,
            border: Border.all(
              color: isHovered
                  ? AppColors.electricBlue
                  : (isDarkMode
                        ? AppColors.darkBorder
                        : AppColors.outlineVariant),
              width: isHovered ? 1.5 : 1.0,
            ),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: AppColors.electricBlue.withValues(
                        alpha: isDarkMode ? 0.35 : 0.18,
                      ),
                      offset: const Offset(0, 10),
                      blurRadius: 24,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDarkMode ? 0.25 : 0.04,
                      ),
                      offset: const Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
            padding: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.radius20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCardThumbnail(
                    context,
                    isMobile,
                    isDarkMode,
                    isHovered,
                    disableAnimations,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(
                        isMobile ? AppSpacing.space16 : AppSpacing.space20,
                      ),  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: AppText(
                                  widget.project.name,
                                  style: AppTextStyles.titleMedium.copyWith(
                                    fontSize: isMobile ? 17.0 : 18.0,
                                  ),
                                  fontWeight: FontWeight.bold,
                                  color: isHovered
                                      ? AppColors.electricBlue
                                      : (isDarkMode
                                            ? Colors.white
                                            : AppColors.textPrimary),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.space8),
                              if (widget.project.playStoreUrl != null) ...[
                                _ProjectActionButton(
                                  icon: FontAwesomeIcons.googlePlay,
                                  tooltip: 'View on Google Play',
                                  isDarkMode: isDarkMode,
                                  activeColor: const Color(0xFF00A86B),
                                  onTap: () => _launchURL(
                                    widget.project.playStoreUrl!,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.space8),
                              ],
                              if (widget.project.htmlUrl.isNotEmpty)
                                _ProjectActionButton(
                                  icon: FontAwesomeIcons.github,
                                  tooltip: 'View on GitHub',
                                  isDarkMode: isDarkMode,
                                  activeColor: AppColors.electricBlue,
                                  onTap: () =>
                                      _launchURL(widget.project.htmlUrl),
                                ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.space8),
                          Expanded(
                            child: AppText(
                              widget.project.description.isNotEmpty
                                  ? widget.project.description
                                  : 'A dedicated Flutter project focusing on architecture and clean code.',
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontSize: isMobile ? 14.0 : 14.5,
                                height: 1.5,
                              ),
                              color: isDarkMode
                                  ? const Color(0xFFCBD5E1)
                                  : AppColors.textSecondary,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.space12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (widget.project.language != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.space12,
                                    vertical: AppSpacing.space4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.royalViolet.withValues(
                                      alpha: isDarkMode ? 0.2 : 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      AppRadius.radiusFull,
                                    ),
                                    border: Border.all(
                                      color: AppColors.royalViolet.withValues(
                                        alpha: 0.3,
                                      ),
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
                                          color: AppColors.royalViolet,
                                        ),
                                      ),
                                      const SizedBox(width: AppSpacing.space8),
                                       AppText(
                                        widget.project.language!,
                                        style: AppTextStyles.labelSmall.copyWith(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        color: isDarkMode
                                            ? Colors.white
                                            : AppColors.royalViolet,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                )
                              else
                                const SizedBox(),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppText(
                                    'Details',
                                    style: AppTextStyles.labelSmall.copyWith(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    color: isHovered
                                        ? AppColors.electricBlue
                                        : (isDarkMode
                                              ? const Color(0xFF94A3B8)
                                              : AppColors.textSecondary),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(width: AppSpacing.space4),
                                  AnimatedSlide(
                                    duration: const Duration(milliseconds: 200),
                                    offset: (isHovered && !disableAnimations)
                                        ? const Offset(0.2, 0)
                                        : Offset.zero,
                                    child: Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 14,
                                      color: isHovered
                                          ? AppColors.electricBlue
                                          : (isDarkMode
                                                ? const Color(0xFF94A3B8)
                                                : AppColors.textSecondary),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectActionButton extends StatefulWidget {
  final dynamic icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool isDarkMode;
  final Color? activeColor;

  const _ProjectActionButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    required this.isDarkMode,
    this.activeColor,
  });

  @override
  State<_ProjectActionButton> createState() => _ProjectActionButtonState();
}

class _ProjectActionButtonState extends State<_ProjectActionButton> {
  bool isButtonHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 640;
    final effectiveColor = widget.activeColor ?? AppColors.electricBlue;
    final double buttonDimension = isMobile ? 40.0 : 36.0;

    return MouseRegion(
      onEnter: (_) => setState(() => isButtonHovered = true),
      onExit: (_) => setState(() => isButtonHovered = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: buttonDimension,
            height: buttonDimension,
            decoration: BoxDecoration(
              color: isButtonHovered
                  ? effectiveColor.withValues(alpha: 0.15)
                  : (widget.isDarkMode
                        ? AppColors.darkSurface
                        : const Color(0xFFF1F5F9)),
              borderRadius: BorderRadius.circular(AppRadius.radius12),
              border: Border.all(
                color: isButtonHovered
                    ? effectiveColor.withValues(alpha: 0.6)
                    : (widget.isDarkMode
                          ? AppColors.darkBorder
                          : AppColors.outlineVariant),
                width: 1,
              ),
              boxShadow: isButtonHovered
                  ? [
                      BoxShadow(
                        color: effectiveColor.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: widget.icon is IconData
                  ? Icon(
                      widget.icon as IconData,
                      size: 16,
                      color: isButtonHovered
                          ? effectiveColor
                          : (widget.isDarkMode
                                ? Colors.white70
                                : AppColors.textSecondary),
                    )
                  : FaIcon(
                      widget.icon,
                      size: 16,
                      color: isButtonHovered
                          ? effectiveColor
                          : (widget.isDarkMode
                                ? Colors.white70
                                : AppColors.textSecondary),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
