import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/screen/home/controller.dart';
import 'package:mandir/screen/media_player/video_player/controller.dart';
import 'package:mandir/utils/helper.dart';

class VideoPlayerScreen extends StatelessWidget {
  final MediaItem mediaItem;

  const VideoPlayerScreen({super.key, required this.mediaItem});

  @override
  Widget build(BuildContext context) {
    final VideoPlayerController controller = Get.put(
      VideoPlayerController(mediaItem: mediaItem),
    );

    return Scaffold(
      backgroundColor: ThemeColors.black,
      body: SafeArea(
        child: Obx(
          () =>
              controller.isFullscreen.value
                  ? _buildFullscreenPlayer(controller)
                  : _buildPortraitPlayer(controller),
        ),
      ),
    );
  }

  Widget _buildPortraitPlayer(VideoPlayerController controller) {
    return Column(
      children: [
        _buildVideoPlayer(controller),
        Expanded(
          child: Container(
            color: ThemeColors.backgroundColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildVideoInfo(),
                  _buildVideoControls(controller),
                  _buildVideoActions(controller),
                  _buildRelatedVideos(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFullscreenPlayer(VideoPlayerController controller) {
    return Stack(
      children: [
        _buildVideoPlayer(controller, isFullscreen: true),
        _buildFullscreenControls(controller),
      ],
    );
  }

  Widget _buildVideoPlayer(
    VideoPlayerController controller, {
    bool isFullscreen = false,
  }) {
    return Container(
      width: double.infinity,
      height: isFullscreen ? 100.h : 30.h,
      color: ThemeColors.black,
      child: Stack(
        children: [
          // Video placeholder
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ThemeColors.black,
                  ThemeColors.greyColor.withOpacity(0.5),
                  ThemeColors.black,
                ],
              ),
            ),
            child: Image.network(
              mediaItem.thumbnailUrl,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    color: ThemeColors.black,
                    child: Icon(
                      Icons.videocam,
                      color: ThemeColors.white,
                      size: 15.w,
                    ),
                  ),
            ),
          ),

          // Video overlay controls
          if (!isFullscreen) _buildVideoOverlay(controller),

          // Loading indicator
          Obx(
            () =>
                controller.isLoading.value
                    ? Center(
                      child: CircularProgressIndicator(
                        color: ThemeColors.white,
                      ),
                    )
                    : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoOverlay(VideoPlayerController controller) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              ThemeColors.black.withOpacity(0.3),
              Colors.transparent,
              ThemeColors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: Column(
          children: [
            // Top controls
            Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: ThemeColors.white,
                    size: 6.w,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: controller.toggleFavorite,
                  icon: Obx(
                    () => Icon(
                      controller.isFavorite.value
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color:
                          controller.isFavorite.value
                              ? ThemeColors.accentColor
                              : ThemeColors.white,
                      size: 6.w,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: controller.toggleFullscreen,
                  icon: Icon(
                    Icons.fullscreen,
                    color: ThemeColors.white,
                    size: 6.w,
                  ),
                ),
              ],
            ),
            Spacer(),
            // Center play button
            GestureDetector(
              onTap: controller.togglePlayPause,
              child: Obx(
                () => Container(
                  width: 16.w,
                  height: 16.w,
                  decoration: BoxDecoration(
                    color: ThemeColors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ThemeColors.black.withOpacity(0.3),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                    color: ThemeColors.primaryColor,
                    size: 10.w,
                  ),
                ),
              ),
            ),
            Spacer(),
            // Bottom progress bar
            _buildProgressBar(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildFullscreenControls(VideoPlayerController controller) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ThemeColors.black.withOpacity(0.7),
              Colors.transparent,
              Colors.transparent,
              ThemeColors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: Column(
          children: [
            // Top controls
            Row(
              children: [
                IconButton(
                  onPressed: controller.toggleFullscreen,
                  icon: Icon(
                    Icons.fullscreen_exit,
                    color: ThemeColors.white,
                    size: 7.w,
                  ),
                ),
                Spacer(),
                Text(
                  mediaItem.title,
                  style: TextStyle(
                    color: ThemeColors.white,
                    fontSize: 4.w,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.close, color: ThemeColors.white, size: 6.w),
                ),
              ],
            ),
            Spacer(),
            // Center controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFullscreenButton(
                  Icons.replay_10,
                  () => controller.seekBackward(),
                ),
                GestureDetector(
                  onTap: controller.togglePlayPause,
                  child: Obx(
                    () => Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        color: ThemeColors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        controller.isPlaying.value
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: ThemeColors.primaryColor,
                        size: 12.w,
                      ),
                    ),
                  ),
                ),
                _buildFullscreenButton(
                  Icons.forward_10,
                  () => controller.seekForward(),
                ),
              ],
            ),
            Spacer(),
            // Bottom controls
            _buildFullscreenBottomControls(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildFullscreenButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 15.w,
        height: 15.w,
        decoration: BoxDecoration(
          color: ThemeColors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: ThemeColors.white, size: 8.w),
      ),
    );
  }

  Widget _buildFullscreenBottomControls(VideoPlayerController controller) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          _buildProgressBar(controller),
          2.h.vs,
          Row(
            children: [
              Obx(
                () => Text(
                  controller.formatDuration(controller.currentPosition.value),
                  style: TextStyle(color: ThemeColors.white, fontSize: 3.w),
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: controller.toggleMute,
                icon: Obx(
                  () => Icon(
                    controller.isMuted.value
                        ? Icons.volume_off
                        : Icons.volume_up,
                    color: ThemeColors.white,
                    size: 5.w,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => controller.changePlaybackSpeed(),
                icon: Icon(Icons.speed, color: ThemeColors.white, size: 5.w),
              ),
              Obx(
                () => Text(
                  controller.formatDuration(controller.totalDuration.value),
                  style: TextStyle(color: ThemeColors.white, fontSize: 3.w),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(VideoPlayerController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Obx(
        () => SliderTheme(
          data: SliderThemeData(
            trackHeight: 1.w,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 2.w),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 4.w),
            activeTrackColor: ThemeColors.primaryColor,
            inactiveTrackColor: ThemeColors.white.withOpacity(0.3),
            thumbColor: ThemeColors.primaryColor,
          ),
          child: Slider(
            value: controller.currentPosition.value,
            max: controller.totalDuration.value,
            onChanged: controller.seekTo,
          ),
        ),
      ),
    );
  }

  Widget _buildVideoInfo() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mediaItem.title,
            style: TextStyle(
              color: ThemeColors.defaultTextColor,
              fontSize: 5.w,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          1.h.vs,
          Row(
            children: [
              Text(
                mediaItem.artist,
                style: TextStyle(
                  color: ThemeColors.greyColor,
                  fontSize: 3.5.w,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.w),
                decoration: BoxDecoration(
                  color: ThemeColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(1.w),
                ),
                child: Text(
                  mediaItem.category,
                  style: TextStyle(
                    color: ThemeColors.primaryColor,
                    fontSize: 2.8.w,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          1.h.vs,
          Row(
            children: [
              Icon(Icons.access_time, color: ThemeColors.greyColor, size: 4.w),
              1.w.hs,
              Text(
                mediaItem.duration,
                style: TextStyle(color: ThemeColors.greyColor, fontSize: 3.w),
              ),
              3.w.hs,
              Icon(Icons.star, color: ThemeColors.primaryColor, size: 4.w),
              0.5.w.hs,
              Text(
                mediaItem.rating.toString(),
                style: TextStyle(
                  color: ThemeColors.primaryColor,
                  fontSize: 3.w,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVideoControls(VideoPlayerController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: ThemeColors.white,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.greyColor.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Obx(
            () => Text(
              controller.formatDuration(controller.currentPosition.value),
              style: TextStyle(color: ThemeColors.greyColor, fontSize: 3.w),
            ),
          ),
          2.w.hs,
          Expanded(
            child: Obx(
              () => SliderTheme(
                data: SliderThemeData(
                  trackHeight: 1.w,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 2.5.w),
                  activeTrackColor: ThemeColors.primaryColor,
                  inactiveTrackColor: ThemeColors.greyColor.withOpacity(0.3),
                  thumbColor: ThemeColors.primaryColor,
                ),
                child: Slider(
                  value: controller.currentPosition.value,
                  max: controller.totalDuration.value,
                  onChanged: controller.seekTo,
                ),
              ),
            ),
          ),
          2.w.hs,
          Obx(
            () => Text(
              controller.formatDuration(controller.totalDuration.value),
              style: TextStyle(color: ThemeColors.greyColor, fontSize: 3.w),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoActions(VideoPlayerController controller) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            icon: Icons.playlist_add,
            label: 'Add to Playlist',
            onTap: controller.addToPlaylist,
          ),
          _buildActionButton(
            icon: Icons.download,
            label: 'Download',
            onTap: controller.downloadVideo,
          ),
          _buildActionButton(
            icon: Icons.share,
            label: 'Share',
            onTap: controller.shareVideo,
          ),
          _buildActionButton(
            icon: Icons.report,
            label: 'Report',
            onTap: controller.reportVideo,
          ),
        ],
      ),
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
          borderRadius: BorderRadius.circular(2.w),
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
                fontSize: 2.3.w,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedVideos() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Related Videos',
            style: TextStyle(
              color: ThemeColors.defaultTextColor,
              fontSize: 4.w,
              fontWeight: FontWeight.w700,
            ),
          ),
          2.h.vs,
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 3.w),
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
                child: Row(
                  children: [
                    Container(
                      width: 30.w,
                      height: 20.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(3.w),
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              'https://images.unsplash.com/photo-1605792657660-596af9009e82?w=300&h=200&fit=crop',
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Center(
                              child: Container(
                                padding: EdgeInsets.all(1.5.w),
                                decoration: BoxDecoration(
                                  color: ThemeColors.black.withOpacity(0.7),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.play_arrow,
                                  color: ThemeColors.white,
                                  size: 5.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Related Video ${index + 1}',
                              style: TextStyle(
                                color: ThemeColors.defaultTextColor,
                                fontSize: 3.5.w,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            0.5.h.vs,
                            Text(
                              'Sacred Rituals',
                              style: TextStyle(
                                color: ThemeColors.greyColor,
                                fontSize: 3.w,
                              ),
                            ),
                            0.5.h.vs,
                            Text(
                              '12:34',
                              style: TextStyle(
                                color: ThemeColors.primaryColor,
                                fontSize: 2.8.w,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
