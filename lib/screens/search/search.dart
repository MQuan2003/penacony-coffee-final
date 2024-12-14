import 'package:flutter/material.dart';
import 'package:p_cf/database/repository/food_repository.dart';
import 'package:p_cf/screens/page/menu/detail_food.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final FoodRepository _foodRepo = FoodRepository();
  List<Food> _searchResults = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  Future<void> _performSearch(String keyword) async {
    if (keyword.isEmpty) return; // Không tìm nếu không có từ khoá

    setState(() {
      _isLoading = true;
    });

    try {
      final results = await _foodRepo.searchFoods(keyword);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      // Xử lý lỗi nếu xảy ra
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã xảy ra lỗi: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm kiếm món ăn'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Nhập tên món ăn...',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _performSearch(_searchController.text);
                  },
                ),
              ),
              onSubmitted: (value) {
                _performSearch(value);
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _searchResults.isNotEmpty
                    ? ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final food = _searchResults[index];
                          return ListTile(
                            leading: _buildFoodImage(food.image),
                            title: Text(food.name),
                            subtitle:
                                Text('${food.price.toStringAsFixed(0)} VNĐ'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FoodDetailScreen(
                                    food: {
                                      'name': food.name,
                                      'price': food.price,
                                      'image': food.image,
                                      'description': food.description,
                                    },
                                    previousPageTitle: 'Tìm kiếm',
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : const Center(
                        child: Text('Không tìm thấy món ăn nào.'),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodImage(String imagePath) {
    return Image.asset(
      imagePath,
      width: 60,
      height: 60,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.broken_image, size: 50),
    );
  }
}
