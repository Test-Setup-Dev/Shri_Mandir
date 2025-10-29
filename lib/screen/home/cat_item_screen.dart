import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/model/home_data.dart';
import 'package:mandir/screen/home/controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mandir/screen/old_latter/old_latter_screen.dart';
import 'package:mandir/utils/helper.dart';

class CatItemScreen extends StatelessWidget {
  final Category category;
  final HomeController controller = Get.put(HomeController());

  CatItemScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final audioItems =
        category.mediaItems.where((e) => e.type == MediaType.audio).toList();
    final videoItems =
        category.mediaItems.where((e) => e.type == MediaType.video).toList();
    final textItems =
        category.mediaItems.where((e) => e.type == MediaType.text).toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            _buildHeader(),
            Container(
              color: ThemeColors.primaryColor,
              child: TabBar(
                indicatorColor: ThemeColors.white,
                labelColor: ThemeColors.white,
                unselectedLabelColor: ThemeColors.white.withAlpha(150),
                tabs: const [
                  Tab(text: 'Audio'),
                  Tab(text: 'Video'),
                  Tab(text: 'Text'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildMediaList(audioItems),
                  _buildMediaList(videoItems),
                  // _buildTextContent(textItems),
                  _buildText(textItems),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 6.h, bottom: 3.h, left: 4.w, right: 4.w),
      decoration: BoxDecoration(
        color: ThemeColors.primaryColor,
        boxShadow: [
          BoxShadow(
            color: ThemeColors.primaryColor.withAlpha(50),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
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
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: ThemeColors.primaryColor,
                size: 6.w,
              ),
            ),
          ),
          3.w.hs,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name ?? '',
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
                    fontSize: 2.8.w,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaList(List<MediaItem> items) {
    if (items.isEmpty) {
      return const Center(child: Text('No items found'));
    }
    return GridView.builder(
      padding: EdgeInsets.all(4.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 3.w,
        childAspectRatio: 0.75,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildMediaCard(items[index]);
      },
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
                  child: CachedNetworkImage(
                    imageUrl: mediaItem.thumbnailUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) =>
                            Image.asset('assets/icons/image_not_found.png'),
                    errorWidget:
                        (context, url, error) => Container(
                          width: 45.w,
                          color: ThemeColors.greyColor,
                          child: Image.asset('assets/icons/alert_round.png'),
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

  Widget _buildText(List<MediaItem> items) {
    if (items.isEmpty) {
      return const Center(child: Text('No items found'));
    }

    return ListView.builder(
      itemCount: items.length,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        MediaItem mediaItem = items[index];

        return GestureDetector(
          onTap: () {
            Get.to(() => OldLatterScreen(mediaItem: mediaItem));
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage('assets/icons/old_screen.png'),
                  fit: BoxFit.fill,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ThemeColors.oldLatterLight5.withAlpha(120),
                    blurRadius: 10.w,
                    offset: Offset(0.w, 0.w),
                    // offset: Offset(4.w, 4.w),
                  ),
                ],
              ),
              child: Column(
                children: [
                  22.vs,
                  // Title in Script Font
                  Text(
                    mediaItem.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Satisfy',
                      // or 'GreatVibes', 'DancingScript'
                      fontSize: 5.w,
                      fontWeight: FontWeight.w500,
                      color: ThemeColors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 1.h),

                  // Author
                  Text(
                    '- ${mediaItem.artist} -',
                    style: TextStyle(
                      fontFamily: 'Satisfy',
                      fontSize: 3.w,
                      fontStyle: FontStyle.italic,
                      color: ThemeColors.white,
                    ),
                  ),

                  SizedBox(height: 2.h),

                  // Text Preview
                  if (mediaItem.content != null &&
                      mediaItem.content!.isNotEmpty)
                    Container(
                      // color: Colors.red,
                      constraints: BoxConstraints(maxHeight: 15.h),
                      width: 60.w,
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Text(
                          mediaItem.content!
                              .where((line) => line.trim().isNotEmpty)
                              .take(6)
                              .join('\n'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Satisfy',
                            fontSize: 3.5.w,
                            height: 1.8,
                            color: ThemeColors.white,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 6,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),

                  SizedBox(height: 2.h),

                  // Read More Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '~ Tap to Read ~',
                        style: TextStyle(
                          fontFamily: 'Satisfy',
                          fontSize: 2.5.w,
                          color: ThemeColors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
