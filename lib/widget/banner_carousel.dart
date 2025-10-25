import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mandir/utils/helper.dart';

// class BannerCarousel extends StatelessWidget {
//   final List<String> banners;
//
//   const BannerCarousel({super.key, required this.banners});
//
//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         height: 25.h,
//         autoPlay: true,
//         enlargeCenterPage: true,
//         viewportFraction: 0.9,
//         aspectRatio: 16 / 9,
//         autoPlayCurve: Curves.easeInBack,
//         enableInfiniteScroll: true,
//         autoPlayAnimationDuration: const Duration(milliseconds: 800),
//       ),
//       items: banners.map((url) {
//         return ClipRRect(
//           borderRadius: BorderRadius.circular(12),
//           child: Image.network(
//             url,
//             fit: BoxFit.cover,
//             width: double.infinity,
//             errorBuilder: (context, error, stackTrace) =>
//             const Center(child: Icon(Icons.broken_image, size: 50)),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }

class BannerCarousel extends StatelessWidget {
  final List<String> banners;

  const BannerCarousel({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty) {
      return SizedBox(
        height: 25.h,
        child: Center(child: Text("No banners found")),
      );
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: 28.h,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.95,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.easeInBack,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
      items:
          banners.map((url) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder:
                    (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.broken_image, size: 50)),
              ),
            );
          }).toList(),
    );
  }
}

class TopDonorBannerCarousel extends StatelessWidget {
  final List<Widget>? banners;

  const TopDonorBannerCarousel({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    if (banners!.isEmpty) {
      return SizedBox(
        height: 25.h,
        child: Center(child: Text("No banners found")),
      );
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: 23.h,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.99,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.easeInBack,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
      items: banners,
    );
  }
}
