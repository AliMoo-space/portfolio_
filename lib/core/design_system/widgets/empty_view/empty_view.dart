import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portfolio/core/design_system/spacing/app_spacing.dart';
import 'package:portfolio/core/design_system/typography/app_text_styles.dart';
import 'package:portfolio/core/design_system/widgets/text/app_text.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    this.icon = Icons.assignment_turned_in_outlined,
    this.title,
    this.message,
    this.iconSize = 48,
    this.iconColor,
  });

  final IconData icon;
  final String? title;
  final String? message;
  final double iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: iconColor ?? Theme.of(context).colorScheme.primary,
            ),
            const Gap(AppSpacing.space12),
            AppText(
              title ?? 'No items found',
              style: AppTextStyles.titleLarge,
            ),
            const Gap(AppSpacing.space8),
            AppText(
              message ?? 'There is nothing to display right now.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
