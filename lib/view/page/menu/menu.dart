import 'package:flutter/material.dart';
import 'package:p_cf/model/database_helper.dart';
import 'package:p_cf/view/page/menu/detail_food.dart';
import 'package:p_cf/view/search/search.dart';
import 'package:p_cf/widgets/bottomNavigationBar.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> categoryKeys = {};
  List<String> categories = [];
  Map<String, List<Map<String, dynamic>>> foods = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final db = await DatabaseHelper().database;
      final categoryResults = await db.query('categories');
      final foodResults = await db.query('foods');

      if (categoryResults.isEmpty || foodResults.isEmpty) {
        throw Exception("No data found in the database.");
      }

      categories = categoryResults.map((row) => row['name'] as String).toList();
      
      foods = {
        for (var category in categories)
          category: foodResults
              .where((food) =>
                  food['category_id'] ==
                  categoryResults.firstWhere(
                      (cat) => cat['name'] == category)['category_id'])
              .map((food) => {
                    'id': food['food_id'],
                    'name': food['name'],
                    'price': food['price'],
                    'image': food['image'],
                    'description': food['description']
                  })
              .toList(),
      };

      for (var category in categories) {
        categoryKeys[category] = GlobalKey();
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void scrollToCategory(String category) {
    final keyContext = categoryKeys[category]?.currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildFoodTile(Map<String, dynamic> food) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: food['image'] != null && food['image'].toString().isNotEmpty
            ? Image.asset(
                food['image'],
                width: 60,
                height: 60,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 60, color: Colors.grey);
                },
              )
            : Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Center(child: Icon(Icons.fastfood)),
              ),
        

        title: Text(
          food['name'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '\$${food['price']}',
          style: const TextStyle(color: Colors.grey),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodDetailScreen(
                food: food,
                previousPageTitle: 'Chi tiết món ăn',
                
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // Nội dung menu
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.only(top: 160.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: categories.map((category) {
                return Column(
                  key: categoryKeys[category],
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        category,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: foods[category]?.length ?? 0,
                      itemBuilder: (context, index) {
                        var food = foods[category]![index];
                        return _buildFoodTile(food);
                      },
                    ),
                  ],
                );
              }).toList(),
            ),
          ),

          // Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Menu',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SearchPage()),
                                );
                              },
                            ),
                          ],
                        )
                      ]),
                  SizedBox(
                    height: 95,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            scrollToCategory(categories[index]);
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child:
                                    const Center(child: Icon(Icons.fastfood)),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                categories[index],
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.center, // Căn giữa
                                maxLines: 2, // Giới hạn 2 dòng
                                overflow: TextOverflow
                                    .ellipsis, // Thêm "..." nếu vượt quá
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 1),
    );
  }
}
