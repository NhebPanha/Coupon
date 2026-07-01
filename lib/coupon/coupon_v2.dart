import 'package:coupon/widget/app_colore_part.dart';
import 'package:coupon/widget/app_label.dart';
import 'package:flutter/material.dart';

class CouponScreen extends StatelessWidget {
  const CouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Front Card Showcase
            CouponCard(),
            SizedBox(height: 16),
            // Back Card Showcase
            // CouponCard(isFrontView: false),
          ],
        ),
      ),
    );
  }
}

class CouponCard extends StatefulWidget {
  const CouponCard({super.key});
  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    if (!_isFront) {
      _controller.value = 1.0;
    }
  }

  void _toggleCard() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _isFront = !_isFront;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final double rotationValue = _animation.value * 3.141592653589793;
          final bool showFrontSide = rotationValue <= 3.141592653589793 / 2;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Realistic Perspective Depth
              ..rotateY(rotationValue),
            child: showFrontSide
                ? _buildFrontCard()
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(3.141592653589793),
                    child: _buildBackCard(),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildFrontCard() {
    return SizedBox(
      height: 160,
      child: ClipPath(
        clipper: UniversalTicketClipper(notchOnLeft: true),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColorsPath.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColorsPath.black.withValues(alpha: 0.3),
                    offset: Offset(1, 2),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Red Left Info Tab
                  Container(
                    width: 50,
                    height: double.infinity,
                    color: AppColorsPath.red,
                    child: Center(
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: AppLabel(
                          text: "FOOD COUPON",
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                  // Main Info Content Section
                  Expanded(
                    child: Container(
                      color: AppColorsPath.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                AppLabel(
                                  text: "20%",
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: AppColorsPath.red,
                                ),

                                SizedBox(width: 4),
                                AppLabel(
                                  text: "OFF",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColorsPath.red,
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            const AppLabel(
                              text: "Name Off Campaign",

                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            const SizedBox(height: 4),
                            const AppLabel(
                              text: "Valid Till : 31 FEB 2026",
                              fontSize: 11,
                              color: Colors.grey,
                            ),

                            Row(
                              children: [
                                const AppLabel(
                                  text: "Code : 1234556677",
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 6),
                                Icon(
                                  Icons.info_outline,
                                  size: 14,
                                  color: Colors.grey.shade400,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Delivery Mascot/Art Asset Section
                  Container(
                    padding: EdgeInsets.only(right: 16),
                    child: SizedBox(
                      width: 90,
                      child: Image.network(
                        "https://www.pngall.com/wp-content/uploads/12/Delivery-Scooter-PNG-Cutout.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Top Right Custom Inward Action Badge
            Positioned(
              top: 0,
              right: 0,
              child: ClipPath(
                clipper: UseNowClipper(),
                child: Container(
                  color: AppColorsPath.red,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: AppLabel(
                    text: "USE NOW",
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackCard() {
    return SizedBox(
      height: 160,
      child: ClipPath(
        clipper: UniversalTicketClipper(notchOnLeft: false),
        child: Container(
          decoration: BoxDecoration(
            color: AppColorsPath.white,
            boxShadow: [
              BoxShadow(
                color: AppColorsPath.black.withValues(alpha: 0.3),
                offset: Offset(1, 2),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              // Left Technical Specs Matrix
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Table(
                    children: [
                      _buildSpecRow("Event:", "Name off Campaign"),
                      _buildSpecRow(
                        "Discount:",
                        "20% off on Food Delivery for All stores",
                      ),
                      _buildSpecRow("MOV:", "\$3"),
                      _buildSpecRow(
                        "Condition:",
                        "For new users (within 30 days)",
                      ),
                      _buildSpecRow("Limit Use:", "1 per day"),
                      _buildSpecRow(
                        "Valid Period:",
                        "Feb 10, 2026 - Feb 17, 2026",
                      ),
                    ],
                  ),
                ),
              ),

              // Red Right Tab Layout
              Container(
                width: 50,
                height: double.infinity,
                color: AppColorsPath.red,
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      "FOOD COUPON",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildSpecRow(String title, String val) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.5),
          child: AppLabel(
            text: title,

            fontSize: 9.5,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.5),
          child: AppLabel(
            text: val,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            fontSize: 9.5,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

/// Unified ticket architecture handling modern decorative circular notches cleanly.
class UniversalTicketClipper extends CustomClipper<Path> {
  final bool notchOnLeft;
  UniversalTicketClipper({required this.notchOnLeft});

  @override
  Path getClip(Size size) {
    final path = Path();
    const double radius = 20;
    const int totalNotches = 4;
    const double notchRadius = 9;

    // Standard base initialization structure
    path.moveTo(radius, 0);
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(
      Offset(size.width, radius),
      radius: const Radius.circular(radius),
    );

    // Handle Right Notch Stack Sequence
    if (!notchOnLeft) {
      double segment = size.height / (totalNotches + 1);
      for (int i = 1; i <= totalNotches; i++) {
        path.lineTo(size.width, (segment * i) - notchRadius);
        path.arcToPoint(
          Offset(size.width, (segment * i) + notchRadius),
          radius: const Radius.circular(notchRadius),
          clockwise: false,
        );
      }
    }

    path.lineTo(size.width, size.height - radius);
    path.arcToPoint(
      Offset(size.width - radius, size.height),
      radius: const Radius.circular(radius),
    );
    path.lineTo(radius, size.height);
    path.arcToPoint(
      Offset(0, size.height - radius),
      radius: const Radius.circular(radius),
    );

    // Handle Left Notch Stack Sequence
    if (notchOnLeft) {
      double segment = size.height / (totalNotches + 1);
      for (int i = totalNotches; i >= 1; i--) {
        path.lineTo(0, (segment * i) + notchRadius);
        path.arcToPoint(
          Offset(0, (segment * i) - notchRadius),
          radius: const Radius.circular(notchRadius),
          clockwise: false,
        );
      }
    }

    path.lineTo(0, radius);
    path.arcToPoint(Offset(radius, 0), radius: const Radius.circular(radius));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Dynamic Clipper rendering the precise curved, asymmetry inward badge style on top right.
class UseNowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const double radius = 16;

    Path path = Path();

    // Start top-left
    path.moveTo(0, 0);

    // Top edge
    path.lineTo(size.width - radius, 0);

    // Top-right radius
    path.arcToPoint(
      Offset(size.width, radius),
      radius: const Radius.circular(radius),
    );

    // Right edge
    path.lineTo(size.width, size.height);

    // Bottom edge
    path.lineTo(radius, size.height);

    // Bottom-left radius
    path.arcToPoint(
      Offset(0, size.height - radius),
      radius: const Radius.circular(radius),
    );

    // Left edge
    path.lineTo(0, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
