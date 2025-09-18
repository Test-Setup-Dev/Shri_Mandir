import 'package:get/get.dart';
import 'package:mandir/screen/home/controller.dart';
import 'package:mandir/utils/helper.dart';
import 'package:flutter/services.dart';
import 'package:mandir/utils/toasty.dart';

class VideoPlayerController extends GetxController {
  final MediaItem mediaItem;

  VideoPlayerController({required this.mediaItem});

  var isPlaying = false.obs;
  var isLoading = false.obs;
  var isFullscreen = false.obs;
  var currentPosition = 0.0.obs;
  var totalDuration = 600.0.obs; // 10 minutes in seconds
  var isFavorite = false.obs;
  var isMuted = false.obs;
  var playbackSpeed = 1.0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializePlayer();
  }

  void _initializePlayer() {
    isLoading.value = true;

    // Simulate video loading
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
      totalDuration.value = _parseDurationToSeconds(mediaItem.duration);
    });

    // Start position updates when playing
    ever(isPlaying, (playing) {
      if (playing) {
        _startPositionUpdates();
      }
    });
  }

  double _parseDurationToSeconds(String duration) {
    final parts = duration.split(':');
    if (parts.length == 2) {
      final minutes = int.tryParse(parts[0]) ?? 0;
      final seconds = int.tryParse(parts[1]) ?? 0;
      return (minutes * 60 + seconds).toDouble();
    }
    return 600.0; // Default 10 minutes
  }

  void _startPositionUpdates() {
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (isPlaying.value && currentPosition.value < totalDuration.value) {
        currentPosition.value += playbackSpeed.value;
      }
      return isPlaying.value;
    });
  }

  void togglePlayPause() {
    isPlaying.value = !isPlaying.value;

    Get.snackbar(
      isPlaying.value ? 'Playing' : 'Paused',
      mediaItem.title,
      backgroundColor: ThemeColors.primaryColor.withOpacity(0.9),
      colorText: ThemeColors.white,
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void seekTo(double position) {
    currentPosition.value = position;
  }

  void seekForward() {
    final newPosition = currentPosition.value + 10;
    currentPosition.value =
        newPosition > totalDuration.value ? totalDuration.value : newPosition;
  }

  void seekBackward() {
    final newPosition = currentPosition.value - 10;
    currentPosition.value = newPosition < 0 ? 0 : newPosition;
  }

  void toggleFullscreen() {
    isFullscreen.value = !isFullscreen.value;

    if (isFullscreen.value) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  void toggleMute() {
    isMuted.value = !isMuted.value;
    Get.snackbar(
      isMuted.value ? 'Muted' : 'Unmuted',
      'Audio ${isMuted.value ? 'muted' : 'unmuted'}',
      backgroundColor: ThemeColors.greyColor.withOpacity(0.9),
      colorText: ThemeColors.white,
      duration: Duration(seconds: 2),
    );
  }

  void changePlaybackSpeed() {
    final speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
    final currentIndex = speeds.indexOf(playbackSpeed.value);
    final nextIndex = (currentIndex + 1) % speeds.length;
    playbackSpeed.value = speeds[nextIndex];

    Get.snackbar(
      'Playback Speed',
      '${playbackSpeed.value}x speed',
      backgroundColor: ThemeColors.primaryColor.withOpacity(0.9),
      colorText: ThemeColors.white,
      duration: Duration(seconds: 2),
    );
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    Get.snackbar(
      isFavorite.value ? 'Added to Favorites' : 'Removed from Favorites',
      mediaItem.title,
      backgroundColor: ThemeColors.accentColor.withOpacity(0.9),
      colorText: ThemeColors.white,
      duration: Duration(seconds: 2),
    );
  }

  String formatDuration(double seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = (seconds % 60).floor();
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void addToPlaylist() {
    Get.snackbar(
      'Added to Playlist',
      '${mediaItem.title} added to your playlist',
      backgroundColor: ThemeColors.primaryColor.withOpacity(0.9),
      colorText: ThemeColors.white,
      duration: Duration(seconds: 2),
    );
  }

  void downloadVideo() {
    Get.snackbar(
      'Download Started',
      'Downloading ${mediaItem.title}',
      backgroundColor: ThemeColors.accentColor.withOpacity(0.9),
      colorText: ThemeColors.white,
      duration: Duration(seconds: 3),
    );
  }

  void shareVideo() {
    Get.snackbar(
      'Share',
      'Sharing ${mediaItem.title}',
      backgroundColor: ThemeColors.primaryColor.withOpacity(0.9),
      colorText: ThemeColors.white,
      duration: Duration(seconds: 2),
    );
  }

  void reportVideo() {
    Get.snackbar(
      'Report',
      'Thank you for your feedback',
      backgroundColor: ThemeColors.greyColor.withOpacity(0.9),
      colorText: ThemeColors.white,
      duration: Duration(seconds: 2),
    );
  }

  @override
  void onClose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.onClose();
  }
}
