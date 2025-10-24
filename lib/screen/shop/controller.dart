import 'package:get/get.dart';
import 'package:mandir/data_handler/repository.dart';
import 'package:mandir/model/puja.dart';
import 'package:mandir/model/service_cat.dart';
import 'package:mandir/model/special_event.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/values/theme_colors.dart';

class ShopController extends GetxController {
  var isLoading = false.obs;
  var searchQuery = ''.obs;

  var serviceCategories = <ServiceCategory>[].obs;
  var pujaServices = <PujaService>[].obs;
  var specialEvents = <SpecialEvent>[].obs;
  var featuredServices = <PujaService>[].obs;
  var favoriteServices = <String>[].obs;
  var banners =
      <String>[
        'https://uicreative.s3.ap-southeast-1.amazonaws.com/wp-content/uploads/2019/11/23101032/image_preview_WB_11.jpg',
        'https://img.freepik.com/free-psd/creative-business-partner-banner-template_23-2148938802.jpg',
        'https://img.freepik.com/free-psd/business-development-banner-template-with-photo_23-2149063833.jpg',
        'https://img.freepik.com/free-psd/creative-business-partner-banner-template_23-2148938802.jpg',
      ].obs;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  void loadHomeData() {
    isLoading.value = true;
    _loadPujaServices();
    _loadSpecialEvents();
    isLoading.value = false;
  }

  void _loadBanner() async {
    final response = await Repository.instance.getBanner();
    print('this is my data $response');

  }


  void _loadPujaServices() {
    pujaServices.value = [
      PujaService(
        id: '1',
        name: 'Shani Til-Tel Abhishekam',
        description: 'For removing obstacles',
        image: 'https://i.imgur.com/tXyOMMG.png',
        price: 251.0,
        rating: 4.5,
        duration: '30 min',
        category: 'Shani',
        isSpecial: true,
      ),
      PujaService(
        id: '2',
        name: 'Kundali Navgrah Shanti',
        description: 'Planetary peace ritual',
        image: 'https://finebuy.co.in/wp-content/uploads/2022/07/top13.webp',
        price: 501.0,
        rating: 4.8,
        duration: '45 min',
        category: 'Navgrah',
      ),
      PujaService(
        id: '3',
        name: 'Shani Amavasya Ganga',
        description: 'Special Ganga offering',
        image: 'https://i.imgur.com/R2PN9Wq.jpeg',
        price: 351.0,
        rating: 4.6,
        duration: '25 min',
        category: 'Shani',
      ),
      PujaService(
        id: '4',
        name: 'Pitru Shanti Dosha Nivaran',
        description: 'Ancestral peace ritual',
        image: 'https://i.imgur.com/JfyZlnO.png',
        price: 751.0,
        rating: 4.9,
        duration: '60 min',
        category: 'Pitru',
      ),
    ];
  }

  void _loadSpecialEvents() {
    specialEvents.value = [
      SpecialEvent(
        id: '1',
        title: 'Ashtami Shani Amavasya 2025 Special',
        description: 'Join us for special prayers and rituals',
        image: 'https://i.imgur.com/tXyOMMG.png',
        date: DateTime.now().add(Duration(days: 7)),
        location: 'Main Temple',
        isFeatured: true,
      ),
      SpecialEvent(
        id: '2',
        title: 'Sacred Temple Ritual Experience',
        description: 'Experience divine energy in our ceremony',
        image:
            'https://plus.unsplash.com/premium_photo-1698500034742-098f7fc04163',
        date: DateTime.now().add(Duration(days: 14)),
        location: 'Shani Temple',
        isFeatured: true,
      ),
    ];
  }

  void onSearch(String query) => searchQuery.value = query;

  void onServiceTap(PujaService service) {
    Get.snackbar(
      'Service Selected',
      '${service.name} - ₹${service.price.toInt()}',
      backgroundColor: ThemeColors.primaryColor.withOpacity(0.9),
      colorText: ThemeColors.white,
      duration: Duration(seconds: 2),
    );
  }

  void onCategoryTap(ServiceCategory category) {
    Get.snackbar(
      'Category',
      'Exploring ${category.name}',
      backgroundColor: ThemeColors.accentColor.withOpacity(0.9),
      colorText: ThemeColors.white,
    );
  }

  void toggleFavorite(String serviceId) {
    if (favoriteServices.contains(serviceId)) {
      favoriteServices.remove(serviceId);
    } else {
      favoriteServices.add(serviceId);
    }
  }

  bool isFavorite(String serviceId) => favoriteServices.contains(serviceId);

  Future<void> testFunction() async {
    _loadBanner();
  }
}
