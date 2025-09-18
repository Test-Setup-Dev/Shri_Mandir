import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/model/service_cat.dart';
import 'package:mandir/screen/shop/controller.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/widget/banner_carousel.dart';
import 'package:mandir/widget/my_drawer.dart';

class ShopScreen extends StatelessWidget {
  ShopScreen({super.key});

  final ShopController controller = Get.put(ShopController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      key: Helper.appBarKey,
      drawer: const MyDrawer(),
      body: SafeArea(
        child: Obx(
          () =>
              controller.isLoading.value
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
                              _buildServiceGrid(),
                              3.h.vs,
                              _buildSpecialEvents(),
                              3.h.vs,
                              _buildServiceCategories(),
                              3.h.vs,
                              _buildVideoSection(),
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
            'Loading ${'appName'.t} services...',
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
                    'Deliver Services at Your Doorstep',
                    style: TextStyle(
                      color: ThemeColors.greyColor,
                      fontSize: 2.5.w,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Spacer(),
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
                      hintText: 'Search for Dosha Nivaran Puja',
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

  Widget _buildServiceGrid() {
    return Obx(
      () => GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 3.w,
          mainAxisSpacing: 3.w,
          childAspectRatio: 0.80,
        ),
        itemCount: controller.pujaServices.length,
        itemBuilder: (context, index) {
          final service = controller.pujaServices[index];
          return GestureDetector(
            onTap: () => controller.onServiceTap(service),
            child: Container(
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
                            service.image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => Container(
                                  color: ThemeColors.greyColor,
                                  child: Icon(
                                    Icons.image,
                                    color: ThemeColors.white,
                                    size: 8.w,
                                  ),
                                ),
                          ),
                        ),
                      ),
                      if (service.isSpecial)
                        Positioned(
                          top: 2.w,
                          right: 2.w,
                          child: Container(
                            padding: EdgeInsets.all(1.w),
                            decoration: BoxDecoration(
                              color: ThemeColors.accentColor,
                              borderRadius: BorderRadius.circular(1.w),
                            ),
                            child: Text(
                              'Special',
                              style: TextStyle(
                                color: ThemeColors.white,
                                fontSize: 2.w,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        top: 2.w,
                        left: 2.w,
                        child: Obx(
                          () => GestureDetector(
                            onTap: () => controller.toggleFavorite(service.id),
                            child: Container(
                              padding: EdgeInsets.all(1.5.w),
                              decoration: BoxDecoration(
                                color: ThemeColors.white.withAlpha(50),
                                borderRadius: BorderRadius.circular(1.5.w),
                              ),
                              child: Icon(
                                controller.isFavorite(service.id)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color:
                                    controller.isFavorite(service.id)
                                        ? ThemeColors.accentColor
                                        : ThemeColors.greyColor,
                                size: 4.w,
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
                            service.name,
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
                            service.description,
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
                              Text(
                                '₹${service.price.toInt()}',
                                style: TextStyle(
                                  color: ThemeColors.primaryColor,
                                  fontSize: 3.5.w,
                                  fontWeight: FontWeight.bold,
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
                                      service.rating.toString(),
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildSpecialEvents() {
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
            'Ashtami Shani Amavasya 2025 Special',
            style: TextStyle(
              color: ThemeColors.white,
              fontSize: 3.w,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        2.h.vs,
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.specialEvents.length,
            itemBuilder: (context, index) {
              final event = controller.specialEvents[index];
              return Container(
                margin: EdgeInsets.only(bottom: 3.w),
                decoration: BoxDecoration(
                  color: ThemeColors.white,
                  borderRadius: BorderRadius.circular(3.w),
                  border: Border.all(
                    color: ThemeColors.greyColor.withAlpha(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColors.greyColor.withAlpha(50),
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 18.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(3.w),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(3.w),
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              event.image,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) => Container(
                                    color: ThemeColors.greyColor,
                                    child: Icon(
                                      Icons.image,
                                      color: ThemeColors.white,
                                      size: 10.w,
                                    ),
                                  ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    ThemeColors.black.withAlpha(50),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 3.w,
                              right: 3.w,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 3.w,
                                  vertical: 1.w,
                                ),
                                decoration: BoxDecoration(
                                  color: ThemeColors.primaryColor,
                                  borderRadius: BorderRadius.circular(2.w),
                                ),
                                child: Text(
                                  'Join Now',
                                  style: TextStyle(
                                    color: ThemeColors.white,
                                    fontSize: 2.8.w,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: TextStyle(
                              color: ThemeColors.defaultTextColor,
                              fontSize: 4.w,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                          ),
                          1.h.vs,
                          Text(
                            event.description,
                            style: TextStyle(
                              color: ThemeColors.greyColor,
                              fontSize: 3.2.w,
                              height: 1.3,
                            ),
                          ),
                          1.5.h.vs,
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: ThemeColors.primaryColor,
                                size: 4.w,
                              ),
                              1.w.hs,
                              Text(
                                event.location,
                                style: TextStyle(
                                  color: ThemeColors.primaryColor,
                                  fontSize: 3.w,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.calendar_today,
                                color: ThemeColors.greyColor,
                                size: 3.5.w,
                              ),
                              1.w.hs,
                              Text(
                                '${event.date.day}/${event.date.month}/${event.date.year}',
                                style: TextStyle(
                                  color: ThemeColors.greyColor,
                                  fontSize: 2.8.w,
                                ),
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
        ),
      ],
    );
  }

  Widget _buildServiceCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'All Sri Mandir Services',
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
            itemCount: controller.serviceCategories.length,
            itemBuilder: (context, index) {
              final category = controller.serviceCategories[index];
              return _buildCategoryItem(category);
            },
          ),
        ),
        3.h.vs,
        _buildAdditionalServices(),
        3.h.vs,
        _buildVideoSection(),
      ],
    );
  }

  Widget _buildCategoryItem(ServiceCategory category) {
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

  Widget _buildAdditionalServices() {
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
                Icon(Icons.psychology, color: ThemeColors.white, size: 8.w),
                1.h.vs,
                Text(
                  'Astrology',
                  style: TextStyle(
                    color: ThemeColors.white,
                    fontSize: 3.5.w,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                0.5.h.vs,
                Text(
                  'Expert Consultation',
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
                Icon(
                  Icons.self_improvement,
                  color: ThemeColors.white,
                  size: 8.w,
                ),
                1.h.vs,
                Text(
                  'Rushifal',
                  style: TextStyle(
                    color: ThemeColors.white,
                    fontSize: 3.5.w,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                0.5.h.vs,
                Text(
                  'Daily Predictions',
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

  Widget _buildVideoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ThemeColors.primaryColor, ThemeColors.accentColor],
            ),
            borderRadius: BorderRadius.circular(3.w),
          ),
          child: Text(
            'Today\'s Special',
            style: TextStyle(
              color: ThemeColors.white,
              fontSize: 3.w,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        2.h.vs,
        Text(
          'Divy Darshan\nJaganath',
          style: TextStyle(
            color: ThemeColors.defaultTextColor,
            fontSize: 5.w,
            fontWeight: FontWeight.w900,
            height: 1.2,
          ),
        ),
        1.h.vs,
        Row(
          children: [
            Text(
              'Full Story Experience',
              style: TextStyle(color: ThemeColors.greyColor, fontSize: 3.2.w),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [ThemeColors.primaryColor, ThemeColors.accentColor],
                ),
                borderRadius: BorderRadius.circular(3.w),
                boxShadow: [
                  BoxShadow(
                    color: ThemeColors.primaryColor.withAlpha(50),
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                'Join Us',
                style: TextStyle(
                  color: ThemeColors.white,
                  fontSize: 3.w,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        2.h.vs,
        Container(
          height: 25.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.w),
            boxShadow: [
              BoxShadow(
                color: ThemeColors.greyColor.withAlpha(50),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3.w),
            child: Stack(
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1605792657660-596af9009e82?w=400&h=250&fit=crop',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        color: ThemeColors.greyColor,
                        child: Icon(
                          Icons.image,
                          color: ThemeColors.white,
                          size: 15.w,
                        ),
                      ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        ThemeColors.black.withAlpha(50),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: ThemeColors.white.withAlpha(90),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: ThemeColors.black.withAlpha(50),
                          blurRadius: 20,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: ThemeColors.primaryColor,
                      size: 12.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        2.h.vs,
        Text(
          'Why Devotees Love Sri Mandir',
          style: TextStyle(
            color: ThemeColors.defaultTextColor,
            fontSize: 4.w,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
