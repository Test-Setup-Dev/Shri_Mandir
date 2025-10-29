import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/screen/donation/top_donor/controller.dart';
import 'package:mandir/utils/const.dart';
import 'package:mandir/utils/helper.dart';

class TopDonorsScreen extends StatelessWidget {
  const TopDonorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TopDonorsController());

    return Obx(() {
      if (controller.status == Status.PROGRESS) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.donors.isEmpty) {
        return SizedBox.shrink();
      }

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
          CarouselSlider.builder(
            itemCount: controller.donors.length,
            itemBuilder: (context, index, realIndex) {
              final donor = controller.donors[index];
              return DonorCard(donor: donor, rank: index + 1);
            },
            options: CarouselOptions(
              height: 23.h,
              enlargeCenterPage: true,
              viewportFraction: 0.99,
              aspectRatio: 16 / 9,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enableInfiniteScroll: true,
            ),
          ),
        ],
      );
    });
  }
}

class DonorCard extends StatelessWidget {
  final Donor donor;
  final int rank;

  const DonorCard({super.key, required this.donor, this.rank = 1});

  Color _getRankColor() {
    switch (rank) {
      case 1:
        return const Color(0xFFFFD700); // Gold
      case 2:
        return const Color(0xFFC0C0C0); // Silver
      case 3:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return ThemeColors.greyColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
      decoration: BoxDecoration(
        color: ThemeColors.whiteBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Hero(
                tag: 'donor_${donor.email}',
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _getRankColor().withOpacity(0.3),
                        _getRankColor().withOpacity(0.1),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(1.w),
                  child: ClipOval(
                    child: Image.network(
                      donor.image,
                      width: 18.w,
                      height: 18.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 18.w,
                          height: 18.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ThemeColors.primaryColor.shade300,
                                ThemeColors.colorSecondary.shade300,
                              ],
                            ),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 9.w,
                            color: ThemeColors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 7.w,
                  height: 7.w,
                  decoration: BoxDecoration(
                    color: _getRankColor(),
                    shape: BoxShape.circle,
                    border: Border.all(color: ThemeColors.white, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      '#$rank',
                      style: TextStyle(
                        fontSize: 2.5.w,
                        fontWeight: FontWeight.bold,
                        color: ThemeColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donor.name,
                  style: TextStyle(
                    fontSize: 4.5.w,
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.defaultTextColor,
                  ),
                ),
                SizedBox(height: 1.w),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      size: 3.5.w,
                      color: ThemeColors.textPrimaryColor,
                    ),
                    SizedBox(width: 1.w),
                    Expanded(
                      child: Text(
                        donor.email,
                        style: TextStyle(
                          fontSize: 3.w,
                          color: ThemeColors.textPrimaryColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.w),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 3.5.w,
                      color: ThemeColors.textPrimaryColor,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      donor.city,
                      style: TextStyle(
                        fontSize: 3.w,
                        color: ThemeColors.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                    vertical: 1.5.w,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ThemeColors.primaryColor.shade100,
                        ThemeColors.primaryColor.shade50,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '₹${donor.todayTotalDonation}',
                    style: TextStyle(
                      fontSize: 4.w,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Donor {
  final String name;
  final String email;
  final String image;
  final String city;
  final String todayTotalDonation;

  Donor({
    required this.name,
    required this.email,
    required this.image,
    required this.city,
    required this.todayTotalDonation,
  });

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      city: json['city'] ?? '',
      todayTotalDonation: json['today_total_donation'] ?? '0.00',
    );
  }
}
