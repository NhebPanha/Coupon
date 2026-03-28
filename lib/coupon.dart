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

class _CouponCardState extends State<CouponCard> {
  late double screenWidth = MediaQuery.of(context).size.width;
  late double screenHeight = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    // Choose the clipper based on the card type
    CustomClipper<Path> activeClipper = LeftNotchClipper();

    return ClipPath(
      clipper: activeClipper,
      child: SizedBox(
        height: 150,

        child: Stack(
          children: [
            Row(
              children: [
                // LEFT QR RED
                ClipPath(
                  clipper: TicketSideClipperLeft(),
                  child: Container(
                    width: 130,
                    // Note: Use a slightly darker red to match your new image (e.g., 0xFFB71C1C)
                    color: Color(0xFFB71C1C),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Your QR code and Text here
                      ],
                    ),
                  ),
                ),

                // RIGHT SIDE
                Expanded(
                  child: ClipPath(
                    clipper: TicketClipperRight(),
                    child: Container(
                      width: screenWidth,
                      decoration: BoxDecoration(
                        color: Color(0xFFCECECE),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black.withValues(alpha: 0.09),
                            blurRadius: 10.2,
                            spreadRadius: 0,
                          ),
                        ],
                      ),

                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Your QR code and Text here
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Positioned(
              right: 0,
              child: ClipPath(
                clipper: RoundedNotchClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 180, 13, 1),
                        const Color(
                          0x957C0000,
                        ), // or another shade for gradient effect
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        color: Colors.black.withValues(alpha: 0.09),
                      ),
                    ],
                  ),
                  width: 130, // Adjust width as needed
                  height: 38, // Adjust height as needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// MODIFIED CLIPPER based on the provided image.
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

/// The original clipper, used for the second card for comparison
class TicketSideClipperLeft extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Adjust these to change the look
    const double cornerCutSize = 10.0; // Size of the diagonal corners
    const int notchCount = 13; // Number of small notches
    const double notchRadius = 2; // Size of the small notches

    // 1. Start at Top Left
    path.moveTo(0, 0);

    // 2. Line to the start of the diagonal cut at top right
    path.lineTo(size.width - cornerCutSize, 0);

    // 3. Diagonal cut to the right edge
    path.lineTo(size.width, cornerCutSize);

    // 4. Draw Right Edge with Serrated Notches
    // We calculate the space available between the two diagonal cuts
    double availableHeight = size.height - (cornerCutSize * 2);
    double sectionHeight = availableHeight / notchCount;

    for (int i = 0; i < notchCount; i++) {
      double centerY =
          cornerCutSize + (i * sectionHeight) + (sectionHeight / 2);

      // Line to start of notch
      path.lineTo(size.width, centerY - notchRadius);

      // Draw small semi-circle notch (clockwise: false pulls it inward)
      path.arcToPoint(
        Offset(size.width, centerY + notchRadius),
        radius: Radius.circular(notchRadius),
        clockwise: false,
      );
    }

    // 5. Line to the start of the bottom diagonal cut
    path.lineTo(size.width, size.height - cornerCutSize);

    // 6. Diagonal cut to the bottom edge
    path.lineTo(size.width - cornerCutSize, size.height);

    // 7. Line to bottom left and close
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class TicketClipperRight extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Configurations
    const double cornerCutSize = 10;
    const int leftNotchCount = 13;
    const double leftNotchRadius = 2;
    const int rightNotchCount = 6;

    // 1. Start at top-left (after the diagonal cut)
    path.moveTo(cornerCutSize, 0);

    // 2. Top Edge to Top Right
    path.lineTo(size.width, 0);

    // 3. Right Edge with Large Notches (Top to Bottom)
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

    // 4. Line to Bottom Right
    path.lineTo(size.width, size.height);

    // 5. Line to Bottom Left (before diagonal cut)
    path.lineTo(cornerCutSize, size.height);

    // 6. Diagonal cut to Left Edge
    path.lineTo(0, size.height - cornerCutSize);

    // 7. Left Edge with Small Serrations (Bottom to Top)
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

    // 8. Final Diagonal cut to close the shape
    path.lineTo(0, cornerCutSize);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

//// bloc buttom
class RoundedNotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // 1. Start at the top-left (where the curve ends and straight line begins)
    double radius = size.height / 2;
    path.moveTo(radius, 0);

    // 2. Top straight edge to top-right corner
    path.lineTo(size.width, 0);

    // 3. Right edge with two INWARD notches
    double notchRadius = size.height * 0.13;

    // First Notch
    path.lineTo(size.width, size.height * 0.3 - notchRadius);
    path.arcToPoint(
      Offset(size.width, size.height * 0.4 + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false, // Changed to FALSE to bite "in"
    );

    // // Second Notch
    path.lineTo(size.width, size.height * 0.9 - notchRadius);
    path.arcToPoint(
      Offset(size.width, size.height * 1.05 + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false, // Changed to FALSE to bite "in"
    );

    // 4. Line to bottom-right corner and then to bottom-left
    path.lineTo(size.width, size.height);
    path.lineTo(radius, size.height);

    // 5. Large Left OUTWARD Curve
    // Drawing from bottom-left back up to top-left
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
