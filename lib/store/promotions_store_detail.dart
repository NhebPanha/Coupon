import 'dart:developer';

import 'package:coupon/buttom_sheet/product_buttom_sheet.dart';
import 'package:coupon/model/store_model/store_model.dart';
import 'package:coupon/widget/app_colore_part.dart';
import 'package:coupon/widget/app_font_size.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          /// bloc for app bar with banner image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: AppColorsPath.backgroundColor,
            elevation: 0,
            leading: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return ProductMenuScreen();
                  },
                );
              },
              child: Container(
                margin: EdgeInsets.all(8),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColorsPath.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColorsPath.white.withValues(alpha: 0.8),
                  ),
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
                    height: 228,
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

          /// bloc for store list with items
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

  /// bloc for store section with items
  Widget _buildStoreSection(PromotionStoreModel store) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(vertical: 12),
      color: AppColorsPath.backgroundColor,
      child: Column(
        children: [
          /// bloc for store details
          CardStoreWidget(
            image: store.storeLogo,
            name: store.storeName,
            promotionText: store.promotionText,
            rating: store.rating,
            deliveryFee: "${store.deliveryFee}",
            deliveryTime: store.deliveryTime,
          ),

          SizedBox(height: 12),

          /// bloc for item list
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
          Divider(color: AppColorsPath.greyEDEDED, thickness: 1, height: 20),
        ],
      ),
    );
  }
}

/// bloc for product card
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
      width: 125,
      height: 180,
      margin: EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// bloc image with discount text
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
                    color: AppColorsPath.redE21B1B,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: AppLabel(
                    text: discountText,
                    color: AppColorsPath.white,
                    fontSize: AppFontSize.value10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          /// bloc for product name
          AppLabel(
            text: name,
            fontSize: AppFontSize.value13,
            maxLines: 1,
            fontWeight: FontWeight.w500,
            color: AppColorsPath.black09051C,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 2),

          /// bloc for product price and original price
          Row(
            children: [
              AppLabel(
                text: "\$$price",
                fontWeight: FontWeight.w500,
                color: AppColorsPath.blue,
                fontSize: AppFontSize.value13,
              ),
              SizedBox(width: 4),
              AppLabel(
                text: "\$$originalPrice",
                fontSize: AppFontSize.value10,
                fontWeight: FontWeight.w400,
                color: AppColorsPath.redE21B1B,
                textDecoration: TextDecoration.lineThrough,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// bloc store details
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
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColorsPath.greyE0E0E0,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: AppColorsPath.greyE0E0E0.withValues(alpha: 0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: AppColorsPath.greyE0E0E0, width: 1),
            ),
          ),
          SizedBox(width: 12),

          /// bloc for store details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppLabel(
                  text: name,
                  fontSize: AppFontSize.value13,
                  fontWeight: FontWeight.w500,
                  color: AppColorsPath.black09051C,
                ),
                SizedBox(height: 4),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColorsPath.redE21B1B,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: AppLabel(
                    text: promotionText,
                    fontSize: AppFontSize.value10,
                    fontWeight: FontWeight.w500,
                    color: AppColorsPath.white,
                  ),
                ),
                SizedBox(height: 4),

                /// bloc for rating, delivery fee, and delivery time
                Row(
                  children: [
                    Icon(
                      Icons.star_border,
                      size: 14,
                      color: AppColorsPath.yellow,
                    ),
                    SizedBox(width: 4),
                    AppLabel(
                      text: rating.toString(),
                      fontSize: AppFontSize.value12,
                      color: AppColorsPath.colorGrey.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: 10),
                  ],
                ),

                /// bloc for delivery fee and delivery time
                Row(
                  children: [
                    AppLabel(
                      text: "\$$deliveryFee",
                      fontSize: AppFontSize.value12,
                      color: AppColorsPath.colorGrey.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: 10),
                    AppLabel(
                      text: deliveryTime,
                      fontSize: AppFontSize.value12,
                      color: AppColorsPath.colorGrey.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
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
