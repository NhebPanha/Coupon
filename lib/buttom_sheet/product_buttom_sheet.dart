import 'dart:async';
import 'package:coupon/store/promotions_store_detail.dart';
import 'package:coupon/widget/app_colore_part.dart';
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColorsPath.transparent,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppLabel(
                    text: "Special Time Offer 🍎👍😍",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
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
      {'name': 'Burger', 'icon': '🍔', 'selected': true},
      {'name': 'Coffee', 'icon': '☕', 'selected': false},
      {'name': 'Pizza', 'icon': '🍕', 'selected': false},
      {'name': 'Western', 'icon': '🥩', 'selected': false},
      {'name': 'Sushi', 'icon': '🍣', 'selected': false},
    ];
    
    
    return Container(
      decoration: BoxDecoration(
        color: AppColorsPath.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categories.map((cat) {
            final isSelected = cat['selected'] as bool;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  // The Main Item Card
                  Container(
                    // Adjust size to comfortably fit your content
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      // Selected state gets the light yellow bg, unselected is completely transparent/white
                      color: isSelected
                          ? const Color(0xFFFFF3D4)
                          : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Image/Icon Container (The circular white plate look)
                        Center(
                          child: Text(
                            cat['icon'], // Or swap this with your Image widget
                            style: const TextStyle(fontSize: 32),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Text Label
                        Text(
                          cat['name'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            // Selected state gets golden text, unselected gets dark charcoal/black
                            color: isSelected
                                ? const Color(0xFFD4A300)
                                : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Bottom Selection Indicator Bar
                  Container(
                    width: 45,
                    height: 3,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColorsPath.yellow
                          : AppColorsPath.transparent,
                    ),
                  ),
                ],
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
