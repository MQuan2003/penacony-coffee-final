import 'package:p_cf/controller/category_repository.dart';
import 'package:p_cf/controller/food_repository.dart';
import 'package:p_cf/controller/promotion_repository.dart';
import 'package:p_cf/controller/voucher_repository.dart';

import 'database_helper.dart';

class SampleDataManager {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final CategoryRepository _categoryRepo = CategoryRepository();
  final FoodRepository foodRepo = FoodRepository();

  Future<void> addSampleData() async {
    await _addSampleCategories();
    await _addSampleFoods();
    await _addSamplePromotions();
    await _addSampleVouchers();
  }

  Future<void> _addSampleCategories() async {
    final categories = await _categoryRepo.getAllCategories();
    if (categories.isEmpty) {
      final sampleCategories = [
        Category(id: 1, name: 'Điểm Tâm', icon: 'breakfast_icon.png'),
        Category(id: 2, name: 'Cà Phê', icon: 'coffee_icon.png'),
        Category(id: 3, name: 'Trà Sữa', icon: 'milk_tea_icon.png'),
        Category(id: 4, name: 'Trà', icon: 'tea_icon.png'),
        Category(id: 5, name: 'Bánh', icon: 'cake_icon.png'),
      ];
      for (var category in sampleCategories) {
        await _categoryRepo.insertCategory(category);
      }
    }
  }

  Future<void> _addSampleFoods() async {
    final foods = await foodRepo.getAllFoods();
    if (foods.isEmpty) {
      final sampleFoods = [
        // Menu Điểm Tâm Sáng
        Food(
          id: 1,
          categoryId: 1,
          name: 'Bánh mì ốp la xúc xích',
          price: 30000,
          description:
              'Bánh mì nóng giòn kèm 2 quả trứng ốp la và xúc xích nướng, phục vụ với rau sống và nước sốt đặc biệt.',
          isBestSeller: false,
          image: 'assets/images/breakfast_banhmi_opla.png',
        ),
        Food(
          id: 2,
          categoryId: 1,
          name: 'Bánh mì pate chả lụa',
          price: 25000,
          description:
              'Bánh mì truyền thống Việt Nam với pate, chả lụa, dưa leo và ngò, vị đậm đà quen thuộc.',
          isBestSeller: false,
          image: 'assets/images/breakfast_banhmi_pate.png',
        ),
        Food(
          id: 3,
          categoryId: 1,
          name: 'Xôi gà xé chà bông',
          price: 35000,
          description:
              'Xôi nếp dẻo, gà xé thơm phức, thêm lớp chà bông, phục vụ kèm nước tương.',
          isBestSeller: true,
          image: 'assets/images/breakfast_xoi_ga.png',
        ),
        Food(
          id: 4,
          categoryId: 1,
          name: 'Croissant trứng và phô mai',
          price: 40000,
          description:
              'Bánh sừng trâu mềm thơm kẹp trứng chiên và phô mai tan chảy, nhẹ nhàng và đầy năng lượng.',
          isBestSeller: true,
          image: 'assets/images/breakfast_croissant.png',
        ),
        Food(
          id: 5,
          categoryId: 1,
          name: 'Pancake mật ong trái cây tươi',
          price: 45000,
          description:
              'Pancake mềm xốp, phủ mật ong, dâu tươi hoặc chuối lát, mang đến bữa sáng nhẹ nhàng.',
          isBestSeller: false,
          image: 'assets/images/breakfast_pancake.png',
        ),
        Food(
          id: 6,
          categoryId: 1,
          name: 'Nui xào bò',
          price: 50000,
          description:
              'Nui mềm xào cùng bò tươi và rau củ, đậm vị, thích hợp cho bữa sáng ấm bụng.',
          isBestSeller: false,
          image: 'assets/images/breakfast_nui_xao_bo.png',
        ),
        Food(
          id: 7,
          categoryId: 1,
          name: 'Salad rau củ trứng luộc',
          price: 30000,
          description:
              'Rau tươi giòn, trứng luộc, sốt mayonnaise hoặc dầu giấm, phù hợp với thực khách ăn nhẹ.',
          isBestSeller: false,
          image: 'assets/images/breakfast_salad.png',
        ),
        Food(
          id: 8,
          categoryId: 1,
          name: 'Yogurt trái cây mix granola',
          price: 35000,
          description:
              'Yogurt dẻo kèm trái cây tươi (chuối, dâu, kiwi) và granola giòn tan, tốt cho sức khỏe.',
          isBestSeller: true,
          image: 'assets/images/breakfast_yogurt.png',
        ),
        Food(
          id: 9,
          categoryId: 1,
          name: 'Xíu mại bánh mì',
          price: 40000,
          description:
              'Xíu mại nóng hổi kèm nước sốt cà chua đậm vị, ăn cùng bánh mì giòn.',
          isBestSeller: false,
          image: 'assets/images/breakfast_xiu_mai.png',
        ),

        // Menu Cà Phê
        Food(
          id: 10,
          categoryId: 2,
          name: 'Cà phê đen (Đá/ Nóng)',
          price: 25000,
          description:
              'Hương vị cà phê nguyên chất, đậm đà, dành cho những người yêu thích sự truyền thống.',
          isBestSeller: true,
          image: 'assets/images/coffee_black.png',
        ),
        Food(
          id: 11,
          categoryId: 2,
          name: 'Cà phê sữa (Đá/ Nóng)',
          price: 30000,
          description:
              'Kết hợp hoàn hảo giữa vị đắng của cà phê và vị ngọt béo của sữa đặc, quen thuộc và dễ uống.',
          isBestSeller: true,
          image: 'assets/images/coffee_milk.png',
        ),
        Food(
          id: 12,
          categoryId: 2,
          name: 'Espresso',
          price: 30000,
          description:
              'Một shot cà phê đậm đặc, thơm mạnh mẽ, dành cho những ai cần năng lượng nhanh chóng.',
          isBestSeller: false,
          image: 'assets/images/coffee_espresso.png',
        ),
        Food(
          id: 13,
          categoryId: 2,
          name: 'Americano',
          price: 35000,
          description:
              'Espresso pha loãng với nước nóng, hương vị nhẹ hơn, phù hợp với thực khách thích thưởng thức cà phê chậm rãi.',
          isBestSeller: false,
          image: 'assets/images/coffee_americano.png',
        ),
        Food(
          id: 14,
          categoryId: 2,
          name: 'Cappuccino',
          price: 40000,
          description:
              'Sự kết hợp của espresso, sữa nóng và lớp bọt sữa mịn màng, thường được trang trí với bột cacao hoặc latte art.',
          isBestSeller: true,
          image: 'assets/images/coffee_cappuccino.png',
        ),
        Food(
          id: 15,
          categoryId: 2,
          name: 'Latte',
          price: 40000,
          description:
              'Espresso pha cùng sữa nóng và một chút bọt sữa, vị cà phê nhẹ nhàng, thích hợp với những người mới bắt đầu.',
          isBestSeller: false,
          image: 'assets/images/coffee_latte.png',
        ),

        // Menu Trà Sữa
        Food(
          id: 16,
          categoryId: 3,
          name: 'Trà sữa trân châu đường đen',
          price: 45000,
          description:
              'Trà sữa đậm vị với sữa tươi và đường đen caramel, kèm trân châu dẻo dai.',
          isBestSeller: true,
          image: 'assets/images/milk_tea_black_sugar.png',
        ),
        Food(
          id: 17,
          categoryId: 3,
          name: 'Trà sữa matcha',
          price: 50000,
          description:
              'Matcha Nhật Bản nguyên chất kết hợp sữa tươi, thơm ngon, thanh mát.',
          isBestSeller: false,
          image: 'assets/images/milk_tea_matcha.png',
        ),
        Food(
          id: 18,
          categoryId: 3,
          name: 'Trà sữa hồng trà',
          price: 40000,
          description:
              'Hồng trà thơm nồng kết hợp sữa tươi, phù hợp với khẩu vị cổ điển.',
          isBestSeller: false,
          image: 'assets/images/milk_tea_red.png',
        ),
        Food(
          id: 19,
          categoryId: 3,
          name: 'Trà sữa socola',
          price: 45000,
          description:
              'Sữa tươi pha với cacao đậm đặc, kết hợp cùng trân châu hoặc thạch, thích hợp cho người thích vị ngọt béo.',
          isBestSeller: true,
          image: 'assets/images/milk_tea_chocolate.png',
        ),

        // Menu Trà
        Food(
          id: 20,
          categoryId: 4,
          name: 'Trà đào cam sả',
          price: 35000,
          description:
              'Hồng trà pha với cam tươi, đào ngâm và chút sả thơm, mát lành, dễ uống.',
          isBestSeller: true,
          image: 'assets/images/tea_peach.png',
        ),
        Food(
          id: 21,
          categoryId: 4,
          name: 'Trà dâu tây chanh sả',
          price: 36000,
          description:
              'Trà thanh nhẹ, kết hợp vị ngọt của dâu tây tươi và chút chua nhẹ từ chanh.',
          isBestSeller: false,
          image: 'assets/images/tea_strawberry_lemon.png',
        ),
        Food(
          id: 22,
          categoryId: 4,
          name: 'Trà táo bạc hà',
          price: 37000,
          description:
              'Trà xanh pha cùng táo tươi và bạc hà, mang đến cảm giác tươi mát và sảng khoái.',
          isBestSeller: false,
          image: 'assets/images/tea_apple_mint.png',
        ),
        Food(
          id: 23,
          categoryId: 4,
          name: 'Trà hoa nhài mật ong',
          price: 35000,
          description:
              'Trà xanh nhài dịu nhẹ, thêm mật ong ngọt tự nhiên, phù hợp với những người thích vị thanh nhẹ.',
          isBestSeller: true,
          image: 'assets/images/tea_jasmine_honey.png',
        ),
        Food(
          id: 24,
          categoryId: 4,
          name: 'Trà chanh dây nhiệt đới',
          price: 38000,
          description:
              'Hồng trà hòa quyện với nước chanh dây, mang đến hương vị nhiệt đới sảng khoái.',
          isBestSeller: true,
          image: 'assets/images/tea_passionfruit.png',
        ),
        Food(
          id: 25,
          categoryId: 4,
          name: 'Trà việt quất',
          price: 38000,
          description:
              'Trà đen pha cùng việt quất tươi, vị ngọt chua hài hòa, rất hấp dẫn và bổ dưỡng.',
          isBestSeller: false,
          image: 'assets/images/tea_blueberry.png',
        ),

        // Menu Bánh
        Food(
          id: 26,
          categoryId: 5,
          name: 'Bánh tiramisu',
          price: 50000,
          description:
              'Lớp bánh ladyfinger mềm mịn xen lẫn kem mascarpone béo ngậy, phủ cacao, thơm vị cà phê.',
          isBestSeller: true,
          image: 'assets/images/cake_tiramisu.png',
        ),
        Food(
          id: 27,
          categoryId: 5,
          name: 'Croissant (Bánh sừng trâu)',
          price: 30000,
          description:
              'Bánh bơ mềm thơm, có lớp vỏ giòn tan, phù hợp với cà phê hoặc trà.',
          isBestSeller: false,
          image: 'assets/images/cake_croissant.png',
        ),
        Food(
          id: 28,
          categoryId: 5,
          name: 'Muffin chocolate',
          price: 35000,
          description:
              'Bánh muffin mềm mịn, vị socola đậm đà, thích hợp cho bữa sáng hoặc ăn nhẹ.',
          isBestSeller: true,
          image: 'assets/images/cake_muffin_chocolate.png',
        ),
        Food(
          id: 29,
          categoryId: 5,
          name: 'Bánh phô mai (Cheesecake)',
          price: 45000,
          description:
              'Bánh phô mai mịn màng, vị chua nhẹ của cream cheese hòa quyện với đế bánh giòn.',
          isBestSeller: true,
          image: 'assets/images/cake_cheesecake.png',
        ),
        Food(
          id: 30,
          categoryId: 5,
          name: 'Bánh chuối nướng',
          price: 28000,
          description:
              'Bánh chuối truyền thống Việt Nam, thơm lừng, mềm và ngọt nhẹ.',
          isBestSeller: false,
          image: 'assets/images/cake_banana.png',
        ),
        Food(
          id: 31,
          categoryId: 5,
          name: 'Bánh tart trứng',
          price: 30000,
          description:
              'Đế bánh giòn kết hợp nhân kem trứng mềm béo, tan ngay trong miệng.',
          isBestSeller: true,
          image: 'assets/images/cake_egg_tart.png',
        ),
        Food(
          id: 32,
          categoryId: 5,
          name: 'Bánh su kem',
          price: 20000,
          description:
              'Vỏ bánh mềm mịn, nhân kem vani ngọt ngào, rất dễ ăn và phổ biến.',
          isBestSeller: false,
          image: 'assets/images/cake_cream_puff.png',
        ),
      ];

      for (var food in sampleFoods) {
        await foodRepo.insertFood(food);
      }
    }
  }

  Future<void> _addSamplePromotions() async {
    final repo = PromotionRepository();
    final promotions = await repo.getPromotions();
    if (promotions.isEmpty) {
      final samplePromotions = [
        Promotion(
          id: 1,
          title: 'Giảm Giá 20% Toàn Bộ Cà Phê',
          description:
              'Đừng bỏ lỡ cơ hội thưởng thức cà phê yêu thích với ưu đãi giảm giá 20%! Áp dụng cho tất cả các loại cà phê từ 01/12 đến 31/12/2024.',
          image: 'assets/images/promo1.webp',
          startDate: '2024-12-01',
          endDate: '2024-12-31',
        ),
        Promotion(
          id: 2,
          title: 'Mua 1 Latte, Tặng 1 Latte',
          description:
              'Thỏa mãn vị giác với ưu đãi đặc biệt: Mua 1 cốc latte bất kỳ, nhận thêm 1 cốc miễn phí. Áp dụng từ 10/12 đến 25/12/2024.',
          image: 'assets/images/promo2.webp',
          startDate: '2024-12-10',
          endDate: '2024-12-25',
        ),
        Promotion(
          id: 3,
          title: 'Combo Điểm Tâm Năng Lượng',
          description:
              'Combo bánh mì ốp la xúc xích và cà phê sữa đá chỉ với ưu đãi 15%. Thưởng thức bữa sáng ngon lành và tiết kiệm!',
          image: 'assets/images/promo3.webp',
          startDate: '2024-12-05',
          endDate: '2024-12-20',
        ),
        Promotion(
          id: 4,
          title: 'Giảm giá 10% món ăn trưa',
          description:
              'Nhận ngay ưu đãi giảm 10% cho tất cả các món ăn trưa từ 11:00 - 14:00 hàng ngày. Hãy đến và thưởng thức ngay!',
          image: 'assets/images/promo4.webp',
          startDate: '2024-12-01',
          endDate: '2024-12-31',
        ),
        Promotion(
          id: 5,
          title: 'Giảm 10% Cho Món Trà Sữa',
          description:
              'Ưu đãi giảm giá 10% cho tất cả các món trà sữa. Thích hợp để thưởng thức cùng bạn bè hoặc một mình. Áp dụng từ 01/12 đến 15/12/2024.',
          image: 'assets/images/promo5.webp',
          startDate: '2024-12-01',
          endDate: '2024-12-15',
        ),
        // Promotion(
        //   id: 6,
        //   title: 'Tặng 1 Ly Trà Đào Cho Hóa Đơn Trên 100K',
        //   description:
        //       'Nhận ngay 1 ly trà đào cam sả miễn phí khi hóa đơn đạt từ 100,000đ. Ưu đãi áp dụng từ 01/12 đến 20/12/2024.',
        //   image: 'assets/images/promo6.webp',
        //   startDate: '2024-12-01',
        //   endDate: '2024-12-20',
        // ),
      ];
      for (var promotion in samplePromotions) {
        await repo.insertPromotion(promotion);
      }
    }
  }

  Future<void> _addSampleVouchers() async {
  final db = await _dbHelper.database;
  final existingVouchers = await db.query('voucher');
  if (existingVouchers.isEmpty) {
    final sampleVouchers = [
      Voucher(
        id: 1,
        title: 'Giảm giá 10% toàn bộ menu',
        description: 'Voucher giảm giá 10% áp dụng cho toàn bộ thực đơn.',
        image: 'assets/images/voucher_discount_10.png',
        requiredPoint: 100,
        endDate: '2024-12-31',
      ),
      Voucher(
        id: 2,
        title: 'Giảm giá 20% cho các món cà phê',
        description: 'Thưởng thức cà phê yêu thích với ưu đãi giảm giá 20%.',
        image: 'assets/images/voucher_discount_20.png',
        requiredPoint: 200,
        endDate: '2024-12-25',
      ),
      Voucher(
        id: 3,
        title: 'Miễn phí 1 món bánh khi mua trên 100K',
        description: 'Áp dụng cho hóa đơn từ 100,000 đồng trở lên.',
        image: 'assets/images/voucher_free_cake.png',
        requiredPoint: 150,
        endDate: '2024-12-31',
      ),
      Voucher(
        id: 4,
        title: 'Tặng 1 Latte khi mua bất kỳ món nào',
        description: 'Khuyến mãi áp dụng đến hết ngày 20/12/2024.',
        image: 'assets/images/voucher_free_latte.png',
        requiredPoint: 180,
        endDate:'2024-12-20',
      ),
      Voucher(
        id: 5,
        title: 'Giảm giá 50% cho lần đầu đăng ký thành viên',
        description: 'Ưu đãi độc quyền cho thành viên mới.',
        image: 'assets/images/voucher_discount_50.png',
        requiredPoint: 300,
        endDate:'2024-12-31',
      ),
    ];

    for (var voucher in sampleVouchers) {
      await db.insert('voucher', voucher.toMap());
    }
  }
}


}
