import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/model/home_data.dart';
import 'package:mandir/model/media_category.dart';
import 'package:mandir/screen/home/controller.dart';
import 'package:mandir/screen/notification/notification_screen.dart';
import 'package:mandir/screen/test2.dart';
import 'package:mandir/utils/const.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/widget/banner_carousel.dart';
import 'package:mandir/widget/my_drawer.dart';
import 'package:mandir/widget/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      key: Helper.appBarKey,
      drawer: const MyDrawer(),
      body: SafeArea(
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
                              BannerCarousel(banners: controller.banners),
                              3.h.vs,
                              _buildMediaTabs(),
                              2.h.vs,
                              _buildMediaGrid(),
                              3.h.vs,
                              _buildFeaturedSection(),
                              3.h.vs,
                              _buildCategoriesSection(),
                              12.h.vs, // Bottom padding for nav bar
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

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: ThemeColors.primaryColor),
          2.h.vs,
          Text(
            'Loading media content...',
            style: TextStyle(
              color: ThemeColors.defaultTextColor,
              fontSize: 4.w,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ThemeColors.white, ThemeColors.offWhite],
        ),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.greyColor.withAlpha(50),
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
                    color: ThemeColors.defaultTextColor,
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
                      color: ThemeColors.defaultTextColor,
                      fontSize: 4.5.w,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Divine Sounds & Videos Collection',
                    style: TextStyle(
                      color: ThemeColors.greyColor,
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
                  child: assetImage('assets/icons/notification_outline.png'),
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
                Icon(Icons.search, color: ThemeColors.greyColor, size: 5.w),
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
                        color: ThemeColors.greyColor,
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

  Widget _buildMediaTabs() {
    return Container(
      height: 6.h,
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => GestureDetector(
                onTap: () => controller.setMediaType(MediaType.audio),
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        controller.selectedMediaType.value == MediaType.audio
                            ? ThemeColors.primaryColor
                            : ThemeColors.white,
                    borderRadius: BorderRadius.circular(3.w),
                    border: Border.all(
                      color:
                          controller.selectedMediaType.value == MediaType.audio
                              ? Colors.transparent
                              : ThemeColors.greyColor.withAlpha(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ThemeColors.greyColor.withAlpha(30),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.music_note,
                          color:
                              controller.selectedMediaType.value ==
                                      MediaType.audio
                                  ? ThemeColors.white
                                  : ThemeColors.greyColor,
                          size: 4.w,
                        ),
                        1.w.hs,
                        Text(
                          'Audio',
                          style: TextStyle(
                            color:
                                controller.selectedMediaType.value ==
                                        MediaType.audio
                                    ? ThemeColors.white
                                    : ThemeColors.greyColor,
                            fontSize: 3.5.w,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          2.w.hs,
          Expanded(
            child: Obx(
              () => GestureDetector(
                onTap: () => controller.setMediaType(MediaType.video),
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        controller.selectedMediaType.value == MediaType.video
                            ? ThemeColors.primaryColor
                            : ThemeColors.white,
                    borderRadius: BorderRadius.circular(3.w),
                    border: Border.all(
                      color:
                          controller.selectedMediaType.value == MediaType.video
                              ? Colors.transparent
                              : ThemeColors.greyColor.withAlpha(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ThemeColors.greyColor.withAlpha(30),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.videocam,
                          color:
                              controller.selectedMediaType.value ==
                                      MediaType.video
                                  ? ThemeColors.white
                                  : ThemeColors.greyColor,
                          size: 4.w,
                        ),
                        1.w.hs,
                        Text(
                          'Video',
                          style: TextStyle(
                            color:
                                controller.selectedMediaType.value ==
                                        MediaType.video
                                    ? ThemeColors.white
                                    : ThemeColors.greyColor,
                            fontSize: 3.5.w,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaGrid() {
    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 3.w,
          mainAxisSpacing: 3.w,
          childAspectRatio: 0.75,
        ),
        itemCount: controller.filteredMediaItems.length,
        itemBuilder: (context, index) {
          final mediaItem = controller.filteredMediaItems[index];
          return _buildMediaCard(mediaItem);
        },
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
                        : Icons.music_note,
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
              Positioned(
                top: 10.w,
                left: 16.w,
                child: GestureDetector(
                  onTap: () => controller.playMedia(mediaItem),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: ThemeColors.white.withAlpha(90),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.play_arrow,
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
                              mediaItem.rating.toString(),
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
            boxShadow: [
              BoxShadow(
                color: ThemeColors.accentColor.withAlpha(50),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            'Featured Collections',
            style: TextStyle(
              color: ThemeColors.white,
              fontSize: 3.w,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        2.h.vs,
        _buildFeaturedCards(),
      ],
    );
  }

  Widget _buildFeaturedCards() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ThemeColors.primaryColor, ThemeColors.accentColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(3.w),
              boxShadow: [
                BoxShadow(
                  color: ThemeColors.primaryColor.withAlpha(50),
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.headphones, color: ThemeColors.white, size: 8.w),
                1.h.vs,
                Text(
                  'Mantras',
                  style: TextStyle(
                    color: ThemeColors.white,
                    fontSize: 3.5.w,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                0.5.h.vs,
                Text(
                  'Sacred Chants',
                  style: TextStyle(
                    color: ThemeColors.white.withAlpha(90),
                    fontSize: 2.5.w,
                  ),
                ),
              ],
            ),
          ),
        ),
        3.w.hs,
        Expanded(
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ThemeColors.accentColor, ThemeColors.primaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(3.w),
              boxShadow: [
                BoxShadow(
                  color: ThemeColors.accentColor.withAlpha(50),
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.music_video, color: ThemeColors.white, size: 8.w),
                1.h.vs,
                Text(
                  'Bhajans',
                  style: TextStyle(
                    color: ThemeColors.white,
                    fontSize: 3.5.w,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                0.5.h.vs,
                Text(
                  'Devotional Songs',
                  style: TextStyle(
                    color: ThemeColors.white.withAlpha(90),
                    fontSize: 2.5.w,
                  ),
                ),
              ],
            ),
          ),
        ),
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

  Widget _buildCategoryItem(MediaCategory category) {
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
