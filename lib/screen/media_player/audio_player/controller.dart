// import 'package:get/get.dart';
// import 'package:mandir/model/home_data.dart';
// import 'package:mandir/screen/home/controller.dart';
// import 'package:mandir/utils/helper.dart';
// import 'package:mandir/utils/toasty.dart';
//
// class AudioPlayerController extends GetxController {
//   final MediaItem mediaItem;
//
//   AudioPlayerController({required this.mediaItem});
//
//   var isPlaying = false.obs;
//   var currentPosition = 0.0.obs;
//   var totalDuration = 300.0.obs;
//   var volume = 0.7.obs;
//   var isShuffleOn = false.obs;
//   var isRepeatOn = false.obs;
//   var isFavorite = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _initializePlayer();
//   }
//
//   void _initializePlayer() {
//     // Simulate loading audio duration
//     totalDuration.value = _parseDurationToSeconds(mediaItem.duration);
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
//     return 300.0; // Default 5 minutes
//   }
//
//   void _startPositionUpdates() {
//     // Simulate audio progress (in real app, this would come from audio player)
//     Future.doWhile(() async {
//       await Future.delayed(Duration(seconds: 1));
//       if (isPlaying.value && currentPosition.value < totalDuration.value) {
//         currentPosition.value += 1.0;
//       }
//       return isPlaying.value;
//     });
//   }
//
//   void togglePlayPause() {
//     isPlaying.value = !isPlaying.value;
//     // Toasty.success(
//     //   "${isPlaying.value ? 'Playing' : 'Paused'} ${mediaItem.title}",
//     // );
//   }
//
//   void seekTo(double position) {
//     currentPosition.value = position;
//   }
//
//   void previousTrack() {
//     currentPosition.value = 0.0;
//     Get.snackbar(
//       'Previous Track',
//       'Playing previous track',
//       backgroundColor: ThemeColors.accentColor.withOpacity(0.9),
//       colorText: ThemeColors.white,
//       duration: Duration(seconds: 2),
//     );
//   }
//
//   void nextTrack() {
//     currentPosition.value = 0.0;
//     Get.snackbar(
//       'Next Track',
//       'Playing next track',
//       backgroundColor: ThemeColors.accentColor.withOpacity(0.9),
//       colorText: ThemeColors.white,
//       duration: Duration(seconds: 2),
//     );
//   }
//
//   void toggleShuffle() {
//     isShuffleOn.value = !isShuffleOn.value;
//     Get.snackbar(
//       'Shuffle',
//       isShuffleOn.value ? 'Shuffle enabled' : 'Shuffle disabled',
//       backgroundColor: ThemeColors.primaryColor.withOpacity(0.9),
//       colorText: ThemeColors.white,
//       duration: Duration(seconds: 2),
//     );
//   }
//
//   void toggleRepeat() {
//     isRepeatOn.value = !isRepeatOn.value;
//     Get.snackbar(
//       'Repeat',
//       isRepeatOn.value ? 'Repeat enabled' : 'Repeat disabled',
//       backgroundColor: ThemeColors.primaryColor.withOpacity(0.9),
//       colorText: ThemeColors.white,
//       duration: Duration(seconds: 2),
//     );
//   }
//
//   void setVolume(double vol) {
//     volume.value = vol;
//   }
//
//   void toggleFavorite() {
//     isFavorite.value = !isFavorite.value;
//     Get.snackbar(
//       isFavorite.value ? 'Added to Favorites' : 'Removed from Favorites',
//       mediaItem.title,
//       backgroundColor: ThemeColors.accentColor.withOpacity(0.9),
//       colorText: ThemeColors.white,
//       duration: Duration(seconds: 2),
//     );
//   }
//
//   String formatDuration(double seconds) {
//     final minutes = (seconds / 60).floor();
//     final remainingSeconds = (seconds % 60).floor();
//     return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
//   }
//
//   void addToPlaylist() {
//     Get.snackbar(
//       'Added to Playlist',
//       '${mediaItem.title} added to your playlist',
//       backgroundColor: ThemeColors.primaryColor.withOpacity(0.9),
//       colorText: ThemeColors.white,
//       duration: Duration(seconds: 2),
//     );
//   }
//
//   void shareTrack() {
//     Get.snackbar(
//       'Share',
//       'Sharing ${mediaItem.title}',
//       backgroundColor: ThemeColors.accentColor.withOpacity(0.9),
//       colorText: ThemeColors.white,
//       duration: Duration(seconds: 2),
//     );
//   }
//
//   void downloadTrack() {
//     Get.snackbar(
//       'Download',
//       'Downloading ${mediaItem.title}',
//       backgroundColor: ThemeColors.primaryColor.withOpacity(0.9),
//       colorText: ThemeColors.white,
//       duration: Duration(seconds: 3),
//     );
//   }
//
//   void setSleepTimer() {
//     Get.snackbar(
//       'Sleep Timer',
//       'Sleep timer set for 30 minutes',
//       backgroundColor: ThemeColors.greyColor.withOpacity(0.9),
//       colorText: ThemeColors.white,
//       duration: Duration(seconds: 2),
//     );
//   }
// }

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/model/home_data.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/utils/logger.dart';
import 'package:mandir/utils/toasty.dart';

class AudioPlayerController extends GetxController {
  final MediaItem mediaItem;

  AudioPlayerController({required this.mediaItem});

  late AudioPlayer player;

  var isPlaying = false.obs;
  var currentPosition = 0.0.obs; // in seconds
  var totalDuration = 0.0.obs; // in seconds
  var volume = 0.7.obs;
  var isShuffleOn = false.obs;
  var isRepeatOn = false.obs;
  var isFavorite = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializePlayer();
  }

  void _initializePlayer() {
    player = AudioPlayer();

    /// set initial volume
    player.setVolume(volume.value);

    /// Listen for duration updates
    player.onDurationChanged.listen((duration) {
      totalDuration.value = duration.inSeconds.toDouble();
    });

    /// Listen for position updates
    player.onPositionChanged.listen((position) {
      currentPosition.value = position.inSeconds.toDouble();
    });

    /// Listen for completion
    player.onPlayerComplete.listen((event) {
      isPlaying.value = false;
      if (isRepeatOn.value) {
        seekTo(0);
        play();
      }
    });

    /// Load the media
    player.setSourceUrl(mediaItem.mediaUrl);
  }

  /// Play audio
  Future<void> play() async {
    Logger.m(
      tag: 'Playing',
      value: "${mediaItem.title} from ${mediaItem.mediaUrl}"
    );
    await player.resume();
    isPlaying.value = true;
  }

  /// Pause audio
  Future<void> pause() async {
    await player.pause();
    isPlaying.value = false;
  }

  /// Toggle play/pause
  void togglePlayPause() {
    if (isPlaying.value) {
      pause();
    } else {
      play();
    }
  }

  /// Seek to position
  Future<void> seekTo(double position) async {
    await player.seek(Duration(seconds: position.toInt()));
    currentPosition.value = position;
  }

  /// Go to previous track (example logic)
  void previousTrack() {
    seekTo(0);
    Toasty.success('Playing previous track');
  }

  /// Go to next track (example logic)
  void nextTrack() {
    seekTo(0);
    Toasty.success('Playing next track');
  }

  /// Shuffle
  void toggleShuffle() {
    isShuffleOn.value = !isShuffleOn.value;
    Toasty.success(isShuffleOn.value ? 'Shuffle enabled' : 'Shuffle disabled');
  }

  /// Repeat
  void toggleRepeat() {
    isRepeatOn.value = !isRepeatOn.value;
    player.setReleaseMode(isRepeatOn.value ? ReleaseMode.loop : ReleaseMode.stop);
    Toasty.success(isRepeatOn.value ? 'Repeat enabled' : 'Repeat disabled');
  }


  /// Volume
  Future<void> setVolume(double vol) async {
    volume.value = vol;
    await player.setVolume(vol);
  }

  /// Favorite
  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    Toasty.success(isFavorite.value ? 'Added to Favorites' : 'Removed from Favorites');
  }

  /// Format duration mm:ss
  String formatDuration(double seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = (seconds % 60).floor();
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  /// Playlist
  void addToPlaylist() {
    Toasty.success('${mediaItem.title} added to your playlist');
  }

  /// Share
  void shareTrack() {
    Toasty.success('Sharing ${mediaItem.title}');
  }

  /// Download
  void downloadTrack() {
    Toasty.success('Downloading ${mediaItem.title}');
  }

  /// Sleep Timer (example only)
  void setSleepTimer() {
    Toasty.success('Sleep timer set for 30 minutes');
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
