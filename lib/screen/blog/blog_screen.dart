import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/screen/blog/controller.dart';
import 'package:mandir/utils/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BlogScreen extends StatelessWidget {
  BlogScreen({super.key});

  final BlogController controller = Get.put(BlogController());

  @override
  Widget build(BuildContext context) {
    SizeConfig.initWithContext(context);
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: ThemeColors.primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            1.h.vs,
            Expanded(
              child: Obx(
                () =>
                    controller.isLoading.value
                        ? Center(
                          child: CircularProgressIndicator(
                            color: ThemeColors.primaryColor,
                          ),
                        )
                        : _buildBlogList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: ThemeColors.primaryColor,
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [ThemeColors.white, ThemeColors.offWhite],
        // ),
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
                    // Helper.openDrawer();
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
                    'Blog Section',
                    style: TextStyle(
                      color: ThemeColors.white,
                      fontSize: 4.5.w,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Explore articles and insights',
                    style: TextStyle(
                      color: ThemeColors.whiteBlue,
                      fontSize: 2.5.w,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
          _buildSearchAndFilter(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
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
                    onChanged: controller.searchBlogs,
                    decoration: InputDecoration(
                      hintText: 'Search blogs...',
                      hintStyle: TextStyle(
                        color: ThemeColors.primaryColor,
                        fontSize: 3.5.w,
                      ),
                      border: InputBorder.none,
                    ),
                    // onChanged: controller.onSearch,
                  ),
                ),
              ],
            ),
          ),
          // 2.h.vs,
          /// todo: Blog Filter
          // Container(
          //   height: 10.w,
          //   margin: EdgeInsets.symmetric(vertical: 1.h),
          //   child: Obx(
          //     () => ListView.builder(
          //       scrollDirection: Axis.horizontal,
          //       itemCount: controller.categories.length,
          //       itemBuilder: (context, index) {
          //         final category = controller.categories[index];
          //         final isSelected =
          //             controller.selectedCategory.value == category;
          //         return GestureDetector(
          //           onTap: () => controller.selectCategory(category),
          //           child: Container(
          //             margin: EdgeInsets.only(right: 2.w),
          //             padding: EdgeInsets.symmetric(
          //               horizontal: 4.w,
          //               vertical: 1.w,
          //             ),
          //             decoration: BoxDecoration(
          //               color:
          //               controller.selectedCategory.value == category
          //                       ? ThemeColors.primaryColor
          //                       : ThemeColors.white,
          //               borderRadius: BorderRadius.circular(2.w),
          //               border: Border.all(
          //                 color:
          //                     isSelected
          //                         ? Colors.transparent
          //                         : ThemeColors.greyColor,
          //               ),
          //             ),
          //             child: Center(
          //               child: Text(
          //                 category,
          //                 style: TextStyle(
          //                   color:
          //                       isSelected
          //                           ? ThemeColors.white
          //                           : ThemeColors.defaultTextColor,
          //                   fontSize: 3.w,
          //                   fontWeight:
          //                       isSelected
          //                           ? FontWeight.bold
          //                           : FontWeight.normal,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildBlogList() {
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: controller.filteredBlogs.length,
        itemBuilder: (context, index) {
          final blog = controller.filteredBlogs[index];
          return Container(
            margin: EdgeInsets.only(bottom: 4.w),
            decoration: BoxDecoration(
              color: ThemeColors.white,
              borderRadius: BorderRadius.circular(4.w),
              boxShadow: [
                BoxShadow(
                  color: ThemeColors.greyColor.withAlpha(40),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(4.w),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: PageView.builder(
                      itemCount: blog.images.length,
                      itemBuilder: (context, imageIndex) {
                        // return Image.network(
                        //   blog.images[imageIndex],
                        //   fit: BoxFit.cover,
                        // );
                        return CachedNetworkImage(
                          imageUrl: blog.images[imageIndex],
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          errorWidget:
                              (context, url, error) => const Icon(Icons.error),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 5.w,
                            backgroundImage: NetworkImage(blog.authorImage),
                          ),
                          2.w.hs,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                blog.authorName,
                                style: TextStyle(
                                  fontSize: 3.5.w,
                                  fontWeight: FontWeight.bold,
                                  color: ThemeColors.defaultTextColor,
                                ),
                              ),
                              Text(
                                '${blog.readTime} min read',
                                style: TextStyle(
                                  fontSize: 3.w,
                                  color: ThemeColors.greyColor,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () => controller.toggleBookmark(blog.id),
                            icon: Icon(
                              blog.isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_outline,
                              color: ThemeColors.primaryColor,
                              size: 6.w,
                            ),
                          ),
                        ],
                      ),
                      2.h.vs,
                      Text(
                        blog.title,
                        style: TextStyle(
                          fontSize: 4.5.w,
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.defaultTextColor,
                        ),
                      ),
                      1.h.vs,
                      Text(
                        blog.subtitle,
                        style: TextStyle(
                          fontSize: 3.5.w,
                          color: ThemeColors.greyColor,
                        ),
                      ),
                      2.h.vs,
                      Row(
                        children: [
                          _buildInteractionButton(
                            Icons.favorite_outline,
                            blog.likes.toString(),
                            () => controller.likeBlog(blog.id),
                          ),
                          3.w.hs,
                          _buildInteractionButton(
                            Icons.comment_outlined,
                            blog.comments.toString(),
                            () {},
                          ),
                          Spacer(),
                          Wrap(
                            spacing: 2.w,
                            children:
                                blog.tags
                                    .map(
                                      (tag) => Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 2.w,
                                          vertical: 1.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: ThemeColors.primaryColor
                                              .withAlpha(30),
                                          borderRadius: BorderRadius.circular(
                                            1.w,
                                          ),
                                        ),
                                        child: Text(
                                          tag,
                                          style: TextStyle(
                                            fontSize: 2.8.w,
                                            color: ThemeColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInteractionButton(
    IconData icon,
    String count,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: ThemeColors.greyColor, size: 5.w),
          1.w.hs,
          Text(
            count,
            style: TextStyle(fontSize: 3.w, color: ThemeColors.greyColor),
          ),
        ],
      ),
    );
  }
}
