import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/data_handler/repository.dart';
import 'package:mandir/model/banner.dart';
import 'package:mandir/model/home_data.dart';
import 'package:mandir/screen/donation/donation_screen.dart';
import 'package:mandir/screen/home/cat_item_screen.dart';
import 'package:mandir/screen/media_player/audio_player/audio_player_screen.dart';
import 'package:mandir/screen/media_player/video_player/video_player_screen.dart';
import 'package:mandir/screen/test.dart';
import 'package:mandir/utils/const.dart';
import 'package:mandir/utils/db/db.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/utils/logger.dart';
import 'package:mandir/utils/preference.dart';
import 'package:mandir/utils/toasty.dart';

class HomeController extends GetxController {
  var searchQuery = ''.obs;
  var selectedMediaType = MediaType.audio.obs;
  final RxString status = Status.NORMAL.obs;

  var allMediaItems = <MediaItem>[].obs;
  var favoriteItems = <String>[].obs;
  var categories = <CategoryData>[].obs;

  var showAllAudioContent = false.obs;
  var showAllVideoContent = false.obs;
  var showAllTextContent = false.obs;
  var banners = <Banners>[].obs;

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

  List<MediaItem> get limitedTextItems {
    var textItems =
        allMediaItems.where((item) => item.type == MediaType.text).toList();
    return showAllTextContent.value ? textItems : textItems.take(5).toList();
  }

  @override
  void onInit() {
    super.onInit();
    loadMediaData();
  }

  Future<void> loadMediaData() async {
    status.value = Status.PROGRESS;
    _loadMediaItems();
    _loadCategories();
    _loadMediaBanners();
    Future.delayed(Duration(seconds: 2)).then((value) {
      status.value = Status.COMPLETED;
    });
  }

  void _loadMediaBanners() async {
    status.value = Status.PROGRESS;

    try {
      final response = await Repository.instance.getBanner();
      Logger.m(tag: "Banner Data", value: response.toString());

      if (response != null &&
          response is Map &&
          response['status'] == true &&
          response['banners'] != null &&
          response['banners'] is List) {
        final List<Banners> bannerList =
            (response['banners'] as List)
                .map((e) => Banners.fromJson(e))
                .toList();

        banners.value = bannerList;
      } else {
        Logger.e(tag: "Banner Data Error", value: "Invalid response format");
      }
    } catch (e) {
      Logger.ex(baseName: runtimeType, tag: 'LOAD HOME DATA EXC', value: e);
    } finally {
      // status.value = Status.COMPLETED;
    }
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
      // status.value = Status.COMPLETED;
    }
  }

  void _loadCategories() async {
    try {
      final response = await Repository.instance.getHomeData(); // same API
      final List<dynamic> data = response['data'];
      categories.value = data.map((e) => CategoryData.fromJson(e)).toList();
    } catch (e) {
      Logger.ex(baseName: runtimeType, tag: 'CATEGORY EXC', value: e);
    }
  }

  void onSearch(String query) {
    searchQuery.value = query;
  }

  void playMedia(MediaItem item) {
    if (item.type == MediaType.video) {
      Get.to(() => VideoPlayerScreen(mediaItem: item));
    } else if (item.type == MediaType.audio) {
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

  void onCategoryTap(CategoryData category) {
    searchQuery.value = category.name.toLowerCase();
    Toasty.success('Browsing ${category.name}');
    Get.to(() => CatItemScreen(category: category));
  }

  Future<void> testFunction() async {

    // Get.to(() => DonationScreen());
    print(Preference.user.token);
    // await Repository.instance.getBlogs();
  }
}
