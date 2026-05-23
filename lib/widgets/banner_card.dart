import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../data/menu_data.dart';
import '../theme/app_theme.dart';

class StoryThumb extends StatelessWidget {
  const StoryThumb({super.key, required this.story, required this.onTap});
  final StoryCard story;
  final VoidCallback onTap;

  static const _borderRadius = BorderRadius.only(
    topLeft: Radius.circular(80),
    topRight: Radius.circular(80),
    bottomLeft: Radius.circular(12),
    bottomRight: Radius.circular(12),
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: _borderRadius,
      child: Container(
        width: 112,
        height: 144,
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          border: Border.all(color: AppColors.borderStrong, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: story.coverUrl,
              fit: BoxFit.cover,
              placeholder: (_, _) => Container(color: AppColors.divider),
              errorWidget: (_, _, _) => Container(color: AppColors.divider),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.55),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Text(
                story.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
