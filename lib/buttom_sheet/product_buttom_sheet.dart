import 'dart:async';
import 'package:coupon/store/promotions_store_detail.dart';
import 'package:coupon/widget/app_colore_part.dart';
import 'package:coupon/widget/app_font_size.dart';
import 'package:coupon/widget/app_label.dart';
import 'package:flutter/material.dart';

class ProductMenuScreen extends StatefulWidget {
  const ProductMenuScreen({super.key});

  @override
  State<ProductMenuScreen> createState() => _ProductMenuScreenState();
}

class _ProductMenuScreenState extends State<ProductMenuScreen> {
  late PageController _pageControllerRow1;
  late PageController _pageControllerRow2;
  late PageController _pageControllerRow3;
  Timer? _autoScrollTimer;
  int _currentPage = 0;
  final int _totalPageSegments = 3;

  // Track if the user is currently touching/dragging the screen
  bool _isUserInteracting = false;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Using 0.93 viewportFraction allows the next card segment to peek into view
    _pageControllerRow1 = PageController(viewportFraction: 0.93);
    _pageControllerRow2 = PageController(viewportFraction: 0.93);
    _pageControllerRow3 = PageController(viewportFraction: 0.93);

    _startAutoScroll();
  }

  // Extracted logic to start the timer loop safely
  void _startAutoScroll() {
    _autoScrollTimer?.cancel(); // Clear any existing timer first

    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      // If user is touching or scrolling the screen, skip this tick
      if (_isUserInteracting) return;

      if (_currentPage < _totalPageSegments - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      const curve = Curves.easeInOutCubic;
      const duration = Duration(milliseconds: 800);

      _pageControllerRow1.animateToPage(
        _currentPage,
        duration: duration,
        curve: curve,
      );
      _pageControllerRow2.animateToPage(
        _currentPage,
        duration: duration,
        curve: curve,
      );
      _pageControllerRow3.animateToPage(
        _currentPage,
        duration: duration,
        curve: curve,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageControllerRow1.dispose();
    _pageControllerRow2.dispose();
    _pageControllerRow3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPath.transparent,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            /// bloc Close Button & Banner
            Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColorsPath.black.withValues(alpha: 0.5),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: AppColorsPath.backgroundColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppLabel(
                    text: "Special Time Offer 🍎👍😍",
                    fontSize: AppFontSize.value14,
                    fontWeight: FontWeight.w700,
                    color: AppColorsPath.black,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            /// bloc Main White Content Card
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color:
                      AppColorsPath.white, // Fixed background display container
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    _buildCategoryRow(),
                    // Wrapped with Listener to catch touch/scroll interactions instantly
                    Expanded(
                      child: Listener(
                        onPointerDown: (_) {
                          setState(() {
                            _isUserInteracting = true;
                          });
                        },
                        onPointerUp: (_) {
                          setState(() {
                            _isUserInteracting = false;
                          });
                          // Restart the cycle timer fresh so it doesn't immediately snap
                          _startAutoScroll();
                        },
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(top: 16),
                          // CRITICAL: Explicitly routes layout physics up and down predictably
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics(),
                          ),
                          child: Column(
                            children: [
                              _buildHorizontalProductRow(_pageControllerRow1),
                              _buildHorizontalProductRow(_pageControllerRow2),
                              _buildHorizontalProductRow(_pageControllerRow3),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryRow() {
    final List<Map<String, dynamic>> categories = [
      {'name': 'Burger', 'icon': '🍔'},
      {'name': 'Coffee', 'icon': '☕'},
      {'name': 'Pizza', 'icon': '🍕'},
      {'name': 'Western', 'icon': '🥩'},
      {'name': 'Sushi', 'icon': '🍣'},
      {'name': 'Burger', 'icon': '🍔'},
      {'name': 'Coffee', 'icon': '☕'},
      {'name': 'Pizza', 'icon': '🍕'},
      {'name': 'Western', 'icon': '🥩'},
      {'name': 'Sushi', 'icon': '🍣'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColorsPath.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categories.asMap().entries.map((entry) {
            final index = entry.key;
            final cat = entry.value;
            final isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      padding: EdgeInsets.all(12),
                      decoration: isSelected
                          ? BoxDecoration(
                              color: AppColorsPath.yellowFFE99C.withValues(
                                alpha: 0.5,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColorsPath.black.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                                BoxShadow(
                                  color: AppColorsPath.backgroundColor,
                                  spreadRadius: -0.3,
                                  blurRadius: 5,
                                  offset: Offset(1, 3),
                                ),
                              ],
                            )
                          : BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            width: 55,
                            height: 55,
                            decoration: !isSelected
                                ? null
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColorsPath.black.withValues(
                                          alpha: 0.3,
                                        ),
                                      ),
                                      BoxShadow(
                                        color: AppColorsPath.backgroundColor,
                                        spreadRadius: -0.3,
                                        blurRadius: 5,
                                        offset: Offset(1, 3),
                                      ),
                                    ],
                                  ),
                            child: Center(
                              child: AppLabel(
                                text: cat['icon'],
                                fontSize: AppFontSize.value32,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          AppLabel(
                            text: cat['name'],
                            fontSize: AppFontSize.value12,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? AppColorsPath.yellowE3A700
                                : AppColorsPath.neutral900,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      width: 50,
                      height: 3,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColorsPath.yellow
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildHorizontalProductRow(PageController controller) {
    return SizedBox(
      height:
          200, // Height expanded to accommodate both the card item image and text details comfortably
      width: MediaQuery.of(context).size.width,
      child: PageView.builder(
        controller: controller,
        itemCount: _totalPageSegments,
        // CRITICAL: Allows vertical gestures to pass completely through to the parent scroll view
        physics: const ClampingScrollPhysics(),
        onPageChanged: (index) {
          if (_isUserInteracting) {
            _currentPage = index;
          }
        },
        itemBuilder: (context, pageIndex) {
          // Replaced ListView.builder with Row + Expanded to display clean columns across pages side-by-side
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) {
                final displayIndex = pageIndex * 3 + index + 1;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CardProductStoreWidget(
                      discountText: "20% OFF",
                      image:
                          "https://www.cheffaro.com/wp-content/uploads/2022/02/cheffaro_ayam-penyet-1.jpg",
                      name: "Product $displayIndex",
                      originalPrice: (displayIndex * 5.0).toStringAsFixed(2),
                      price: (displayIndex * 4.0).toStringAsFixed(2),
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
