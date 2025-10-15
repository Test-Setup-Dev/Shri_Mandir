// import 'package:get/get.dart';
// import 'package:mandir/model/home_data.dart';
// import 'package:mandir/screen/home/controller.dart';
// import 'package:mandir/utils/helper.dart';
// import 'package:flutter/services.dart';
// import 'package:mandir/utils/toasty.dart';
//
// class VideoPlayerController extends GetxController {
//   final MediaItem mediaItem;
//
//   VideoPlayerController({required this.mediaItem});
//
//   var isPlaying = false.obs;
//   var isLoading = false.obs;
//   var isFullscreen = false.obs;
//   var currentPosition = 0.0.obs;
//   var totalDuration = 600.0.obs; // 10 minutes in seconds
//   var isFavorite = false.obs;
//   var isMuted = false.obs;
//   var playbackSpeed = 1.0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _initializePlayer();
//   }
//
//   void _initializePlayer() {
//     isLoading.value = true;
//
//     // Simulate video loading
//     Future.delayed(Duration(seconds: 2), () {
//       isLoading.value = false;
//       totalDuration.value = _parseDurationToSeconds(mediaItem.duration);
//     });
//
//     // Start position updates when playing
//     ever(isPlaying, (playing) {
//       if (playing) {
//         _startPositionUpdates();
//       }
//     });
//   }
//
//   double _parseDurationToSeconds(String duration) {
//     final parts = duration.split(':');
//     if (parts.length == 2) {
//       final minutes = int.tryParse(parts[0]) ?? 0;
//       final seconds = int.tryParse(parts[1]) ?? 0;
//       return (minutes * 60 + seconds).toDouble();
//     }
//     return 600.0; // Default 10 minutes
//   }
//
//   void _startPositionUpdates() {
//     Future.doWhile(() async {
//       await Future.delayed(Duration(seconds: 1));
//       if (isPlaying.value && currentPosition.value < totalDuration.value) {
//         currentPosition.value += playbackSpeed.value;
//       }
//       return isPlaying.value;
//     });
//   }
//
//   void togglePlayPause() {
//     isPlaying.value = !isPlaying.value;
//     // Toasty.success(isPlaying.value ? 'Playing' : 'Paused');
//   }
//
//   void seekTo(double position) {
//     currentPosition.value = position;
//   }
//
//   void seekForward() {
//     final newPosition = currentPosition.value + 10;
//     currentPosition.value =
//         newPosition > totalDuration.value ? totalDuration.value : newPosition;
//   }
//
//   void seekBackward() {
//     final newPosition = currentPosition.value - 10;
//     currentPosition.value = newPosition < 0 ? 0 : newPosition;
//   }
//
//   void toggleFullscreen() {
//     isFullscreen.value = !isFullscreen.value;
//
//     if (isFullscreen.value) {
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.landscapeLeft,
//         DeviceOrientation.landscapeRight,
//       ]);
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//     } else {
//       SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//       SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     }
//   }
//
//   void toggleMute() {
//     isMuted.value = !isMuted.value;
//     Toasty.success(isMuted.value ? 'Muted' : 'Unmuted');
//   }
//
//   void changePlaybackSpeed() {
//     final speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
//     final currentIndex = speeds.indexOf(playbackSpeed.value);
//     final nextIndex = (currentIndex + 1) % speeds.length;
//     playbackSpeed.value = speeds[nextIndex];
//     Toasty.success('Playback speed: ${playbackSpeed.value}x');
//   }
//
//   void toggleFavorite() {
//     isFavorite.value = !isFavorite.value;
//     Toasty.success(isFavorite.value ? 'Added to Favorites' : 'Removed from Favorites');
//   }
//
//   String formatDuration(double seconds) {
//     final minutes = (seconds / 60).floor();
//     final remainingSeconds = (seconds % 60).floor();
//     return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
//   }
//
//   void addToPlaylist() {
//     Toasty.success('Added to Playlist');
//   }
//
//   void downloadVideo() {
//     Toasty.success('Download Started');
//   }
//
//   void shareVideo() {
//     Toasty.success('Share link copied to clipboard');
//   }
//
//   void reportVideo() {
//     Toasty.success('Video Reported');
//   }
//
//   @override
//   void onClose() {
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     super.onClose();
//   }
//
//
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/model/home_data.dart';
import 'package:mandir/screen/home/controller.dart';
import 'package:mandir/utils/helper.dart';
import 'package:flutter/services.dart';
import 'package:mandir/utils/logger.dart';
import 'package:mandir/utils/toasty.dart';
import 'package:video_player/video_player.dart' as vp;
import 'package:chewie/chewie.dart';

class VideoPlayerController extends GetxController {
  final MediaItem mediaItem;

  VideoPlayerController({required this.mediaItem});

  var isPlaying = false.obs;
  var isLoading = false.obs;
  var isFullscreen = false.obs;
  var currentPosition = 0.0.obs;
  var totalDuration = 0.0.obs;
  var isFavorite = false.obs;
  var isMuted = false.obs;
  var playbackSpeed = 1.0.obs;

  vp.VideoPlayerController? videoPlayerController;
  Rx<ChewieController?> chewieController = Rx<ChewieController?>(null);

  @override
  void onInit() {
    super.onInit();
    _initializePlayer();
  }

  void _initializePlayer() async {
    isLoading.value = true;
    Logger.m(tag: 'VideoPlayerCtrl', value: 'Video Url ${mediaItem.title}');
    try {
      String videoUrl =
          mediaItem.mediaUrl ??
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';

      videoPlayerController = vp.VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
      );

      await videoPlayerController!.initialize();

      // Create Chewie controller
      chewieController.value = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: false,
        looping: false,
        showControls: false,
        // We're using custom controls
        aspectRatio: videoPlayerController!.value.aspectRatio,
        allowFullScreen: true,
        allowMuting: true,
        placeholder: Container(color: ThemeColors.black),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: ThemeColors.white),
            ),
          );
        },
      );

      // Get video duration
      totalDuration.value =
          videoPlayerController!.value.duration.inSeconds.toDouble();

      // Listen to video player state changes
      videoPlayerController!.addListener(_videoPlayerListener);

      isLoading.value = false;
    } catch (e) {
      print('Error initializing video player: $e');
      isLoading.value = false;
      Toasty.failed('Failed to load video');
    }
  }

  void _videoPlayerListener() {
    if (videoPlayerController != null &&
        videoPlayerController!.value.isInitialized) {
      // Update current position
      currentPosition.value =
          videoPlayerController!.value.position.inSeconds.toDouble();

      // Update total duration
      totalDuration.value =
          videoPlayerController!.value.duration.inSeconds.toDouble();

      // Update playing state
      isPlaying.value = videoPlayerController!.value.isPlaying;

      // Update mute state
      isMuted.value = videoPlayerController!.value.volume == 0;

      // Check if video ended
      if (videoPlayerController!.value.position >=
          videoPlayerController!.value.duration) {
        isPlaying.value = false;
      }
    }
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

  void togglePlayPause() {
    if (videoPlayerController != null &&
        videoPlayerController!.value.isInitialized) {
      if (videoPlayerController!.value.isPlaying) {
        videoPlayerController!.pause();
        isPlaying.value = false;
      } else {
        videoPlayerController!.play();
        isPlaying.value = true;
      }
    }
  }

  void seekTo(double position) {
    if (videoPlayerController != null &&
        videoPlayerController!.value.isInitialized) {
      videoPlayerController!.seekTo(Duration(seconds: position.toInt()));
      currentPosition.value = position;
    }
  }

  void seekForward() {
    if (videoPlayerController != null &&
        videoPlayerController!.value.isInitialized) {
      final newPosition = currentPosition.value + 10;
      final maxPosition = totalDuration.value;
      seekTo(newPosition > maxPosition ? maxPosition : newPosition);
    }
  }

  void seekBackward() {
    if (videoPlayerController != null &&
        videoPlayerController!.value.isInitialized) {
      final newPosition = currentPosition.value - 10;
      seekTo(newPosition < 0 ? 0 : newPosition);
    }
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
    if (videoPlayerController != null &&
        videoPlayerController!.value.isInitialized) {
      if (isMuted.value) {
        videoPlayerController!.setVolume(1.0);
        isMuted.value = false;
        Toasty.success('Unmuted');
      } else {
        videoPlayerController!.setVolume(0.0);
        isMuted.value = true;
        Toasty.success('Muted');
      }
    }
  }

  void changePlaybackSpeed() {
    if (videoPlayerController != null &&
        videoPlayerController!.value.isInitialized) {
      final speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
      final currentIndex = speeds.indexOf(playbackSpeed.value);
      final nextIndex = (currentIndex + 1) % speeds.length;
      playbackSpeed.value = speeds[nextIndex];
      videoPlayerController!.setPlaybackSpeed(playbackSpeed.value);
      Toasty.success('Playback speed: ${playbackSpeed.value}x');
    }
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    Toasty.success(
      isFavorite.value ? 'Added to Favorites' : 'Removed from Favorites',
    );
  }

  String formatDuration(double seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = (seconds % 60).floor();
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void addToPlaylist() {
    Toasty.success('Added to Playlist');
  }

  void downloadVideo() {
    Toasty.success('Download Started');
  }

  void shareVideo() {
    Toasty.success('Share link copied to clipboard');
  }

  void reportVideo() {
    Toasty.success('Video Reported');
  }

  @override
  void onClose() {
    // Clean up video player
    videoPlayerController?.removeListener(_videoPlayerListener);
    videoPlayerController?.dispose();
    chewieController.value?.dispose();

    // Reset orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    super.onClose();
  }
}
