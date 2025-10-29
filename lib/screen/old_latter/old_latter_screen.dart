import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/model/home_data.dart';
import 'package:mandir/utils/helper.dart';

class OldLatterScreen extends StatelessWidget {
  final MediaItem mediaItem;

  const OldLatterScreen({super.key, required this.mediaItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        backgroundColor: ThemeColors.primaryColor,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          _buildHeader(),
          Container(
            width: 100.w,
            // height: 90.3.h,
            height: 90.8.h,
            decoration: BoxDecoration(
              // color: Colors.red,
              image: DecorationImage(
                image: AssetImage('assets/icons/old_screen.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                20.vs,

                // Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    mediaItem.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Satisfy',
                      fontSize: 6.w,
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 1.h),

                // Author
                Text(
                  '~ ${mediaItem.artist} ~',
                  style: TextStyle(
                    fontFamily: 'Satisfy',
                    fontSize: 3.5.w,
                    fontStyle: FontStyle.italic,
                    color: ThemeColors.white,
                  ),
                ),

                SizedBox(height: 2.h),

                // Divider
                Container(
                  width: 30.w,
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        ThemeColors.white,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 2.h),

                // Content
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child:
                        mediaItem.content != null
                            ? Column(
                              children:
                                  mediaItem.content!
                                      .map(
                                        (line) => Padding(
                                          padding: EdgeInsets.only(
                                            bottom: 1.2.h,
                                          ),
                                          child: Container(
                                            // color: Colors.red,
                                            width: 60.w,
                                            child: Text(
                                              line,
                                              textAlign:
                                                  line.trim().isEmpty
                                                      ? TextAlign.center
                                                      : TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Satisfy',
                                                fontSize: 5.w,
                                                height: 1.8,
                                                color:
                                                    line.trim().isEmpty
                                                        ? Colors.transparent
                                                        : ThemeColors
                                                            .white,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                            )
                            : Center(
                              child: Text(
                                'No content available',
                                style: TextStyle(
                                  fontFamily: 'Satisfy',
                                  fontSize: 3.5.w,
                                  color: ThemeColors.oldLatterLight3,
                                ),
                              ),
                            ),
                  ),
                ),

                20.vs
              ],
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
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back,
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
                    'Mantras',
                    style: TextStyle(
                      color: ThemeColors.white,
                      fontSize: 4.5.w,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Divine Mantras List',
                    style: TextStyle(
                      color: ThemeColors.whiteBlue,
                      fontSize: 2.5.w,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
