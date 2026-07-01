import 'package:coupon/coupon/coupon.dart';
import 'package:coupon/coupon/coupon_v2.dart';
import 'package:coupon/store/promotions_store_detail.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: CouponScreen(),
      home: PromotionsStoreDetail(),
    );
  }
}
