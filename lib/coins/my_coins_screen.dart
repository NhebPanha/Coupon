import 'package:coupon/model/coins_model/coins_model.dart';
import 'package:coupon/widget/app_colore_part.dart';
import 'package:coupon/widget/app_font_size.dart';
import 'package:coupon/widget/app_label.dart';
import 'package:flutter/material.dart';

class MyCoinsScreen extends StatefulWidget {
  const MyCoinsScreen({super.key});

  @override
  State<MyCoinsScreen> createState() => _MyCoinsScreenState();
}

class _MyCoinsScreenState extends State<MyCoinsScreen> {
  late MyCoinsModel model;

  final List<Map<String, dynamic>> rewards = [
    {"point": "+10", "day": "Day 1"},
    {"point": "+20", "day": "Day 2"},
    {"point": "+30", "day": "Day 3"},
    {"point": "+40", "day": "Day 4"},
    {"point": "+50", "day": "Day 5"},
    {"point": "+60", "day": "Day 6"},
    {"point": "+100", "day": "Day 7"},
  ];

  @override
  void initState() {
    super.initState();

    // 👉 replace with API later
    model = myCoinsData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPath.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// bloc for orange header (app bar + balance + check-in)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColorsPath.orangeFFA800, AppColorsPath.yellow],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                child: Column(
                  children: [
                    /// bloc for app bar
                    Row(
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
                    const SizedBox(height: 20),

                    /// bloc for coin balance row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.monetization_on,
                          color: AppColorsPath.white,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        AppLabel(
                          text: model.membershipTier,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColorsPath.white.withValues(
                                      alpha: 0.3,
                                    ),
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
                                  text:
                                      "${model.totalCoins}  ≈  \$${model.coinValue.toStringAsFixed(0)}",
                                  fontSize: AppFontSize.value15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColorsPath.white,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            AppLabel(
                              text:
                                  "${model.expiringCoins} coins expiring on ${model.expiringDate}",
                              fontSize: AppFontSize.value11,
                              fontWeight: FontWeight.w400,
                              color: AppColorsPath.white.withValues(
                                alpha: 0.85,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    
                    
                    const SizedBox(height: 20),

                    /// bloc for daily check-in card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColorsPath.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppLabel(
                            text: "Daily check-in Progress",
                            fontSize: AppFontSize.value16,
                            fontWeight: FontWeight.w600,
                            color: AppColorsPath.white,
                          ),
                          const SizedBox(height: 4),
                          AppLabel(
                            text:
                                "You will get extra coins in the seventh time you check in each week.",
                            fontSize: AppFontSize.value11,
                            fontWeight: FontWeight.w400,
                            color: AppColorsPath.white.withValues(alpha: 0.85),
                          ),
                          const SizedBox(height: 16),

                          /// bloc for day chips
                          SizedBox(
                            height: 55,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: rewards.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 8),
                              itemBuilder: (context, index) {
                                final item = rewards[index];

                                return Container(
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: AppColorsPath.yellowFFE5C1,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: 1,
                                      color: AppColorsPath.white,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 7,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                AppColorsPath.yellowFEC258,
                                                AppColorsPath.yellowF8AA1E,
                                                AppColorsPath.yellowFEC258,
                                              ],
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                            border: Border.all(
                                              width: 0.5,
                                              color: AppColorsPath.yellowEE8F0F,
                                            ),
                                          ),
                                          child: Center(
                                            child: AppLabel(
                                              text: item["point"],
                                              fontSize: AppFontSize.value8,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: AppLabel(
                                              text: item["day"],
                                              fontSize: AppFontSize.value10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 16),

                          /// bloc for check-in button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColorsPath.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: AppLabel(
                                text: "Check-in Now",
                                fontSize: AppFontSize.value14,
                                fontWeight: FontWeight.w600,
                                color: AppColorsPath.orangeFFA800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// bloc for quick actions
              _buildQuickActions(),

              const SizedBox(height: 24),

              /// bloc for missions
              _buildSectionHeader("Missions"),
              const SizedBox(height: 12),
              _buildMissions(),

              const SizedBox(height: 24),

              /// bloc for featured rewards
              _buildSectionHeader("Featured Rewards"),
              const SizedBox(height: 12),
              _buildFeaturedRewards(),

              const SizedBox(height: 24),

              /// bloc for redeem your coins
              _buildSectionHeader("Redeem Your Coins"),
              const SizedBox(height: 12),
              _buildRedeemVouchers(),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  /// bloc for quick actions row
  Widget _buildQuickActions() {
    final actions = [
      {
        "icon": Icons.card_giftcard,
        "label": "Rewards",
        "color": AppColorsPath.redE21B1B,
      },
      {
        "icon": Icons.autorenew,
        "label": "Redeem",
        "color": AppColorsPath.redE21B1B,
      },
      {
        "icon": Icons.volunteer_activism,
        "label": "Earn coins",
        "color": AppColorsPath.orangeFFA800,
      },
      {
        "icon": Icons.workspace_premium,
        "label": "Membership",
        "color": AppColorsPath.orangeFFA800,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: actions.map((action) {
          return Column(
            children: [
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColorsPath.orangeFCF6E7,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  action["icon"] as IconData,
                  color: action["color"] as Color,
                  size: 26,
                ),
              ),
              const SizedBox(height: 8),
              AppLabel(
                text: action["label"] as String,
                fontSize: AppFontSize.value12,
                fontWeight: FontWeight.w500,
                color: AppColorsPath.black09051C,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  /// bloc for a section header with "See All"
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppLabel(
            text: title,
            fontSize: AppFontSize.value16,
            fontWeight: FontWeight.w600,
            color: AppColorsPath.black09051C,
          ),
          Row(
            children: [
              AppLabel(
                text: "See All",
                fontSize: AppFontSize.value12,
                fontWeight: FontWeight.w500,
                color: AppColorsPath.redE21B1B,
              ),
              const SizedBox(width: 2),
              Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: AppColorsPath.redE21B1B,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// bloc for missions list
  Widget _buildMissions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: model.missions.map((mission) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColorsPath.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColorsPath.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColorsPath.orangeFCF6E7,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    mission.iconType == "invite"
                        ? Icons.group_add
                        : Icons.shopping_bag,
                    color: AppColorsPath.gold,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLabel(
                        text: mission.title,
                        fontSize: AppFontSize.value14,
                        fontWeight: FontWeight.w600,
                        color: AppColorsPath.black09051C,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          AppLabel(
                            text: mission.iconType == "invite"
                                ? "Get "
                                : "Earn ",
                            fontSize: AppFontSize.value12,
                            fontWeight: FontWeight.w400,
                            color: AppColorsPath.grey797979,
                          ),
                          AppLabel(
                            text: "+${mission.coins}",
                            fontSize: AppFontSize.value12,
                            fontWeight: FontWeight.w600,
                            color: AppColorsPath.orangeFFA800,
                          ),
                          AppLabel(
                            text: " coins",
                            fontSize: AppFontSize.value12,
                            fontWeight: FontWeight.w400,
                            color: AppColorsPath.grey797979,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColorsPath.gold),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: AppLabel(
                    text: "Get",
                    fontSize: AppFontSize.value12,
                    fontWeight: FontWeight.w600,
                    color: AppColorsPath.gold,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  /// bloc for featured rewards horizontal list
  Widget _buildFeaturedRewards() {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: model.featuredRewards.length,
        itemBuilder: (context, index) {
          final reward = model.featuredRewards[index];
          return Container(
            width: 165,
            margin: EdgeInsets.only(
              right: index == model.featuredRewards.length - 1 ? 0 : 12,
            ),
            decoration: BoxDecoration(
              color: AppColorsPath.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColorsPath.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                  child: Image.network(
                    reward.image,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => Container(
                      height: 100,
                      color: AppColorsPath.greyF5F5F5,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColorsPath.grey,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLabel(
                        text: reward.title,
                        fontSize: AppFontSize.value12,
                        fontWeight: FontWeight.w600,
                        color: AppColorsPath.black09051C,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      AppLabel(
                        text: reward.validUntil,
                        fontSize: AppFontSize.value10,
                        fontWeight: FontWeight.w400,
                        color: AppColorsPath.grey797979,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColorsPath.redE21B1B),
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: AppLabel(
                            text: "Use",
                            fontSize: AppFontSize.value12,
                            fontWeight: FontWeight.w600,
                            color: AppColorsPath.redE21B1B,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// bloc for redeem voucher horizontal list
  Widget _buildRedeemVouchers() {
    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: model.redeemVouchers.length,
        itemBuilder: (context, index) {
          final voucher = model.redeemVouchers[index];
          return Container(
            width: 150,
            margin: EdgeInsets.only(
              right: index == model.redeemVouchers.length - 1 ? 0 : 12,
            ),
            decoration: BoxDecoration(
              color: AppColorsPath.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColorsPath.greyEDEDED),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// bloc for gradient top with title
                Container(
                  height: 90,
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: _voucherGradient(voucher.gradientType),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppLabel(
                        text: voucher.title,
                        fontSize: AppFontSize.value15,
                        fontWeight: FontWeight.w700,
                        color: AppColorsPath.white,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColorsPath.white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: AppLabel(
                          text: voucher.memberType,
                          fontSize: AppFontSize.value9,
                          fontWeight: FontWeight.w500,
                          color: AppColorsPath.white,
                        ),
                      ),
                    ],
                  ),
                ),

                /// bloc for title + coins
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLabel(
                        text: voucher.title,
                        fontSize: AppFontSize.value12,
                        fontWeight: FontWeight.w600,
                        color: AppColorsPath.black09051C,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      AppLabel(
                        text: "${_formatCoins(voucher.coins)} Coins",
                        fontSize: AppFontSize.value13,
                        fontWeight: FontWeight.w600,
                        color: AppColorsPath.orangeFFA800,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// bloc for voucher gradient by type
  LinearGradient _voucherGradient(int type) {
    switch (type) {
      case 1:
        return const LinearGradient(
          colors: [Color(0xff4A64F5), Color(0xff2B3EC9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 2:
        return const LinearGradient(
          colors: [Color(0xffFFA800), Color(0xffFF7A00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return const LinearGradient(
          colors: [Color(0xffE040FB), Color(0xffAB2BD8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  /// bloc for coin formatting (1000 -> 1.000)
  String _formatCoins(int coins) {
    final str = coins.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(str[i]);
    }
    return buffer.toString();
  }
}
