import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/model/home_data.dart';
import 'package:mandir/screen/donation/top_donor/top_donor_screen.dart';
import 'package:mandir/screen/home/controller.dart';
import 'package:mandir/screen/home/media_list.dart';
import 'package:mandir/screen/notification/notification_screen.dart';
import 'package:mandir/screen/old_latter/old_latter_screen.dart';
import 'package:mandir/utils/const.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/widget/banner_carousel.dart';
import 'package:mandir/widget/my_drawer.dart';
import 'package:mandir/widget/widgets.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      key: Helper.appBarKey,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: ThemeColors.primaryColor,
      ),
      drawer: const MyDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.loadMediaData();
        },
        color: ThemeColors.white,
        backgroundColor: ThemeColors.colorSecondary.withAlpha(200),
        child: SafeArea(
          child: Obx(
            () =>
                controller.status.value == Status.PROGRESS
                    ? _buildLoadingState()
                    : Column(
                      children: [
                        _buildHeader(),
                        12.vs,
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => BannerCarousel(
                                    banners:
                                        controller.banners
                                            .map((banner) => '${banner.image}')
                                            .toList(),
                                  ),
                                ),
                                3.h.vs,
                                _buildMediaGrid(),
                                3.h.vs,
                                _buildFeaturedSection(),
                                3.h.vs,
                                _buildCategoriesSection(),
                                12.h.vs,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Shimmer(
      duration: const Duration(seconds: 2),
      interval: const Duration(seconds: 1),
      color: ThemeColors.greyColor.withAlpha(80),
      colorOpacity: 0.3,
      enabled: true,
      direction: const ShimmerDirection.fromLTRB(),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Banner shimmer
            Container(
              height: 18.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(3.w),
              ),
            ),
            3.h.vs,

            // 🔹 Audio section shimmer
            _buildSectionShimmer(title: "Audio Content"),

            // 🔹 Video section shimmer
            _buildSectionShimmer(title: "Video Content"),

            // 🔹 Text section shimmer
            _buildSectionShimmer(title: "Text Content"),

            // 🔹 Category shimmer grid
            3.h.vs,
            Container(height: 3.h, width: 40.w, color: Colors.grey[300]),
            2.h.vs,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 3.w,
                mainAxisSpacing: 3.w,
                childAspectRatio: 0.9,
              ),
              itemCount: 8,
              itemBuilder:
                  (_, __) => Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.5.w),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable shimmer for section grids
  Widget _buildSectionShimmer({required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 3.h, width: 35.w, color: Colors.grey[300]),
        2.h.vs,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 3.w,
            mainAxisSpacing: 3.w,
            childAspectRatio: 0.75,
          ),
          itemCount: 4,
          itemBuilder:
              (_, __) => Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(3.w),
                ),
              ),
        ),
        3.h.vs,
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: ThemeColors.primaryColor,
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [ThemeColors.white, ThemeColors.offWhite],
        // ),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.primaryColor.withAlpha(50),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: ThemeColors.white,
                  borderRadius: BorderRadius.circular(6.w),
                  border: Border.all(color: ThemeColors.greyColor),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColors.greyColor.withAlpha(50),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    Helper.openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    color: ThemeColors.primaryColor,
                    size: 6.w,
                  ),
                ),
              ),
              15.hs,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'appName'.t,
                    style: TextStyle(
                      color: ThemeColors.white,
                      fontSize: 4.5.w,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Divine Sounds & Videos Collection',
                    style: TextStyle(
                      color: ThemeColors.whiteBlue,
                      fontSize: 2.5.w,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Container(
                width: 10.w,
                height: 10.w,
                padding: EdgeInsets.all(.8.h),
                child: InkWell(
                  onTap: () {
                    Get.to(() => NotificationScreen());
                  },
                  child: assetImage(
                    'assets/icons/notification_outline.png',
                    color: ThemeColors.white,
                  ),
                ),
              ),
            ],
          ),
          2.h.vs,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              color: ThemeColors.white,
              borderRadius: BorderRadius.circular(6.w),
              border: Border.all(color: ThemeColors.greyColor),
              boxShadow: [
                BoxShadow(
                  color: ThemeColors.greyColor.withAlpha(50),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: ThemeColors.primaryColor, size: 5.w),
                3.w.hs,
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      color: ThemeColors.defaultTextColor,
                      fontSize: 3.5.w,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search mantras, bhajans, videos...',
                      hintStyle: TextStyle(
                        color: ThemeColors.primaryColor,
                        fontSize: 3.5.w,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: controller.onSearch,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaGrid() {
    return Obx(
      () => Column(
        children: [
          // Audio Section
          _buildSectionHeader('Audio Content', () {
            controller.showAllAudioContent.value = true;
          }),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3.w,
              mainAxisSpacing: 3.w,
              childAspectRatio: 0.75,
            ),
            itemCount: min(controller.limitedAudioItems.length, 4),
            itemBuilder: (context, index) {
              final mediaItem = controller.limitedAudioItems[index];
              return _buildMediaCard(mediaItem);
            },
          ),
          3.h.vs,
          Divider(color: ThemeColors.greyColor.withAlpha(100)),

          _buildSectionHeader('Video Content', () {
            controller.showAllVideoContent.value = true;
          }),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3.w,
              mainAxisSpacing: 3.w,
              childAspectRatio: 0.75,
            ),
            itemCount: min(controller.limitedVideoItems.length, 4),
            itemBuilder: (context, index) {
              final mediaItem = controller.limitedVideoItems[index];
              return _buildMediaCard(mediaItem);
            },
          ),
          3.h.vs,

          Divider(color: ThemeColors.greyColor.withAlpha(100)),

          _buildSectionHeader('Text Content', () {
            controller.showAllTextContent.value = true;
          }),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3.w,
              mainAxisSpacing: 3.w,
              childAspectRatio: 0.75,
            ),
            itemCount: min(controller.limitedTextItems.length, 4),
            itemBuilder: (context, index) {
              final mediaItem = controller.limitedTextItems[index];
              return _buildMediaCard(mediaItem);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: ThemeColors.defaultTextColor,
              fontSize: 4.w,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextButton(
            onPressed: () {
              MediaType type;
              if (title.contains('Audio')) {
                type = MediaType.audio;
              } else if (title.contains('Video')) {
                type = MediaType.video;
              } else if (title.contains('Text')) {
                type = MediaType.text;
              } else {
                type = MediaType.audio;
              }

              List<MediaItem> items =
                  controller.allMediaItems
                      .where((item) => item.type == type)
                      .toList();

              Get.to(
                () => MediaListScreen(
                  title: title,
                  mediaItems: items,
                  mediaType: type,
                ),
              );
            },
            child: Text(
              'See All',
              style: TextStyle(
                color: ThemeColors.primaryColor,
                fontSize: 3.5.w,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaCard(MediaItem mediaItem) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColors.white,
        borderRadius: BorderRadius.circular(3.w),
        border: Border.all(
          color: ThemeColors.greyColor.withAlpha(50),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.greyColor.withAlpha(50),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 12.h,
                width: 45.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(3.w),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(3.w),
                  ),
                  child: Image.network(
                    mediaItem.thumbnailUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          width: 45.w,
                          color: ThemeColors.greyColor,
                          child: Image(
                            image: AssetImage('assets/icons/alert_round.png'),
                          ),
                        ),
                  ),
                ),
              ),
              Positioned(
                top: 2.w,
                right: 2.w,
                child: Container(
                  padding: EdgeInsets.all(1.w),
                  decoration: BoxDecoration(
                    color:
                        mediaItem.type == MediaType.video
                            ? ThemeColors.accentColor
                            : ThemeColors.primaryColor,
                    borderRadius: BorderRadius.circular(1.w),
                  ),
                  child: Icon(
                    mediaItem.type == MediaType.video
                        ? Icons.videocam
                        : mediaItem.type == MediaType.audio
                        ? Icons.music_note
                        : Icons.text_fields,
                    color: ThemeColors.white,
                    size: 3.w,
                  ),
                ),
              ),
              Positioned(
                top: 2.w,
                left: 2.w,
                child: Obx(
                  () => GestureDetector(
                    onTap: () => controller.toggleFavorite(mediaItem.id),
                    child: Container(
                      padding: EdgeInsets.all(1.5.w),
                      decoration: BoxDecoration(
                        color: ThemeColors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(1.5.w),
                      ),
                      child: Icon(
                        controller.isFavorite(mediaItem.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                            controller.isFavorite(mediaItem.id)
                                ? ThemeColors.accentColor
                                : ThemeColors.greyColor,
                        size: 4.w,
                      ),
                    ),
                  ),
                ),
              ),
              if (mediaItem.type == MediaType.audio ||
                  mediaItem.type == MediaType.video)
                Positioned(
                  top: 10.w,
                  left: 16.w,
                  child: GestureDetector(
                    onTap: () => controller.playMedia(mediaItem),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: ThemeColors.whiteBlue.withAlpha(200),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          mediaItem.type == MediaType.video
                              ? Icons.play_arrow
                              : Icons.music_note,
                          color: ThemeColors.primaryColor,
                          size: 6.w,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mediaItem.title,
                    style: TextStyle(
                      color: ThemeColors.defaultTextColor,
                      fontSize: 3.2.w,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  1.h.vs,
                  Text(
                    mediaItem.artist,
                    style: TextStyle(
                      color: ThemeColors.greyColor,
                      fontSize: 2.8.w,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: ThemeColors.greyColor,
                        size: 3.w,
                      ),
                      1.w.hs,
                      Text(
                        mediaItem.duration,
                        style: TextStyle(
                          color: ThemeColors.greyColor,
                          fontSize: 2.5.w,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 0.5.w,
                        ),
                        decoration: BoxDecoration(
                          color: ThemeColors.primaryColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(1.w),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: ThemeColors.primaryColor,
                              size: 3.w,
                            ),
                            0.5.w.hs,
                            Text(
                              mediaItem.averageRating.toString(),
                              style: TextStyle(
                                color: ThemeColors.primaryColor,
                                fontSize: 2.8.w,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ThemeColors.accentColor, ThemeColors.primaryColor],
            ),
            borderRadius: BorderRadius.circular(3.w),
            // boxShadow: [
            //   BoxShadow(
            //     color: ThemeColors.accentColor.withAlpha(50),
            //     blurRadius: 8,
            //     offset: const Offset(0, 2),
            //   ),
            // ],
          ),
          child: Text(
            'Top Donors',
            style: TextStyle(
              color: ThemeColors.white,
              fontSize: 3.w,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        2.h.vs,
        const TopDonorsScreen(),
      ],
    );
  }


  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Browse Categories',
          style: TextStyle(
            color: ThemeColors.defaultTextColor,
            fontSize: 4.5.w,
            fontWeight: FontWeight.w700,
          ),
        ),
        2.h.vs,
        Obx(
          () => GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 3.w,
              mainAxisSpacing: 3.w,
              childAspectRatio: 0.9,
            ),
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];
              return _buildCategoryItem(category);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(CategoryData category) {
    return GestureDetector(
      onTap: () => controller.onCategoryTap(category),
      child: Container(
        decoration: BoxDecoration(
          color: ThemeColors.white,
          borderRadius: BorderRadius.circular(2.5.w),
          border: Border.all(color: ThemeColors.greyColor.withAlpha(50)),
          boxShadow: [
            BoxShadow(
              color: ThemeColors.greyColor.withAlpha(50),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(category.icon, style: TextStyle(fontSize: 6.w)),
            1.h.vs,
            Text(
              category.name,
              style: TextStyle(
                color: ThemeColors.defaultTextColor,
                fontSize: 2.8.w,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
