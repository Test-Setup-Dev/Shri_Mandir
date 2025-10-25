// import 'package:flutter/material.dart';
// import 'package:mandir/utils/helper.dart';
// import 'package:mandir/widget/banner_carousel.dart';
//
// // Model class for Donor
// class Donor {
//   final String name;
//   final String email;
//   final String image;
//   final String city;
//   final String todayTotalDonation;
//
//   Donor({
//     required this.name,
//     required this.email,
//     required this.image,
//     required this.city,
//     required this.todayTotalDonation,
//   });
//
//   factory Donor.fromJson(Map<String, dynamic> json) {
//     return Donor(
//       name: json['name'] ?? '',
//       email: json['email'] ?? '',
//       image: json['image'] ?? '',
//       city: json['city'] ?? '',
//       todayTotalDonation: json['today_total_donation'] ?? '0.00',
//     );
//   }
// }
//
// // Donor Card Widget
// class DonorCard extends StatelessWidget {
//   final Donor donor;
//   final int rank;
//
//   const DonorCard({super.key, required this.donor, this.rank = 1});
//
//   Color _getRankColor() {
//     switch (rank) {
//       case 1:
//         return const Color(0xFFFFD700); // Gold
//       case 2:
//         return const Color(0xFFC0C0C0); // Silver
//       case 3:
//         return const Color(0xFFCD7F32); // Bronze
//       default:
//         return Colors.grey;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           children: [
//             // Profile Image
//             Stack(
//               children: [
//                 Hero(
//                   tag: 'donor_${donor.email}',
//                   child: Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           _getRankColor().withOpacity(0.3),
//                           _getRankColor().withOpacity(0.1),
//                         ],
//                       ),
//                     ),
//                     padding: const EdgeInsets.all(4),
//                     child: ClipOval(
//                       child: Image.network(
//                         donor.image,
//                         width: 70,
//                         height: 70,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Container(
//                             width: 70,
//                             height: 70,
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Colors.blue.shade300,
//                                   Colors.purple.shade300,
//                                 ],
//                               ),
//                             ),
//                             child: const Icon(
//                               Icons.person,
//                               size: 35,
//                               color: Colors.white,
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: 0,
//                   bottom: 0,
//                   child: Container(
//                     width: 28,
//                     height: 28,
//                     decoration: BoxDecoration(
//                       color: _getRankColor(),
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.white, width: 2),
//                       boxShadow: [
//                         BoxShadow(
//                           color: _getRankColor().withOpacity(0.4),
//                           blurRadius: 8,
//                           spreadRadius: 2,
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         '#$rank',
//                         style: const TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(width: 16),
//
//             // Donor Details
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     donor.name,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       const Icon(Icons.email, size: 14, color: Colors.grey),
//                       const SizedBox(width: 4),
//                       Expanded(
//                         child: Text(
//                           donor.email,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[600],
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.location_on,
//                         size: 14,
//                         color: Colors.grey,
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         donor.city,
//                         style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.green[50],
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       '₹${donor.todayTotalDonation}',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green[700],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Example usage widget
// class TopDonorsPage extends StatelessWidget {
//   const TopDonorsPage({Key? key}) : super(key: key);
//
//   // Parse your API response
//   List<Donor> parseDonors(Map<String, dynamic> apiResponse) {
//     if (apiResponse['status'] == true && apiResponse['data'] != null) {
//       return (apiResponse['data'] as List)
//           .map((donorJson) => Donor.fromJson(donorJson))
//           .toList();
//     }
//     return [];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Your API response
//     final apiResponse = {
//       "status": true,
//       "message": "Top 3 donors fetched successfully.",
//       "data": [
//         {
//           "name": "Ajay Rawat",
//           "email": "testsetup.dev@gmail.com",
//           "image":
//               "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341",
//           "city": "Dehradun",
//           "today_total_donation": "2105.00",
//         },
//       ],
//     };
//
//     final donors = parseDonors(apiResponse);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Top Donors'),
//         backgroundColor: Colors.green,
//       ),
//       body: ListView.builder(
//         itemCount: donors.length,
//         itemBuilder: (context, index) {
//           return Column(
//             children: [
//               DonorCard(donor: donors[index], rank: index + 1),
//               5.h.vs,
//               TopDonorBannerCarousel(
//                 banners: [DonorCard(donor: donors[index], rank: index + 1)],
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
