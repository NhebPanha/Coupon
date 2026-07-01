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
          Padding(
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
                    border: Border.all(
                      color: AppColorsPath.greyE0E0E0,
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Image.network(
                      store.storeLogo,
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
                      AppLabel(
                        text: store.storeName,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                          text: store.promotionText,
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
                            text: store.rating.toString(),
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 10),
                          AppLabel(
                            text: "\$${store.deliveryFee}",
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 10),
                          AppLabel(
                            text: store.deliveryTime,
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

                return Container(
                  width: 110,
                  margin: const EdgeInsets.only(right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// IMAGE
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item.image,
                              height: 110,
                              width: 110,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Positioned(
                            left: 4,
                            bottom: 4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColorsPath.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: AppLabel(
                                text: item.discountText,
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      /// NAME
                      AppLabel(
                        text: item.itemName,
                        fontSize: 12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 2),

                      /// PRICE
                      Row(
                        children: [
                          AppLabel(
                            text: "\$${item.price}",
                            fontWeight: FontWeight.bold,
                            color: AppColorsPath.black,
                            fontSize: 12,
                          ),
                          const SizedBox(width: 4),
                          AppLabel(
                            text: "\$${item.originalPrice}",
                            fontSize: 10,
                            color: AppColorsPath.red,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
