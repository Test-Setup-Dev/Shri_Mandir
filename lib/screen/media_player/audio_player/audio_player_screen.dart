import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/model/home_data.dart';
import 'package:mandir/screen/media_player/audio_player/controller.dart';
import 'package:mandir/utils/helper.dart';

class AudioPlayerScreen extends StatelessWidget {
  final MediaItem mediaItem;

  const AudioPlayerScreen({super.key, required this.mediaItem});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AudioPlayerController(mediaItem: mediaItem));

    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ThemeColors.primaryColor.withOpacity(0.1),
              ThemeColors.backgroundColor,
              ThemeColors.accentColor.withOpacity(0.1),
            ],
          ),
          image: DecorationImage(
            image: NetworkImage(mediaItem.thumbnailUrl),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(controller),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    children: [
                      4.h.vs,
                      _buildAlbumArt(controller),
                      4.h.vs,
                      _buildTrackInfo(),
                      3.h.vs,
                      _buildProgressSection(controller),
                      4.h.vs,
                      _buildPlayerControls(controller),
                      4.h.vs,
                      _buildVolumeControl(controller),
                      3.h.vs,
                      _buildAdditionalControls(controller),
                      4.h.vs,
                      _buildRelatedTracks(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(AudioPlayerController controller) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: ThemeColors.white,
              borderRadius: BorderRadius.circular(6.w),
              boxShadow: [
                BoxShadow(
                  color: ThemeColors.greyColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(6.w),
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: ThemeColors.defaultTextColor,
                size: 5.w,
              ),
            ),
          ),
          Spacer(),
          Text(
            'Now Playing',
            style: TextStyle(
              color: ThemeColors.defaultTextColor,
              fontSize: 4.5.w,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: ThemeColors.white,
              borderRadius: BorderRadius.circular(6.w),
              boxShadow: [
                BoxShadow(
                  color: ThemeColors.greyColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(6.w),
              onTap: controller.toggleFavorite,
              child: Obx(
                () => Icon(
                  controller.isFavorite.value
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color:
                      controller.isFavorite.value
                          ? ThemeColors.accentColor
                          : ThemeColors.greyColor,
                  size: 5.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlbumArt(AudioPlayerController controller) {
    return Container(
      width: 70.w,
      height: 70.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.w),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.primaryColor.withOpacity(0.3),
            blurRadius: 25,
            offset: Offset(0, 10),
            spreadRadius: 5,
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6.w),
            child: Image.network(
              mediaItem.thumbnailUrl,
              width: 70.w,
              height: 70.w,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ThemeColors.primaryColor,
                          ThemeColors.accentColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(6.w),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.music_note,
                        color: ThemeColors.white,
                        size: 20.w,
                      ),
                    ),
                  ),
            ),
          ),
          Obx(
            () => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.w),
                border: Border.all(
                  color:
                      controller.isPlaying.value
                          ? ThemeColors.primaryColor
                          : Colors.transparent,
                  width: 3,
                ),
              ),
            ),
          ),
          if (controller.isPlaying.value)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.w),
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      ThemeColors.primaryColor.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTrackInfo() {
    return Column(
      children: [
        Text(
          mediaItem.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.defaultTextColor,
            fontSize: 6.w,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        1.h.vs,
        Text(
          mediaItem.artist,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.greyColor,
            fontSize: 4.w,
            fontWeight: FontWeight.w500,
          ),
        ),
        0.5.h.vs,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
          decoration: BoxDecoration(
            color: ThemeColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Text(
            'mediaItem.category!.name',
            style: TextStyle(
              color: ThemeColors.primaryColor,
              fontSize: 3.w,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection(AudioPlayerController controller) {
    return Column(
      children: [
        Obx(
          () => Container(
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: 1.w,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 3.w),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 5.w),
                activeTrackColor: ThemeColors.primaryColor,
                inactiveTrackColor: ThemeColors.greyColor.withOpacity(0.3),
                thumbColor: ThemeColors.primaryColor,
                overlayColor: ThemeColors.primaryColor.withOpacity(0.2),
              ),
              child: Slider(
                value: controller.currentPosition.value,
                max: controller.totalDuration.value,
                onChanged: controller.seekTo,
              ),
            ),
          ),
        ),
        1.h.vs,
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.formatDuration(controller.currentPosition.value),
                style: TextStyle(
                  color: ThemeColors.primaryColor,
                  fontSize: 3.w,
                ),
              ),
              Text(
                controller.formatDuration(controller.totalDuration.value),
                style: TextStyle(
                  color: ThemeColors.primaryColor,
                  fontSize: 3.w,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerControls(AudioPlayerController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w),
      decoration: BoxDecoration(
        color: ThemeColors.white,
        borderRadius: BorderRadius.circular(4.w),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.greyColor.withOpacity(0.2),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildControlButton(
            icon: Icons.shuffle,
            onTap: controller.toggleShuffle,
            controller: controller,
            isToggle: true,
            isActive: controller.isShuffleOn,
          ),
          _buildControlButton(
            icon: Icons.skip_previous,
            onTap: controller.previousTrack,
            controller: controller,
            size: 8.w,
          ),
          Obx(
            () => Container(
              width: 16.w,
              height: 16.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [ThemeColors.primaryColor, ThemeColors.accentColor],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ThemeColors.primaryColor.withOpacity(0.3),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(8.w),
                onTap: controller.togglePlayPause,
                child: Center(
                  child: Icon(
                    controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                    color: ThemeColors.white,
                    size: 10.w,
                  ),
                ),
              ),
            ),
          ),
          _buildControlButton(
            icon: Icons.skip_next,
            onTap: controller.nextTrack,
            controller: controller,
            size: 8.w,
          ),
          _buildControlButton(
            icon: Icons.repeat,
            onTap: controller.toggleRepeat,
            controller: controller,
            isToggle: true,
            isActive: controller.isRepeatOn,
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
    required AudioPlayerController controller,
    double? size,
    bool isToggle = false,
    RxBool? isActive,
  }) {
    if (isToggle && isActive != null) {
      return Obx(
        () => Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color:
                isActive.value
                    ? ThemeColors.primaryColor.withAlpha(80)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(6.w),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(6.w),
            onTap: onTap,
            child: Center(child: Icon(icon, size: size ?? 6.w)),
          ),
        ),
      );
    } else {
      return InkWell(
        borderRadius: BorderRadius.circular(6.w),
        onTap: onTap,
        child: Center(child: Icon(icon, size: size ?? 6.w)),
      );
    }
  }

  Widget _buildVolumeControl(AudioPlayerController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w),
      decoration: BoxDecoration(
        color: ThemeColors.white,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.greyColor.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.volume_down, color: ThemeColors.greyColor, size: 5.w),
          Expanded(
            child: Obx(
              () => SliderTheme(
                data: SliderThemeData(
                  trackHeight: 0.5.w,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 2.w),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 4.w),
                  activeTrackColor: ThemeColors.primaryColor,
                  inactiveTrackColor: ThemeColors.greyColor.withOpacity(0.3),
                  thumbColor: ThemeColors.primaryColor,
                ),
                child: Slider(
                  value: controller.volume.value,
                  onChanged: controller.setVolume,
                ),
              ),
            ),
          ),
          Icon(Icons.volume_up, color: ThemeColors.greyColor, size: 5.w),
        ],
      ),
    );
  }

  Widget _buildAdditionalControls(AudioPlayerController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(
          icon: Icons.playlist_add,
          label: 'Playlist',
          onTap: () => controller.addToPlaylist(),
        ),
        _buildActionButton(
          icon: Icons.share,
          label: 'Share',
          onTap: () => controller.shareTrack(),
        ),
        _buildActionButton(
          icon: Icons.download,
          label: 'Download',
          onTap: () => controller.downloadTrack(),
        ),
        _buildActionButton(
          icon: Icons.timer,
          label: 'Sleep Timer',
          onTap: () => controller.setSleepTimer(),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.w),
        decoration: BoxDecoration(
          color: ThemeColors.white,
          borderRadius: BorderRadius.circular(3.w),
          border: Border.all(color: ThemeColors.greyColor.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: ThemeColors.greyColor.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: ThemeColors.primaryColor, size: 5.w),
            0.5.h.vs,
            Text(
              label,
              style: TextStyle(
                color: ThemeColors.greyColor,
                fontSize: 2.5.w,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedTracks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // 'More from ${mediaItem.category!.name}',
          'More from {mediaItem.category!.name}',
          style: TextStyle(
            color: ThemeColors.defaultTextColor,
            fontSize: 4.w,
            fontWeight: FontWeight.w700,
          ),
        ),
        2.h.vs,
        Container(
          height: 15.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                width: 30.w,
                margin: EdgeInsets.only(right: 3.w),
                decoration: BoxDecoration(
                  color: ThemeColors.white,
                  borderRadius: BorderRadius.circular(3.w),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColors.greyColor.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(3.w),
                        ),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2.w),
                      child: Text(
                        'Related Track ${index + 1}',
                        style: TextStyle(
                          color: ThemeColors.defaultTextColor,
                          fontSize: 2.5.w,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        3.h.vs,
      ],
    );
  }
}
