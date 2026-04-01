import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
            // The first card uses the new "left-notch" clipper
            CouponCard(
              discount: '20%',
              title: 'Your New User taxi voucher',
              usedFor: 'Food delivery',
              validTill: '31 FEB 2026',
              code: '12345678',
              isFirstCard: true, // Specific state for the first card
            ),
            SizedBox(height: 10),
            CouponCard(
              discount: '20%',
              title: 'Your New User taxi voucher',
              usedFor: 'Food delivery',
              validTill: '31 FEB 2026',
              code: '12345678',
              isFirstCard: true, // Specific state for the first card
            ),
            SizedBox(height: 10),
            CouponCard(
              discount: '20%',
              title: 'Your New User taxi voucher',
              usedFor: 'Food delivery',
              validTill: '31 FEB 2026',
              code: '12345678',
              isFirstCard: true, // Specific state for the first card
            ),
            // The second card remains a standard rounded rectangle for comparison
          ],
        ),
      ),
    );
  }
}

class CouponCard extends StatefulWidget {
  final String discount;
  final String title;
  final String usedFor;
  final String validTill;
  final String code;
  final bool isFirstCard; // New parameter to choose clipper

  const CouponCard({
    super.key,
    required this.discount,
    required this.title,
    required this.usedFor,
    required this.validTill,
    required this.code,
    required this.isFirstCard,
  });

  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFront = true;
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    // This creates a 0 to 180 degree rotation
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
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
    /// Choose the clipper based on the card type
    CustomClipper<Path> activeClipper = LeftNotchClipper();
    return GestureDetector(
      onTap: _toggleCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          // Calculate rotation in radians
          final double rotationValue = _animation.value * 3.14159; // pi
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Adds perspective depth
              ..rotateY(rotationValue),
            child: rotationValue <= 3.14159 / 2
                ?
                  /// bloc front
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          offset: Offset(0, 1),
                          blurRadius: 10.2,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: ClipPath(
                      clipper: activeClipper,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              /// LEFT QR RED
                              ClipPath(
                                clipper: TicketSideClipperLeft(),
                                child: Container(
                                  height: 120,
                                  width:
                                      screenWidth *
                                      0.3, // Adjust width as needed
                                  /// Note: Use a slightly darker red to match your new image (e.g., 0xFFB71C1C)
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xFFB71C1C),
                                        Color(0xFFD32F2F),
                                      ],
                                    ),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          /// The QR Code itself
                                          QrImageView(
                                            data:
                                                "https://i.pinimg.com/736x/ba/14/4b/ba144bd17b47f9783d4754504a5d1c79.jpg",
                                            version: QrVersions.auto,
                                            size: 80,
                                            eyeStyle: QrEyeStyle(
                                              eyeShape: QrEyeShape.square,
                                              color: Colors.white,
                                            ),
                                            dataModuleStyle: QrDataModuleStyle(
                                              dataModuleShape:
                                                  QrDataModuleShape.square,
                                              color: Colors.white,
                                            ),
                                          ),

                                          /// The Custom Corner Brackets
                                          Positioned(
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                            child: CustomPaint(
                                              painter: CornerBracketPainter(),
                                            ),
                                          ),
                                        ],
                                      ),

                                      /// The Text below
                                      Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Text(
                                          "Code:12345678",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // RIGHT SIDE
                              Expanded(
                                child: PhysicalShape(
                                  elevation: 20,
                                  clipBehavior: Clip.antiAlias,
                                  shadowColor: Colors.black.withValues(
                                    alpha: 0.3,
                                  ),
                                  color: Colors.white,
                                  clipper: TicketClipperRight(),
                                  child: SizedBox(
                                    height: 120,
                                    width: screenWidth * 0.7,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 10,
                                        right: 5,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          /// bloc discount
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.baseline,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            children: [
                                              Text(
                                                "20%",
                                                style: TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "OFF",
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.red,
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ],
                                          ),

                                          /// bloc text
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AppLabel(
                                                    text:
                                                        "Your New User taxi voucher",
                                                    fontSize:
                                                        AppFontSize.value12,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColorsPath.black,
                                                  ),
                                                  AppLabel(
                                                    text:
                                                        "Used for : Food delivery",
                                                    fontSize:
                                                        AppFontSize.value12,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColorsPath
                                                        .gray7E7E7E,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      AppLabel(
                                                        text:
                                                            "ValidTill : 31 FEB 2026",
                                                        fontSize:
                                                            AppFontSize.value12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColorsPath
                                                            .gray7E7E7E,
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal:
                                                                  screenWidth *
                                                                  0.05,
                                                            ),
                                                        child: SvgPicture.asset(
                                                          AppIconsSVGPath
                                                              .iconWarningCoupon,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),

                                              /// bloc icon dynamic
                                              Expanded(
                                                child: SizedBox(
                                                  height: 70,
                                                  width: 70,
                                                  child: Image.network(
                                                    "https://www.pngall.com/wp-content/uploads/12/Delivery-Scooter-PNG-Cutout.png",
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          /// bloc button use now coupon
                          Positioned(
                            right: 0,
                            child: PhysicalShape(
                              elevation: 20,
                              clipBehavior: Clip.antiAlias,
                              shadowColor: Colors.black.withValues(alpha: 0.3),
                              clipper: RoundedNotchClipper(),
                              color: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xFFB71C1C),
                                      Color(0xFFD32F2F),
                                    ],
                                  ),
                                ),
                                width:
                                    screenWidth *
                                    0.25, // Adjust width as needed
                                height: 30, // Adjust height as needed
                                child: Center(
                                  child: Text(
                                    "USE NOW",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                /// bloc back
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateY(
                        3.14159,
                      ), // Prevents back side from being mirrored
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            offset: Offset(0, 1),
                            blurRadius: 10.2,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: ClipPath(
                        clipper: activeClipper,
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                /// LEFT QR RED
                                ClipPath(
                                  clipper: TicketSideClipperLeft(),
                                  child: Container(
                                    height: 120,
                                    width:
                                        screenWidth *
                                        0.65, // Adjust width as needed
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),

                                    /// Note: Use a slightly darker red to match your new image (e.g., 0xFFB71C1C)
                                    padding: const EdgeInsets.all(10),
                                    child: Table(
                                      // Sets the width of the first column (the keys)
                                      columnWidths: {
                                        0: IntrinsicColumnWidth(), // Wraps to content
                                        2: FlexColumnWidth(), // Takes up the remaining space
                                      },
                                      children: [
                                        _buildTableRow(
                                          "Event:",
                                          "Valentine’s Day",
                                        ),
                                        _buildTableRow(
                                          "Discount:",
                                          "20% off on Food Delivery for All stores",
                                        ),
                                        _buildTableRow("MOV:", "\$3"),
                                        _buildTableRow(
                                          "Condition:",
                                          "For new users (within 30 days)",
                                        ),
                                        _buildTableRow(
                                          "Limit Use:",
                                          "1 per day",
                                        ),
                                        _buildTableRow(
                                          "Valid Period:",
                                          "Feb 10, 2026 - Feb 17, 2026",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // RIGHT SIDE
                                Expanded(
                                  child: PhysicalShape(
                                    elevation: 20,
                                    clipBehavior: Clip.antiAlias,
                                    shadowColor: Colors.black.withValues(
                                      alpha: 0.3,
                                    ),
                                    color: Colors.transparent,
                                    clipper: TicketClipperRight(),
                                    child: SizedBox(
                                      height: 120,
                                      width: screenWidth * 0.35,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xFFB71C1C),
                                              Color(0xFFD32F2F),
                                            ],
                                          ),
                                        ),
                                        child: Center(
                                          child: Image.network(
                                            "https://www.pngall.com/wp-content/uploads/12/Delivery-Scooter-PNG-Cutout.png",
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  // Helper method to keep your build method clean
  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// Custom Painter to draw the four white corner brackets
class CornerBracketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double len = 15; // Length of the bracket lines
    double radius = 3; // Curvature of the corners

    /// Top Left
    canvas.drawPath(
      Path()
        ..moveTo(0, len)
        ..lineTo(0, radius)
        ..quadraticBezierTo(0, 0, radius, 0)
        ..lineTo(len, 0),
      paint,
    );

    /// Top Right
    canvas.drawPath(
      Path()
        ..moveTo(size.width - len, 0)
        ..lineTo(size.width - radius, 0)
        ..quadraticBezierTo(size.width, 0, size.width, radius)
        ..lineTo(size.width, len),
      paint,
    );

    /// Bottom Left
    canvas.drawPath(
      Path()
        ..moveTo(0, size.height - len)
        ..lineTo(0, size.height - radius)
        ..quadraticBezierTo(0, size.height, radius, size.height)
        ..lineTo(len, size.height),
      paint,
    );

    /// Bottom Right
    canvas.drawPath(
      Path()
        ..moveTo(size.width - len, size.height)
        ..lineTo(size.width - radius, size.height)
        ..quadraticBezierTo(
          size.width,
          size.height,
          size.width,
          size.height - radius,
        )
        ..lineTo(size.width, size.height - len),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// This clipper creates large semicircular notches along the left edge.
class LeftNotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // The number of notches you want
    const int notchCount = 6;

    // We divide the height by notchCount to get the space for each 'section'
    double sectionHeight = size.height / notchCount;

    // The radius of the cutout.
    // Adjust this to make the holes larger or smaller.
    double notchRadius = sectionHeight * 0.25;

    // 1. Start at top right
    path.moveTo(size.width, 0);

    // 2. Line to bottom right
    path.lineTo(size.width, size.height);

    // 3. Line to bottom left
    path.lineTo(0, size.height);

    // 4. Draw the left edge with notches (moving from bottom to top)
    for (int i = notchCount - 1; i >= 0; i--) {
      // Determine the vertical center of the current section
      double centerY = (i * sectionHeight) + (sectionHeight / 2);

      // Line to the bottom edge of the semicircle
      path.lineTo(0, centerY + notchRadius);

      // Draw the semicircular notch
      // clockwise: false pulls the arc "into" the shape
      path.arcToPoint(
        Offset(0, centerY - notchRadius),
        radius: Radius.circular(notchRadius),
        clockwise: false,
      );
    }
    // 5. Final line to the top left corner and close
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

/// The original clipper left, used for the second card for comparison
class TicketSideClipperLeft extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    /// Adjust these to change the look
    const double cornerCutSize = 10.0; // Size of the diagonal corners
    const int notchCount = 13; // Number of small notches
    const double notchRadius = 2; // Size of the small notches

    /// Start at Top Left
    path.moveTo(0, 0);

    /// Line to the start of the diagonal cut at top right
    path.lineTo(size.width - cornerCutSize, 0);

    /// Diagonal cut to the right edge
    path.lineTo(size.width, cornerCutSize);

    /// Draw Right Edge with Serrated Notches
    /// We calculate the space available between the two diagonal cuts
    double availableHeight = size.height - (cornerCutSize * 2);
    double sectionHeight = availableHeight / notchCount;

    for (int i = 0; i < notchCount; i++) {
      double centerY =
          cornerCutSize + (i * sectionHeight) + (sectionHeight / 2);

      /// Line to start of notch
      path.lineTo(size.width, centerY - notchRadius);

      /// Draw small semi-circle notch (clockwise: false pulls it inward)
      path.arcToPoint(
        Offset(size.width, centerY + notchRadius),
        radius: Radius.circular(notchRadius),
        clockwise: false,
      );
    }

    /// Line to the start of the bottom diagonal cut
    path.lineTo(size.width, size.height - cornerCutSize);

    /// Diagonal cut to the bottom edge
    path.lineTo(size.width - cornerCutSize, size.height);

    /// Line to bottom left and close
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

/// The original clipper right, used for the second card for comparison
class TicketClipperRight extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    /// Configurations
    const double cornerCutSize = 10;
    const int leftNotchCount = 13;
    const double leftNotchRadius = 2;
    const int rightNotchCount = 6;

    /// Start at top-left (after the diagonal cut)
    path.moveTo(cornerCutSize, 0);

    /// Top Edge to Top Right
    path.lineTo(size.width, 0);

    /// Right Edge with Large Notches (Top to Bottom)
    double rightSectionHeight = size.height / rightNotchCount;
    double rightNotchRadius = rightSectionHeight * 0.30;

    for (int i = 0; i < rightNotchCount; i++) {
      double centerY = (i * rightSectionHeight) + (rightSectionHeight / 2);
      path.lineTo(size.width, centerY - rightNotchRadius);
      path.arcToPoint(
        Offset(size.width, centerY + rightNotchRadius),
        radius: Radius.circular(rightNotchRadius),
        clockwise: false, // Inward notch
      );
    }

    /// Line to Bottom Right
    path.lineTo(size.width, size.height);

    ///Line to Bottom Left (before diagonal cut)
    path.lineTo(cornerCutSize, size.height);

    /// Diagonal cut to Left Edge
    path.lineTo(0, size.height - cornerCutSize);

    /// Left Edge with Small Serrations (Bottom to Top)
    double availableHeight = size.height - (cornerCutSize * 2);
    double leftSectionHeight = availableHeight / leftNotchCount;

    for (int i = leftNotchCount - 1; i >= 0; i--) {
      double centerY =
          cornerCutSize + (i * leftSectionHeight) + (leftSectionHeight / 2);
      path.lineTo(0, centerY + leftNotchRadius);
      path.arcToPoint(
        Offset(0, centerY - leftNotchRadius),
        radius: Radius.circular(leftNotchRadius),
        clockwise: false, // Inward notch
      );
    }

    /// Final Diagonal cut to close the shape
    path.lineTo(0, cornerCutSize);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

//// bloc button
class RoundedNotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    ///Start at the top-left (where the curve ends and straight line begins)
    double radius = size.height / 2;
    path.moveTo(radius, 0);

    /// Top straight edge to top-right corner
    path.lineTo(size.width, 0);

    /// Right edge with two INWARD notches
    double notchRadius = size.height * 0.20;

    /// First Notch
    path.lineTo(size.width, size.height * 0.3 - notchRadius);
    path.arcToPoint(
      Offset(size.width, size.height * 0.3 + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false, // Changed to FALSE to bite "in"
    );

    /// Second Notch
    path.lineTo(size.width, size.height * 1 - notchRadius);
    path.arcToPoint(
      Offset(size.width, size.height * 1.05 + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false, // Changed to FALSE to bite "in"
    );

    /// Line to bottom-right corner and then to bottom-left
    path.lineTo(size.width, size.height);
    path.lineTo(radius, size.height);

    /// Drawing from bottom-left back up to top-left
    path.arcToPoint(
      Offset(radius, 0),
      radius: Radius.circular(radius),
      clockwise: true, // TRUE creates the outward rounded "bullet" look
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
