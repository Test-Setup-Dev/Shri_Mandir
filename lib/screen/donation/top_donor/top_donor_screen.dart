import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/screen/donation/top_donor/controller.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/widget/banner_carousel.dart';

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
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                    padding: const EdgeInsets.all(4),
                    child: ClipOval(
                      child: Image.network(
                        donor.image,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.shade300,
                                  Colors.purple.shade300,
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 35,
                              color: Colors.white,
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
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: _getRankColor(),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: _getRankColor().withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '#$rank',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    donor.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.email, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          donor.email,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        donor.city,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '₹${donor.todayTotalDonation}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopDonorsScreen extends StatelessWidget {
  const TopDonorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TopDonorsController());

    return Container(
      color: Colors.red,
      child: Obx(() {
        if (controller.donors.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.donors.length,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          itemBuilder: (context, index) {
            final donor = controller.donors[index];
            return SizedBox(
              width: 50.h,
              child: DonorCard(donor: donor, rank: index + 1),
            );
          },
        );
      }),
    );
  }
}
