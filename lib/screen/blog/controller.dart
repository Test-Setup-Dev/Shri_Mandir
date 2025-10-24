// import 'package:get/get.dart';
//
// class BlogController extends GetxController {
//   final RxBool isLoading = false.obs;
//   final RxString searchQuery = ''.obs;
//   final RxString selectedCategory = 'All'.obs;
//   final RxList<BlogModel> blogs = <BlogModel>[].obs;
//   final RxList<BlogModel> filteredBlogs = <BlogModel>[].obs;
//   final RxList<String> categories =
//       <String>[
//         'All',
//         'Spirituality',
//         'Festivals',
//         'Traditions',
//         'Rituals',
//         'Culture',
//       ].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadBlogs();
//   }
//
//   void loadBlogs() {
//     isLoading.value = true;
//     // Simulated API call with dummy data
//     Future.delayed(const Duration(seconds: 1), () {
//       blogs.value = [
//         BlogModel(
//           id: '1',
//           title: 'Understanding the Significance of Navaratri',
//           subtitle: 'A deep dive into the nine nights of divine celebration',
//           content: 'Lorem ipsum dolor sit amet...',
//           images: [
//             'https://images.unsplash.com/photo-1620288627223-53302f4e8c74',
//             'https://images.unsplash.com/photo-1620288627264-19f20326f9b6',
//           ],
//           authorName: 'Pandit Sharma',
//           authorImage: 'https://randomuser.me/api/portraits/men/1.jpg',
//           publishDate: DateTime.now().subtract(const Duration(days: 2)),
//           likes: 234,
//           comments: 45,
//           tags: ['Festival', 'Spirituality', 'Tradition'],
//           readTime: 5,
//         ),
//         BlogModel(
//           id: '2',
//           title: 'The Science Behind Meditation',
//           subtitle: 'How meditation reshapes the brain and reduces stress',
//           content:
//               'Meditation has been practiced for centuries and modern science is now proving its benefits...',
//           images: [
//             'https://images.unsplash.com/photo-1506126613408-eca07ce68773',
//             'https://images.unsplash.com/photo-1522202176988-66273c2fd55f',
//           ],
//           authorName: 'Dr. Meera Kapoor',
//           authorImage: 'https://randomuser.me/api/portraits/women/2.jpg',
//           publishDate: DateTime.now().subtract(const Duration(days: 5)),
//           likes: 512,
//           comments: 89,
//           tags: ['Meditation', 'Health', 'Mindfulness'],
//           readTime: 7,
//         ),
//         BlogModel(
//           id: '3',
//           title: 'Vastu Shastra for Modern Homes',
//           subtitle: 'Blending ancient architecture with contemporary living',
//           content:
//               'Vastu Shastra provides guiding principles that harmonize energy in living spaces...',
//           images: [
//             'https://images.unsplash.com/photo-1505691938895-1758d7feb511',
//             'https://images.unsplash.com/photo-1523217582562-09d0def993a6',
//           ],
//           authorName: 'Acharya Desai',
//           authorImage: 'https://randomuser.me/api/portraits/men/3.jpg',
//           publishDate: DateTime.now().subtract(const Duration(days: 8)),
//           likes: 189,
//           comments: 34,
//           tags: ['Vastu', 'Architecture', 'Lifestyle'],
//           readTime: 6,
//         ),
//         BlogModel(
//           id: '4',
//           title: 'Ayurveda: The Science of Life',
//           subtitle: 'Natural remedies for holistic health and wellness',
//           content:
//               'Ayurveda emphasizes balance in bodily systems using diet, herbal treatment, and yogic breathing...',
//           images: [
//             'https://images.unsplash.com/photo-1603398938378-e54eab4a28e6',
//             'https://images.unsplash.com/photo-1599058917212-d750089bc07c',
//           ],
//           authorName: 'Dr. Radhika Iyer',
//           authorImage: 'https://randomuser.me/api/portraits/women/4.jpg',
//           publishDate: DateTime.now().subtract(const Duration(days: 12)),
//           likes: 420,
//           comments: 67,
//           tags: ['Ayurveda', 'Health', 'Wellness'],
//           readTime: 8,
//         ),
//         BlogModel(
//           id: '5',
//           title: 'The Power of Mantras',
//           subtitle: 'How sacred sounds can transform your mind and soul',
//           content:
//               'Chanting mantras has been a part of spiritual practice across cultures, offering peace and clarity...',
//           images: [
//             'https://images.unsplash.com/photo-1552058544-f2b08422138a',
//             'https://images.unsplash.com/photo-1605721911519-3dfeb3be1ef8',
//           ],
//           authorName: 'Swami Anant',
//           authorImage: 'https://randomuser.me/api/portraits/men/5.jpg',
//           publishDate: DateTime.now().subtract(const Duration(days: 15)),
//           likes: 365,
//           comments: 52,
//           tags: ['Mantras', 'Spirituality', 'Peace'],
//           readTime: 4,
//         ),
//       ];
//
//       filteredBlogs.value = blogs;
//       isLoading.value = false;
//     });
//   }

//   void searchBlogs(String query) {
//     searchQuery.value = query;
//     filterBlogs();
//   }
//
//   void selectCategory(String category) {
//     selectedCategory.value = category;
//     filterBlogs();
//   }
//
//   void filterBlogs() {
//     if (searchQuery.isEmpty && selectedCategory.value == 'All') {
//       filteredBlogs.value = blogs;
//       return;
//     }
//
//     filteredBlogs.value =
//         blogs.where((blog) {
//           final matchesSearch = blog.title.toLowerCase().contains(
//             searchQuery.toLowerCase(),
//           );
//           final matchesCategory =
//               selectedCategory.value == 'All' ||
//               blog.tags.contains(selectedCategory.value);
//           return matchesSearch && matchesCategory;
//         }).toList();
//   }
//
//   void toggleBookmark(String blogId) {
//     final index = blogs.indexWhere((blog) => blog.id == blogId);
//     if (index != -1) {
//       final blog = blogs[index];
//       blogs[index] = BlogModel(
//         id: blog.id,
//         title: blog.title,
//         subtitle: blog.subtitle,
//         content: blog.content,
//         images: blog.images,
//         authorName: blog.authorName,
//         authorImage: blog.authorImage,
//         publishDate: blog.publishDate,
//         likes: blog.likes,
//         comments: blog.comments,
//         tags: blog.tags,
//         isBookmarked: !blog.isBookmarked,
//         readTime: blog.readTime,
//       );
//       filterBlogs();
//     }
//   }
//
//   void likeBlog(String blogId) {
//     // Implement like functionality
//   }
//
//   void commentOnBlog(String blogId, String comment) {
//     // Implement comment functionality
//   }
// }
//
// class BlogModel {
//   final String id;
//   final String title;
//   final String subtitle;
//   final String content;
//   final List<String> images;
//   final String authorName;
//   final String authorImage;
//   final DateTime publishDate;
//   final int likes;
//   final int comments;
//   final List<String> tags;
//   final bool isBookmarked;
//   final int readTime;
//
//   BlogModel({
//     required this.id,
//     required this.title,
//     required this.subtitle,
//     required this.content,
//     required this.images,
//     required this.authorName,
//     required this.authorImage,
//     required this.publishDate,
//     required this.likes,
//     required this.comments,
//     required this.tags,
//     this.isBookmarked = false,
//     required this.readTime,
//   });
// }
//
// class BlogComment {
//   final String id;
//   final String userId;
//   final String userName;
//   final String userImage;
//   final String comment;
//   final DateTime timestamp;
//   final int likes;
//
//   BlogComment({
//     required this.id,
//     required this.userId,
//     required this.userName,
//     required this.userImage,
//     required this.comment,
//     required this.timestamp,
//     required this.likes,
//   });
// }
//

import 'package:get/get.dart';
import 'package:mandir/data_handler/repository.dart';

class BlogController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final RxString selectedCategory = 'All'.obs;
  final RxList<BlogModel> blogs = <BlogModel>[].obs;
  final RxList<BlogModel> filteredBlogs = <BlogModel>[].obs;
  final RxList<String> categories = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadBlogs();
  }

  Future<void> loadBlogs() async {
    isLoading.value = true;
    try {
      final response = await Repository.instance.getBlogs();
      if (response != null && response['status'] == true) {
        List data = response['data'];
        blogs.value = data.map((e) => BlogModel.fromJson(e)).toList();

        // Extract categories dynamically
        categories.value = ['All', ...blogs.map((e) => e.category).toSet()];

        filteredBlogs.value = blogs;
      }
    } catch (e) {
      print('Error fetching blogs: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void searchBlogs(String query) {
    searchQuery.value = query;
    filterBlogs();
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    filterBlogs();
  }

  void filterBlogs() {
    if (searchQuery.isEmpty && selectedCategory.value == 'All') {
      filteredBlogs.value = blogs;
      return;
    }

    filteredBlogs.value =
        blogs.where((blog) {
          final matchesSearch = blog.title.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          );
          final matchesCategory =
              selectedCategory.value == 'All' ||
              blog.category == selectedCategory.value;
          return matchesSearch && matchesCategory;
        }).toList();
  }

  void toggleBookmark(String blogId) {
    // final index = blogs.indexWhere((blog) => blog.id == blogId);
    // if (index != -1) {
    //   final blog = blogs[index];
    //   blogs[index] = BlogModel(
    //     id: blog.id,
    //     title: blog.title,
    //     subtitle: blog.subtitle,
    //     content: blog.content,
    //     images: blog.images,
    //     authorName: blog.authorName,
    //     authorImage: blog.authorImage,
    //     publishDate: blog.publishDate,
    //     likes: blog.likes,
    //     comments: blog.comments,
    //     tags: blog.tags,
    //     isBookmarked: !blog.isBookmarked,
    //     readTime: blog.readTime,
    //   );
    //   filterBlogs();
    // }
  }

  void likeBlog(String blogId) {
    // Implement like functionality
  }

  void commentOnBlog(String blogId, String comment) {
    // Implement comment functionality
  }
}

class BlogModel {
  final String id;
  final String title;
  final String subtitle;
  final String content;
  final String category;
  final List<String> images;
  final String authorName;
  final String authorImage;
  final DateTime publishDate;

  final int likes;
  final int comments;
  final List<String> tags;
  final bool isBookmarked;
  final int readTime;

  BlogModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.category,
    required this.images,
    required this.authorName,
    required this.authorImage,
    required this.publishDate,

    required this.likes,
    required this.comments,
    required this.tags,
    this.isBookmarked = false,
    required this.readTime,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      content: json['content'] ?? '',
      category: json['category'] ?? 'Uncategorized',
      images: List<String>.from(json['images'] ?? []),
      authorName: json['author_name'] ?? '',
      authorImage: json['author_image'] ?? '',
      publishDate:
          DateTime.tryParse(json['publish_date'] ?? '') ?? DateTime.now(),

      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
      tags: [json['category'] ?? 'Festival', 'Spirituality', 'Tradition'],
      isBookmarked: json['is_bookmarked'] ?? false,
      readTime: json['read_time'] ?? 5,
    );
  }
}
