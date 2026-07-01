import 'dart:developer';

import 'package:coupon/model/store_model/store_model.dart';
import 'package:coupon/widget/app_colore_part.dart';
import 'package:coupon/widget/app_label.dart';
import 'package:flutter/material.dart';

class PromotionsStoreDetail extends StatefulWidget {
  const PromotionsStoreDetail({super.key});

  @override
  State<PromotionsStoreDetail> createState() => _PromotionsStoreDetailState();
}

class _PromotionsStoreDetailState extends State<PromotionsStoreDetail> {
  late PromotionsStoreDetailModel promotionsStoreDetailModel;

  @override
  void initState() {
    super.initState();

    // 👉 replace with API later
    promotionsStoreDetailModel = promotionData;
    log("PromotionsStoreDetailModel: ${promotionsStoreDetailModel.toJson()}");
  }

  @override
  Widget build(BuildContext context) {
    log("PromotionsStoreDetailModel: ${promotionsStoreDetailModel.toJson()}");
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          /// ================= APP BAR =================
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: AppColorsPath.backgroundColor,
            elevation: 0,
            leading: Container(
              margin: EdgeInsets.all(8),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColorsPath.white.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColorsPath.black.withValues(alpha: 0.8),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    promotionsStoreDetailModel.bannerImage,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          AppColorsPath.black.withValues(alpha: 0.6),
                          AppColorsPath.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// ================= STORE LIST =================
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final store = promotionsStoreDetailModel.stores[index];
              return _buildStoreSection(store);
            }, childCount: promotionsStoreDetailModel.stores.length),
          ),
        ],
      ),
    );
  }

  /// ================= STORE SECTION =================
  Widget _buildStoreSection(PromotionStoreModel store) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: AppColorsPath.backgroundColor,
      child: Column(
        children: [
          /// ================= STORE HEADER =================
          CardStoreWidget(
            image: store.storeLogo,
            name: store.storeName,
            promotionText: store.promotionText,
            rating: store.rating,
            deliveryFee: "${store.deliveryFee}",
            deliveryTime: store.deliveryTime,
          ),

          const SizedBox(height: 12),

          /// ================= ITEM LIST =================
          SizedBox(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: store.items.length,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemBuilder: (context, index) {
                final item = store.items[index];

                return CardProductStoreWidget(
                  image: item.image,
                  name: item.itemName,
                  price: "${item.price}",
                  originalPrice: "${item.originalPrice}",
                  discountText: item.discountText,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CardProductStoreWidget extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String originalPrice;
  final String discountText;

  const CardProductStoreWidget({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.discountText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 115,
      margin: EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image,
                  height: 115,
                  width: 115,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                bottom: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                    color: AppColorsPath.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: AppLabel(
                    text: discountText,
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          /// NAME
          AppLabel(
            text: name,
            fontSize: 12,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 2),

          /// PRICE
          Row(
            children: [
              AppLabel(
                text: "\$$price",
                fontWeight: FontWeight.bold,
                color: AppColorsPath.black,
                fontSize: 12,
              ),
              const SizedBox(width: 4),
              AppLabel(
                text: "\$$originalPrice",
                fontSize: 10,
                color: AppColorsPath.red,
                textDecoration: TextDecoration.lineThrough,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CardStoreWidget extends StatelessWidget {
  final String image;
  final String name;
  final String promotionText;
  final double rating;
  final String deliveryFee;
  final String deliveryTime;

  const CardStoreWidget({
    super.key,
    required this.image,
    required this.name,
    required this.promotionText,
    required this.rating,
    required this.deliveryFee,
    required this.deliveryTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColorsPath.greyE0E0E0,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: AppColorsPath.greyE0E0E0.withValues(alpha: 0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(color: AppColorsPath.greyE0E0E0, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: Image.network(
                image,
                width: 52,
                height: 52,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppLabel(text: name, fontSize: 16, fontWeight: FontWeight.bold),
                const SizedBox(height: 4),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColorsPath.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: AppLabel(
                    text: promotionText,
                    fontSize: 11,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(
                      Icons.star_border,
                      size: 14,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 4),
                    AppLabel(
                      text: rating.toString(),
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 10),
                    AppLabel(
                      text: "\$${deliveryFee}",
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 10),
                    AppLabel(
                      text: deliveryTime,
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
