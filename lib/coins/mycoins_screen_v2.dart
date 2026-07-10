import 'package:coupon/widget/app_colore_part.dart';
import 'package:coupon/widget/app_font_size.dart';
import 'package:coupon/widget/app_label.dart';
import 'package:flutter/material.dart';

class MyCoinsScreenV2 extends StatefulWidget {
  const MyCoinsScreenV2({super.key});

  @override
  State<MyCoinsScreenV2> createState() => _MyCoinsScreenV2State();
}

class _MyCoinsScreenV2State extends State<MyCoinsScreenV2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: Stack(
        children: [
          /// Header
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  "https://i.pinimg.com/736x/ae/99/b6/ae99b68d978a0b2249f43de441c2891b.jpg",
                  fit: BoxFit.fill,
                ),

                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffFF9800).withOpacity(0.85),
                        Color(0xffFFB74D).withOpacity(0.85),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => Navigator.maybePop(context),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColorsPath.white,
                          size: 20,
                        ),
                      ),

                      Expanded(
                        child: AppLabel(
                          text: "My Coins",
                          textAlign: TextAlign.center,
                          fontSize: AppFontSize.value17,
                          fontWeight: FontWeight.w600,
                          color: AppColorsPath.white,
                        ),
                      ),

                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: AppColorsPath.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.history,
                          size: 20,
                          color: AppColorsPath.orangeFFA800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 140,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(158, 189, 113, 0),
                    Color.fromARGB(118, 187, 116, 10),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.monetization_on,
                    color: AppColorsPath.white,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  AppLabel(
                    text: "Coin",
                    fontSize: AppFontSize.value15,
                    fontWeight: FontWeight.w600,
                    color: AppColorsPath.white,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: 1,
                    height: 36,
                    color: AppColorsPath.white.withValues(alpha: 0.4),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColorsPath.white.withValues(alpha: 0.3),
                              shape: BoxShape.circle,
                            ),
                            child: AppLabel(
                              text: "A",
                              fontSize: AppFontSize.value10,
                              fontWeight: FontWeight.w700,
                              color: AppColorsPath.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          AppLabel(
                            text: "10  ≈  \$${12.toStringAsFixed(0)}",
                            fontSize: AppFontSize.value15,
                            fontWeight: FontWeight.w600,
                            color: AppColorsPath.white,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      AppLabel(
                        text: "${20} coins expiring on ${10}",
                        fontSize: AppFontSize.value11,
                        fontWeight: FontWeight.w400,
                        color: AppColorsPath.white.withValues(alpha: 0.85),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// White Body
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 1000,
              decoration: const BoxDecoration(
                color: Color(0xffF6F6F6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 30, left: 16, right: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xffFF9800), Color(0xffFFB74D)],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Daily check-in Progress",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        "You will get extra coins in the seventh time you check in each week.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 24),

                      SizedBox(
                        height: 90,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 7,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final isToday = index == 4;

                            return Container(
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isToday
                                          ? Colors.orange
                                          : Colors.orange.shade300,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "+10",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    isToday ? "Today" : "Day ${index + 1}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: isToday
                                          ? Colors.orange
                                          : Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: const Text(
                            "Check-in Now",
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
