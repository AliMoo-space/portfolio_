import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:portfolio/core/design_system/spacing/app_radius.dart';
import 'package:portfolio/core/design_system/spacing/app_spacing.dart';
import 'package:portfolio/core/design_system/widgets/buttons/app_icon_button.dart';

/// Shows a full-screen interactive image viewer.
///
/// Supports in-memory [bytes] (e.g. freshly picked image), asset images via
/// [imageAsset], and remote [imageUrl] URLs. For protected URLs pass
/// [httpHeaders] so the Authorization header is included in the request.
Future<void> showProfilePhotoViewer(
  BuildContext context, {
  Uint8List? bytes,
  String? imageUrl,
  String? imageAsset,
  // HTTP headers forwarded to Image.network for protected image URLs.
  Map<String, String>? httpHeaders,
}) {
  return showDialog<void>(
    context: context,
    barrierColor: Colors.black87,
    builder: (context) {
      final screenSize = MediaQuery.sizeOf(context);
      final Widget image;
      if (bytes != null) {
        image = Image.memory(bytes, fit: BoxFit.contain);
      } else if (imageAsset != null) {
        image = Image.asset(
          imageAsset,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.broken_image_outlined,
            color: Colors.white,
            size: 64,
          ),
        );
      } else {
        image = Image.network(
          imageUrl ?? '',
          headers: httpHeaders,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.broken_image_outlined,
            color: Colors.white,
            size: 64,
          ),
        );
      }

      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(AppSpacing.space24),
        child: Stack(
          alignment: Alignment.center,
          children: [
            InteractiveViewer(
              minScale: 0.8,
              maxScale: 4,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenSize.width - 48.0,
                  maxHeight: screenSize.height - 48.0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.radius16),
                  child: image,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: AppIconButton(
                variant: AppIconButtonVariant.ghost,
                tooltip: 'Close image',
                onPressed: () => Navigator.of(context).pop(),
                icon: Icons.close,
              ),
            ),
          ],
        ),
      );
    },
  );
}
