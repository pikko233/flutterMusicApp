import 'package:flutter/material.dart';
import 'package:flutter_music_app/constants/app_colors.dart';

class PlaylistSongCell extends StatelessWidget {
  final int index;
  final bool isPlaying;
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onPressedPlay;
  final VoidCallback onPressedMore;
  const PlaylistSongCell({
    super.key,
    this.isPlaying = false,
    required this.index,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onPressedPlay,
    required this.onPressedMore,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isPlaying
          ? AppColors.primary.withValues(alpha: 0.12)
          : AppColors.bgCard,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
        side: BorderSide(
          color: isPlaying
              ? AppColors.primary.withValues(alpha: 0.3)
              : Colors.transparent,
        ),
      ),
      child: ListTile(
        onTap: onPressedPlay,
        contentPadding: EdgeInsets.zero,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 36,
              child: Text(
                "${index + 1}",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textHint, fontSize: 13),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              maxLines: 1,
              style: TextStyle(
                color: isPlaying ? AppColors.primary : AppColors.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Opacity(
              opacity: isPlaying ? 1.0 : 0.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_arrow,
                      color: AppColors.primary.withValues(alpha: 0.7),
                      size: 13,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      "播放中",
                      style: TextStyle(
                        color: AppColors.primary.withValues(alpha: 0.7),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        subtitle: Text(
          subtitle,
          maxLines: 1,
          style: TextStyle(
            color: AppColors.textPrimary60,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: IconButton(
          onPressed: onPressedMore,
          icon: Icon(Icons.more_horiz, color: AppColors.textPrimary40),
        ),
      ),
    );
  }
}
