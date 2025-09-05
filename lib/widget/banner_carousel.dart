import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mandir/utils/helper.dart';
import 'package:shimmer/shimmer.dart';

class BannerCarousel extends StatelessWidget {
  final List<String> banners;

  const BannerCarousel({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {

    if (banners.isEmpty) {
      return SizedBox(
        height: 25.h,
        width: double.infinity,
        child: Shimmer.fromColors(
          baseColor: Colors.red,
          highlightColor: Colors.red,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
    }
    return CarouselSlider(
      options: CarouselOptions(
        height: 25.h,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 2.w / 2.w,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.easeInBack,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
      items: banners.map((url) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            url,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) =>
            const Center(child: Icon(Icons.broken_image, size: 50)),
          ),
        );
      }).toList(),
    );
  }
}