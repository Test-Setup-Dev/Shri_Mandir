import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/data_handler/repository.dart';
import 'package:mandir/model/home_data.dart';
import 'package:mandir/model/media_category.dart';
import 'package:mandir/screen/media_player/audio_player/audio_player_screen.dart';
import 'package:mandir/screen/media_player/video_player/video_player_screen.dart';
import 'package:mandir/screen/test.dart';
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

  var showAllAudioContent = false.obs;
  var showAllVideoContent = false.obs;

  List<MediaItem> get limitedAudioItems {
    var audioItems =
        allMediaItems.where((item) => item.type == MediaType.audio).toList();
    return showAllAudioContent.value ? audioItems : audioItems.take(5).toList();
  }

  List<MediaItem> get limitedVideoItems {
    var videoItems =
        allMediaItems.where((item) => item.type == MediaType.video).toList();
    return showAllVideoContent.value ? videoItems : videoItems.take(5).toList();
  }

  void showAllAudio() {
    showAllAudioContent.value = true;
  }

  void showAllVideo() {
    showAllVideoContent.value = true;
  }

  var banners =
      <String>[
        'https://images.unsplash.com/photo-1623952146070-f13fc902f769',
        'https://images.unsplash.com/photo-1622781656198-645b7981b671',
        'https://images.unsplash.com/photo-1730191567375-e82ce67160df',
        'https://images.unsplash.com/photo-1706169599121-4182eb12fbef',
        'https://plus.unsplash.com/premium_photo-1676111266437-027b26837de3',
        'https://images.unsplash.com/photo-1559595500-e15296bdbb48',
      ].obs;


  List<MediaItem> get filteredMediaItems {
    var filtered = allMediaItems.where((item) {
      bool matchesType = item.type == selectedMediaType.value;
      bool matchesSearch =
          searchQuery.value.isEmpty ||
              item.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
              item.artist.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
              item.categoryId.toLowerCase().contains(searchQuery.value.toLowerCase()); // 👈 FIXED

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

  void _loadMediaItems() async {
    status.value = Status.PROGRESS;

    try {
      final response = await Repository.instance.getHomeData();
      Logger.m(tag: "Home Data", value: response.toString());

      if (response != null &&
          response is Map &&
          response['status'] == 'success' &&
          response['data'] != null &&
          response['data'] is List) {
        final List<MediaItem> items = [];

        final List<dynamic> categories = response['data'];
        for (var category in categories) {
          final List<dynamic> mediaList = category['media_items'] ?? [];
          for (var media in mediaList) {
            final mediaItem = MediaItem.fromJson(media);
            items.add(mediaItem);
          }
        }

        allMediaItems.value = items;
      } else {
        Logger.e(tag: "Home Data Error", value: "Invalid response format");
      }
    } catch (e) {
      Logger.ex(baseName: runtimeType, tag: 'LOAD HOME DATA EXC', value: e);
    } finally {
      status.value = Status.COMPLETED;
    }
  }


  void _loadCategories() async {
    try {
      final response = await Repository.instance.getHomeData(); // same API
      final List<dynamic> data = response['data'];
      categories.value =
          data.map((e) => MediaCategory.fromJson(e)).toList();
    } catch (e) {
      Logger.ex(baseName: runtimeType, tag: 'CATEGORY EXC', value: e);
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
    Toasty.success(
      'Playing ${item.type == MediaType.video ? 'Video' : 'Audio'}',
    );

    // Here you would typically integrate with audio/video players like:
    // - just_audio for audio playback
    // - video_player or chewie for video playback
  }

  void toggleFavorite(String itemId) {
    if (favoriteItems.contains(itemId)) {
      favoriteItems.remove(itemId);
      Toasty.failed("Item removed from your favorites");
    } else {
      favoriteItems.add(itemId);
      Toasty.success("Item added to your favorites");
    }
  }

  bool isFavorite(String itemId) => favoriteItems.contains(itemId);

  void onCategoryTap(MediaCategory category) {
    searchQuery.value = category.name.toLowerCase();
    Toasty.success('Browsing ${category.name}');
  }

  Future<void> testFunction() async {
    _loadMediaItems();
    // Get.to(() => JustAjay());
  }
}
