import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/data_handler/repository.dart';
import 'package:mandir/model/home_data.dart';
import 'package:mandir/model/media_category.dart';
import 'package:mandir/screen/media_player/audio_player/audio_player_screen.dart';
import 'package:mandir/screen/media_player/video_player/video_player_screen.dart';
import 'package:mandir/screen/test.dart';
import 'package:mandir/screen/test2.dart';
import 'package:mandir/utils/const.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/utils/logger.dart';
import 'package:mandir/utils/toasty.dart';

class HomeController extends GetxController {
  var searchQuery = ''.obs;
  var selectedMediaType = MediaType.audio.obs;
  final RxString status = Status.NORMAL.obs;

  var allMediaItems = <MediaItem>[].obs;
  var favoriteItems = <String>[].obs;
  var categories = <MediaCategory>[].obs;

  var banners =
      <String>[
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=200&fit=crop',
        'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&h=200&fit=crop',
        'https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae?w=400&h=200&fit=crop',
      ].obs;

  List<MediaItem> get filteredMediaItems {
    var filtered =
        allMediaItems.where((item) {
          bool matchesType = item.type == selectedMediaType.value;
          bool matchesSearch =
              searchQuery.value.isEmpty ||
              item.title.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ) ||
              item.artist.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              ) ||
              item.category.toLowerCase().contains(
                searchQuery.value.toLowerCase(),
              );

          return matchesType && matchesSearch;
        }).toList();

    return filtered;
  }

  @override
  void onInit() {
    super.onInit();
    loadMediaData();
  }

  void loadMediaData() {
    status.value = Status.PROGRESS;
    _loadMediaItems();
    _loadCategories();
    status.value = Status.COMPLETED;
  }

  // void _loadMediaItems() {
  //   allMediaItems.value = [
  //     // Audio Items
  //     MediaItem(
  //       id: '1',
  //       title: 'Om Namah Shivaya',
  //       artist: 'Sacred Chants',
  //       thumbnailUrl:
  //       'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
  //       mediaUrl: 'https://example.com/audio1.mp3',
  //       type: MediaType.audio,
  //       duration: '5:30',
  //       category: 'Mantras',
  //       rating: 4.8,
  //       isFeatured: true,
  //     ),
  //     MediaItem(
  //       id: '2',
  //       title: 'Gayatri Mantra',
  //       artist: 'Vedic Sounds',
  //       thumbnailUrl:
  //       'https://images.unsplash.com/photo-1593225457124-a3eb161ffa5f?w=300&h=300&fit=crop',
  //       mediaUrl: 'https://example.com/audio2.mp3',
  //       type: MediaType.audio,
  //       duration: '3:15',
  //       category: 'Mantras',
  //       rating: 4.9,
  //     ),
  //     MediaItem(
  //       id: '3',
  //       title: 'Hanuman Chalisa',
  //       artist: 'Devotional Collection',
  //       thumbnailUrl:
  //       'https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae?w=300&h=300&fit=crop',
  //       mediaUrl: 'https://example.com/audio3.mp3',
  //       type: MediaType.audio,
  //       duration: '8:45',
  //       category: 'Bhajans',
  //       rating: 4.7,
  //     ),
  //     MediaItem(
  //       id: '4',
  //       title: 'Shree Ram Bhajan',
  //       artist: 'Divine Melodies',
  //       thumbnailUrl:
  //       'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop',
  //       mediaUrl: 'https://example.com/audio4.mp3',
  //       type: MediaType.audio,
  //       duration: '6:20',
  //       category: 'Bhajans',
  //       rating: 4.6,
  //       isFeatured: true,
  //     ),
  //     MediaItem(
  //       id: '5',
  //       title: 'Krishna Flute Music',
  //       artist: 'Instrumental Bliss',
  //       thumbnailUrl:
  //       'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop',
  //       mediaUrl: 'https://example.com/audio5.mp3',
  //       type: MediaType.audio,
  //       duration: '12:30',
  //       category: 'Instrumental',
  //       rating: 4.5,
  //     ),
  //     MediaItem(
  //       id: '6',
  //       title: 'Meditation Music',
  //       artist: 'Peaceful Sounds',
  //       thumbnailUrl:
  //       'https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae?w=300&h=300&fit=crop',
  //       mediaUrl: 'https://example.com/audio6.mp3',
  //       type: MediaType.audio,
  //       duration: '15:00',
  //       category: 'Meditation',
  //       rating: 4.8,
  //     ),
  //
  //     // Video Items
  //     MediaItem(
  //       id: '7',
  //       title: 'Ganga Aarti Live',
  //       artist: 'Temple Videos',
  //       thumbnailUrl:
  //       'https://images.unsplash.com/photo-1605792657660-596af9009e82?w=300&h=300&fit=crop',
  //       mediaUrl: 'https://example.com/video1.mp4',
  //       type: MediaType.video,
  //       duration: '25:30',
  //       category: 'Aarti',
  //       rating: 4.9,
  //       isFeatured: true,
  //     ),
  //     MediaItem(
  //       id: '8',
  //       title: 'Shiva Tandav Dance',
  //       artist: 'Classical Performances',
  //       thumbnailUrl:
  //       'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=300&h=300&fit=crop',
  //       mediaUrl: 'https://example.com/video2.mp4',
  //       type: MediaType.video,
  //       duration: '18:45',
  //       category: 'Dance',
  //       rating: 4.7,
  //     ),
  //     MediaItem(
  //       id: '9',
  //       title: 'Temple Morning Prayers',
  //       artist: 'Sacred Rituals',
  //       thumbnailUrl:
  //       'https://images.unsplash.com/photo-1605792657660-596af9009e82?w=300&h=300&fit=crop',
  //       mediaUrl: 'https://example.com/video3.mp4',
  //       type: MediaType.video,
  //       duration: '45:20',
  //       category: 'Prayers',
  //       rating: 4.8,
  //       isFeatured: true,
  //     ),
  //     MediaItem(
  //       id: '10',
  //       title: 'Bhakti Yoga Session',
  //       artist: 'Spiritual Learning',
  //       thumbnailUrl:
  //       'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=300&h=300&fit=crop',
  //       mediaUrl: 'https://example.com/video4.mp4',
  //       type: MediaType.video,
  //       duration: '32:15',
  //       category: 'Yoga',
  //       rating: 4.6,
  //     ),
  //     MediaItem(
  //       id: '11',
  //       title: 'Festival Celebrations',
  //       artist: 'Cultural Events',
  //       thumbnailUrl:
  //       'https://images.unsplash.com/photo-1605792657660-596af9009e82?w=300&h=300&fit=crop',
  //       mediaUrl: 'https://example.com/video5.mp4',
  //       type: MediaType.video,
  //       duration: '55:30',
  //       category: 'Festivals',
  //       rating: 4.5,
  //     ),
  //   ];
  // }

  void _loadMediaItems() async {
    status.value = Status.PROGRESS;

    try {
      Repository.instance.getHomeData().then((value) {
        print("ajay singh rawat: $value");

        var list = value['data'] as List<dynamic>;

        allMediaItems.value = list.map((e) => MediaItem.fromJson(e)).toList();
      });
    } catch (e) {
      Logger.ex(
        baseName: runtimeType,
        tag: 'LOGIN EXC',
        value: e,
        sendToServer: true,
      );
      status.value = Status.COMPLETED;
    } finally {
      status.value = Status.COMPLETED;
    }
  }

  void _loadCategories() async {
    status.value = Status.PROGRESS;

    try {
      final response = await Repository.instance.getCategory();
      print("API Categories Response: $response");

      var list = response['data'] as List<dynamic>;
      categories.value = list.map((e) => MediaCategory.fromJson(e)).toList();
    } catch (e) {
      Logger.ex(
        baseName: runtimeType,
        tag: 'CATEGORY EXC',
        value: e,
        sendToServer: true,
      );
    } finally {
      status.value = Status.COMPLETED;
    }
  }

  void onSearch(String query) {
    searchQuery.value = query;
  }

  void setMediaType(MediaType type) {
    selectedMediaType.value = type;
  }

  void playMedia(MediaItem item) {
    if (item.type == MediaType.video) {
      Get.to(() => VideoPlayerScreen(mediaItem: item));
    } else {
      Get.to(() => AudioPlayerScreen(mediaItem: item));
    }
    // Implement media playback logic here
    Get.snackbar(
      'Playing ${item.type == MediaType.video ? 'Video' : 'Audio'}',
      '${item.title} by ${item.artist}',
      backgroundColor: ThemeColors.primaryColor.withOpacity(0.9),
      colorText: ThemeColors.white,
      duration: Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16),
      borderRadius: 12,
      icon: Icon(
        item.type == MediaType.video
            ? Icons.play_circle_filled
            : Icons.music_note,
        color: ThemeColors.white,
      ),
    );

    // Here you would typically integrate with audio/video players like:
    // - just_audio for audio playback
    // - video_player or chewie for video playback
  }

  void toggleFavorite(String itemId) {
    if (favoriteItems.contains(itemId)) {
      favoriteItems.remove(itemId);
      Get.snackbar(
        'Removed from Favorites',
        'Item removed from your favorites',
        backgroundColor: ThemeColors.greyColor.withOpacity(0.8),
        colorText: ThemeColors.white,
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      favoriteItems.add(itemId);
      Get.snackbar(
        'Added to Favorites',
        'Item added to your favorites',
        backgroundColor: ThemeColors.accentColor.withOpacity(0.9),
        colorText: ThemeColors.white,
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  bool isFavorite(String itemId) => favoriteItems.contains(itemId);

  void onCategoryTap(MediaCategory category) {
    // Filter by category
    searchQuery.value = category.name.toLowerCase();

    Get.snackbar(
      'Category',
      'Browsing ${category.name}',
      backgroundColor: ThemeColors.primaryColor.withOpacity(0.9),
      colorText: ThemeColors.white,
      duration: Duration(seconds: 2),
    );
  }

  Future<void> testFunction() async {
    _loadMediaItems();
    Get.to(() => JustAjay());
  }
}
