import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:p_cf/database/repository/food_repository.dart';
import 'package:p_cf/database/repository/promotion_repository.dart';
import 'package:p_cf/screens/page/menu/detail_food.dart';
import 'package:p_cf/screens/page/promotion/detail_promotion_screen.dart';
import 'package:p_cf/screens/search/search.dart';
import 'package:p_cf/widgets/bottomNavigationBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PromotionRepository promotionRepository = PromotionRepository();
  List<Promotion> promotions = [];
  final FoodRepository foodRepository = FoodRepository();
  List<Map<String, dynamic>> bestSellerFoods = [];
  //List<Food> bestSellers = [];

  @override
  void initState() {
    super.initState();
    _loadPromotions();
    _loadBestSellers();
  }

  Future<void> _loadPromotions() async {
    final loadedPromotions = await promotionRepository.getPromotions();
    setState(() {
      promotions = loadedPromotions;
    });
  }

  Future<void> _loadBestSellers() async {
  try {
    final loadedBestSellers = await foodRepository.getBestSellers();
    print('Loaded Best Sellers from DB: $loadedBestSellers'); // Debug line

    final parsedBestSellers = loadedBestSellers
        .map((data) => Food.fromMap(data as Map<String, dynamic>))
        .toList();

    print('Parsed Best Sellers: $parsedBestSellers'); // Debug line
    setState(() {
      bestSellerFoods = parsedBestSellers.cast<Map<String, dynamic>>(); // Lưu trực tiếp danh sách Food
    });
  } catch (e) {
    print("Lỗi khi tải danh sách Best Seller: $e");
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 75.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 30,
                          child:
                              Icon(Icons.person, size: 30, color: Colors.white),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Chào mừng bạn trở lại',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'N L D M Q',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SearchPage()),
                            );
                          },
                          child: const Icon(Icons.search,
                              size: 28, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                // Carousel hiển thị khuyến mãi
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Các khuyến mãi hấp dẫn',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8.0),
                promotions.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : CarouselSlider(
                        items: promotions.map((promotion) {
                          return GestureDetector(
                            onTap: () {
                              // Điều hướng đến trang chi tiết
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPromotionScreen(
                                    title: promotion.title,
                                    description: promotion.description,
                                    expiration: promotion.endDate,
                                    image: promotion.image,
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    image: DecorationImage(
                                      image: AssetImage(promotion.image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.6),
                                        Colors.transparent,
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Text(
                                    promotion.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 200.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                        ),
                      ),
                // Phần Best Seller
                const SizedBox(height: 14.0),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Best Seller',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8.0),
                _buildBestSellerSection(bestSellerFoods.cast<Food>()),
              ],
            ),
          ),
          // Phần tiêu đề cố định
          Container(
            height: 90.0,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF009688), Color(0xFF004D40)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                'Penacony Coffee',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}

// Phần hiển thị danh sách Best Seller
Widget _buildBestSellerSection(List<Food> bestSellers) {
  if (bestSellers.isEmpty) {
    return const Center(
      child: Text(
        'Hiện tại chưa có món ăn nào trong danh sách Best Seller.',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
  return SizedBox(
    height: 140,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: bestSellers.length,
      itemBuilder: (context, index) {
        final food = bestSellers[index]; // Đây là đối tượng Food
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodDetailScreen(
                  food: {
                    'name': food.name,
                    'image': food.image,
                    'price': food.price,
                    'description': food.description,
                  },
                ),
              ),
            );
          },
          child: Container(
            width: 140,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                image: food.image != null
                    ? NetworkImage(food.image!)
                    : const AssetImage('assets/images/default_food.png')
                        as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  food.name, // Đảm bảo thuộc tính name được hiển thị
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
