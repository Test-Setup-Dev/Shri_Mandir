import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/model/home_data.dart';
import 'package:mandir/screen/home/controller.dart';
import 'package:mandir/utils/helper.dart';


class MediaListScreen extends StatelessWidget {
  final String title;
  final List<MediaItem> mediaItems;
  final MediaType mediaType;

  MediaListScreen({
    super.key,
    required this.title,
    required this.mediaItems,
    required this.mediaType,
  });

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            color: ThemeColors.defaultTextColor,
            fontSize: 4.5.w,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: ThemeColors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ThemeColors.defaultTextColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(4.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 3.w,
          mainAxisSpacing: 3.w,
          childAspectRatio: 0.75,
        ),
        itemCount: mediaItems.length,
        itemBuilder: (context, index) {
          return _buildMediaCard(mediaItems[index]);
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
                  child: CachedNetworkImage(
                    imageUrl: mediaItem.thumbnailUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset('assets/icons/image_not_found.png'),
                    errorWidget: (context, url, error) => Container(
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
}
