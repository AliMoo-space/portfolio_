import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          horizontal: isMobile ? AppSpacing.space24 : size.width * 0.1,
          vertical: isMobile ? AppSpacing.space64 : AppSpacing.space72,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, isMobile, isDarkMode, disableAnimations),
            const SizedBox(height: AppSpacing.space16),
            _buildCategoryPill(context, isDarkMode, disableAnimations),
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
        style: isMobile
            ? AppTextStyles.displaySmall
            : AppTextStyles.displayMedium,
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

  Widget _buildCategoryPill(
    BuildContext context,
    bool isDarkMode,
    bool disableAnimations,
  ) {
    final pill = Align(
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
              Icons.rocket_launch_rounded,
              size: 16,
              color: AppColors.electricBlue,
            ),
            const SizedBox(width: AppSpacing.space8),
            Flexible(
              child: AppText(
                'Featured Work & Open Source Repositories',
                style: AppTextStyles.labelSmall,
                color: AppColors.electricBlue,
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
        final int crossAxisCount =
            isMobile ? 1 : (width > 1050 ? 3 : (width > 680 ? 2 : 1));
        final double childAspectRatio =
            isMobile ? 1.25 : (width > 1050 ? 1.15 : 1.25);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSpacing.space24,
            mainAxisSpacing: AppSpacing.space24,
            childAspectRatio: childAspectRatio,
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

  @override
  Widget build(BuildContext context) {
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
            backgroundColor:
                isDarkMode ? AppColors.darkCardContainer : Colors.white,
            borderRadius: AppRadius.radius20,
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
                        alpha: isDarkMode ? 0.3 : 0.18,
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
            padding: const EdgeInsets.all(AppSpacing.space24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: isHovered
                            ? AppColors.electricBlue.withValues(alpha: 0.15)
                            : (isDarkMode
                                ? AppColors.darkSurface
                                : const Color(0xFFF1F5F9)),
                        borderRadius: BorderRadius.circular(AppRadius.radius12),
                        border: Border.all(
                          color: isHovered
                              ? AppColors.electricBlue.withValues(alpha: 0.3)
                              : Colors.transparent,
                        ),
                      ),
                      child: Icon(
                        Icons.folder_outlined,
                        size: 24,
                        color: isHovered
                            ? AppColors.electricBlue
                            : (isDarkMode
                                ? Colors.white70
                                : AppColors.textPrimary),
                      ),
                    ),
                    if (widget.project.htmlUrl.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.open_in_new_rounded, size: 20),
                        color: isHovered
                            ? AppColors.electricBlue
                            : AppColors.textSecondary,
                        onPressed: () => _launchURL(widget.project.htmlUrl),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space20),
                AppText(
                  widget.project.name,
                  style: AppTextStyles.titleLarge,
                  fontWeight: FontWeight.bold,
                  color: isHovered
                      ? AppColors.electricBlue
                      : (isDarkMode ? Colors.white : AppColors.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.space12),
                Expanded(
                  child: AppText(
                    widget.project.description.isNotEmpty
                        ? widget.project.description
                        : 'A dedicated Flutter project focusing on architecture and clean code.',
                    style: AppTextStyles.bodyMedium,
                    color: isDarkMode
                        ? AppColors.textInverse.withValues(alpha: 0.7)
                        : AppColors.textSecondary,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: AppSpacing.space16),
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
                      borderRadius:
                          BorderRadius.circular(AppRadius.radiusFull),
                      border: Border.all(
                        color: AppColors.royalViolet.withValues(alpha: 0.3),
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
                          style: AppTextStyles.labelSmall,
                          color: isDarkMode
                              ? Colors.white
                              : AppColors.royalViolet,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
