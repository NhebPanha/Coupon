class PromotionsStoreDetailModel {
  final String bannerImage;
  final List<PromotionStoreModel> stores;

  PromotionsStoreDetailModel({required this.bannerImage, required this.stores});

  factory PromotionsStoreDetailModel.fromJson(Map<String, dynamic> json) {
    return PromotionsStoreDetailModel(
      bannerImage: json['banner_image'] ?? '',
      stores:
          (json['stores'] as List?)
              ?.map((e) => PromotionStoreModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'banner_image': bannerImage,
      'stores': stores.map((e) => e.toJson()).toList(),
    };
  }
}

class PromotionStoreModel {
  final String storeId;
  final String storeName;
  final String storeLogo;
  final String promotionText;
  final double rating;
  final double deliveryFee;
  final String deliveryTime;
  final List<PromotionItemModel> items;

  PromotionStoreModel({
    required this.storeId,
    required this.storeName,
    required this.storeLogo,
    required this.promotionText,
    required this.rating,
    required this.deliveryFee,
    required this.deliveryTime,
    required this.items,
  });

  factory PromotionStoreModel.fromJson(Map<String, dynamic> json) {
    return PromotionStoreModel(
      storeId: json['store_id'] ?? '',
      storeName: json['store_name'] ?? '',
      storeLogo: json['store_logo'] ?? '',
      promotionText: json['promotion_text'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      deliveryFee: (json['delivery_fee'] ?? 0).toDouble(),
      deliveryTime: json['delivery_time'] ?? '',
      items:
          (json['items'] as List?)
              ?.map((e) => PromotionItemModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'store_id': storeId,
      'store_name': storeName,
      'store_logo': storeLogo,
      'promotion_text': promotionText,
      'rating': rating,
      'delivery_fee': deliveryFee,
      'delivery_time': deliveryTime,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}

class PromotionItemModel {
  final String itemId;
  final String itemName;
  final String image;
  final double price;
  final double originalPrice;
  final String discountText;

  PromotionItemModel({
    required this.itemId,
    required this.itemName,
    required this.image,
    required this.price,
    required this.originalPrice,
    required this.discountText,
  });

  factory PromotionItemModel.fromJson(Map<String, dynamic> json) {
    return PromotionItemModel(
      itemId: json['item_id'] ?? '',
      itemName: json['item_name'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: (json['original_price'] ?? 0).toDouble(),
      discountText: json['discount_text'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'item_name': itemName,
      'image': image,
      'price': price,
      'original_price': originalPrice,
      'discount_text': discountText,
    };
  }
}

final PromotionsStoreDetailModel promotionData = PromotionsStoreDetailModel(
  bannerImage:
      "https://cdn.vegkit.com/wp-content/uploads/sites/2/2022/09/18161257/poke-bowl-by-almond-lane.jpg",
  stores: [
    PromotionStoreModel(
      storeId: "1",
      storeName: "Pizza Hut",
      storeLogo:
          "https://static.wixstatic.com/media/22e53e_6818890490334e429d78876ba5f757ce~mv2.jpg/v1/fill/w_480,h_480,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/22e53e_6818890490334e429d78876ba5f757ce~mv2.jpg",
      promotionText: "Up to 50% Off on Selected Items",
      rating: 4.9,
      deliveryFee: 0.75,
      deliveryTime: "15 min",
      items: [
        PromotionItemModel(
          itemId: "1",
          itemName: "Cheese Pizza",
          image:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQl_djceCbzqFVLT5qLOZJTIcJli0-PyQkbpHYOkyDyI50DPaSGVVRtHVI&s=10",
          price: 10,
          originalPrice: 12,
          discountText: "2.00\$ OFF",
        ),
        PromotionItemModel(
          itemId: "2",
          itemName: "Pepperoni Pizza",
          image:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbv9ey20XlmW5qwO9SAWEURbyb2hlYgIhxhuYBsE6Gv4f70kKqmoUAymo&s=10",
          price: 12,
          originalPrice: 15,
          discountText: "3.00\$ OFF",
        ),
        PromotionItemModel(
          itemId: "3",
          itemName: "Hawaiian Pizza",
          image:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-NSweZQRKFgU63dO-wzBSVNIeFZ3WIBqmoLp3jLpBr7itHn_3-QF7qVRA&s=10",
          price: 11,
          originalPrice: 14,
          discountText: "3.00\$ OFF",
        ),
      ],
    ),

    PromotionStoreModel(
      storeId: "2",
      storeName: "Burger King Style",
      storeLogo:
          "https://static.vecteezy.com/system/resources/thumbnails/070/256/211/small/person-capturing-a-delicious-dish-at-a-modern-restaurant-during-brunch-time-photo.jpeg",
      promotionText: "Buy 1 Get 1 Free",
      rating: 4.7,
      deliveryFee: 1.25,
      deliveryTime: "20 min",
      items: [
        PromotionItemModel(
          itemId: "4",
          itemName: "Cheese Burger",
          image:
              "https://img.freepik.com/free-photo/close-up-delicious-seaweed-dish_23-2150912636.jpg?semt=ais_hybrid&w=740&q=80",
          price: 6,
          originalPrice: 8,
          discountText: "2.00\$ OFF",
        ),
        PromotionItemModel(
          itemId: "5",
          itemName: "Double Burger",
          image:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPRx_eDo6TenQMttPYdKgvFmQ0V2KolO3kuQjg9rCKQQ&s",
          price: 8,
          originalPrice: 11,
          discountText: "3.00\$ OFF",
        ),
      ],
    ),

    PromotionStoreModel(
      storeId: "3",
      storeName: "Coffee House",
      storeLogo:
          "https://cdn.vegkit.com/wp-content/uploads/sites/2/2022/09/18161257/poke-bowl-by-almond-lane.jpg",
      promotionText: "Free Delivery",
      rating: 4.8,
      deliveryFee: 0,
      deliveryTime: "10 min",
      items: [
        PromotionItemModel(
          itemId: "6",
          itemName: "Iced Latte",
          image:
              "https://thumbs.dreamstime.com/b/ayam-penyet-set-indonesian-cuisine-fried-chicken-dish-consisting-fried-chicken-served-sambal-slices-66006757.jpg",
          price: 3.5,
          originalPrice: 5,
          discountText: "1.5\$ OFF",
        ),
        PromotionItemModel(
          itemId: "7",
          itemName: "Cappuccino",
          image:
              "https://www.cheffaro.com/wp-content/uploads/2022/02/cheffaro_ayam-penyet-1.jpg",
          price: 3,
          originalPrice: 4.5,
          discountText: "1.5\$ OFF",
        ),
        PromotionItemModel(
          itemId: "8",
          itemName: "Espresso",
          image:
              "https://d2e5ushqwiltxm.cloudfront.net/wp-content/uploads/sites/166/2024/09/11075045/anna-pelzer-IGfIGP5ONV0-unsplash.jpg",
          price: 2,
          originalPrice: 3,
          discountText: "1\$ OFF",
        ),
        PromotionItemModel(
          itemId: "6",
          itemName: "Iced Latte",
          image:
              "https://thumbs.dreamstime.com/b/ayam-penyet-set-indonesian-cuisine-fried-chicken-dish-consisting-fried-chicken-served-sambal-slices-66006757.jpg",
          price: 3.5,
          originalPrice: 5,
          discountText: "1.5\$ OFF",
        ),
        PromotionItemModel(
          itemId: "7",
          itemName: "Cappuccino",
          image:
              "https://www.cheffaro.com/wp-content/uploads/2022/02/cheffaro_ayam-penyet-1.jpg",
          price: 3,
          originalPrice: 4.5,
          discountText: "1.5\$ OFF",
        ),
        PromotionItemModel(
          itemId: "8",
          itemName: "Espresso",
          image:
              "https://d2e5ushqwiltxm.cloudfront.net/wp-content/uploads/sites/166/2024/09/11075045/anna-pelzer-IGfIGP5ONV0-unsplash.jpg",
          price: 2,
          originalPrice: 3,
          discountText: "1\$ OFF",
        ),
      ],
    ),

    PromotionStoreModel(
      storeId: "3",
      storeName: "Coffee House",
      storeLogo:
          "https://cdn.vegkit.com/wp-content/uploads/sites/2/2022/09/18161257/poke-bowl-by-almond-lane.jpg",
      promotionText: "Free Delivery",
      rating: 4.8,
      deliveryFee: 0,
      deliveryTime: "10 min",
      items: [
        PromotionItemModel(
          itemId: "6",
          itemName: "Iced Latte",
          image:
              "https://thumbs.dreamstime.com/b/ayam-penyet-set-indonesian-cuisine-fried-chicken-dish-consisting-fried-chicken-served-sambal-slices-66006757.jpg",
          price: 3.5,
          originalPrice: 5,
          discountText: "1.5\$ OFF",
        ),
        PromotionItemModel(
          itemId: "7",
          itemName: "Cappuccino",
          image:
              "https://www.cheffaro.com/wp-content/uploads/2022/02/cheffaro_ayam-penyet-1.jpg",
          price: 3,
          originalPrice: 4.5,
          discountText: "1.5\$ OFF",
        ),
        PromotionItemModel(
          itemId: "8",
          itemName: "Espresso",
          image:
              "https://d2e5ushqwiltxm.cloudfront.net/wp-content/uploads/sites/166/2024/09/11075045/anna-pelzer-IGfIGP5ONV0-unsplash.jpg",
          price: 2,
          originalPrice: 3,
          discountText: "1\$ OFF",
        ),
        PromotionItemModel(
          itemId: "6",
          itemName: "Iced Latte",
          image:
              "https://thumbs.dreamstime.com/b/ayam-penyet-set-indonesian-cuisine-fried-chicken-dish-consisting-fried-chicken-served-sambal-slices-66006757.jpg",
          price: 3.5,
          originalPrice: 5,
          discountText: "1.5\$ OFF",
        ),
        PromotionItemModel(
          itemId: "7",
          itemName: "Cappuccino",
          image:
              "https://www.cheffaro.com/wp-content/uploads/2022/02/cheffaro_ayam-penyet-1.jpg",
          price: 3,
          originalPrice: 4.5,
          discountText: "1.5\$ OFF",
        ),
        PromotionItemModel(
          itemId: "8",
          itemName: "Espresso",
          image:
              "https://d2e5ushqwiltxm.cloudfront.net/wp-content/uploads/sites/166/2024/09/11075045/anna-pelzer-IGfIGP5ONV0-unsplash.jpg",
          price: 2,
          originalPrice: 3,
          discountText: "1\$ OFF",
        ),
      ],
    ),
  ],
);
