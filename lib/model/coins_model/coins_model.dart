class MyCoinsModel {
  final String membershipTier;
  final int totalCoins;
  final double coinValue;
  final int expiringCoins;
  final String expiringDate;
  final int checkInDay;
  final List<CheckInDayModel> checkInDays;
  final List<MissionModel> missions;
  final List<FeaturedRewardModel> featuredRewards;
  final List<RedeemVoucherModel> redeemVouchers;

  MyCoinsModel({
    required this.membershipTier,
    required this.totalCoins,
    required this.coinValue,
    required this.expiringCoins,
    required this.expiringDate,
    required this.checkInDay,
    required this.checkInDays,
    required this.missions,
    required this.featuredRewards,
    required this.redeemVouchers,
  });

  factory MyCoinsModel.fromJson(Map<String, dynamic> json) {
    return MyCoinsModel(
      membershipTier: json['membership_tier'] ?? '',
      totalCoins: json['total_coins'] ?? 0,
      coinValue: (json['coin_value'] ?? 0).toDouble(),
      expiringCoins: json['expiring_coins'] ?? 0,
      expiringDate: json['expiring_date'] ?? '',
      checkInDay: json['check_in_day'] ?? 0,
      checkInDays:
          (json['check_in_days'] as List?)
              ?.map((e) => CheckInDayModel.fromJson(e))
              .toList() ??
          [],
      missions:
          (json['missions'] as List?)
              ?.map((e) => MissionModel.fromJson(e))
              .toList() ??
          [],
      featuredRewards:
          (json['featured_rewards'] as List?)
              ?.map((e) => FeaturedRewardModel.fromJson(e))
              .toList() ??
          [],
      redeemVouchers:
          (json['redeem_vouchers'] as List?)
              ?.map((e) => RedeemVoucherModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'membership_tier': membershipTier,
      'total_coins': totalCoins,
      'coin_value': coinValue,
      'expiring_coins': expiringCoins,
      'expiring_date': expiringDate,
      'check_in_day': checkInDay,
      'check_in_days': checkInDays.map((e) => e.toJson()).toList(),
      'missions': missions.map((e) => e.toJson()).toList(),
      'featured_rewards': featuredRewards.map((e) => e.toJson()).toList(),
      'redeem_vouchers': redeemVouchers.map((e) => e.toJson()).toList(),
    };
  }
}

class CheckInDayModel {
  final String label;
  final int coins;

  CheckInDayModel({required this.label, required this.coins});

  factory CheckInDayModel.fromJson(Map<String, dynamic> json) {
    return CheckInDayModel(
      label: json['label'] ?? '',
      coins: json['coins'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'label': label, 'coins': coins};
  }
}

class MissionModel {
  final String title;
  final int coins;
  final String iconType;

  MissionModel({
    required this.title,
    required this.coins,
    required this.iconType,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) {
    return MissionModel(
      title: json['title'] ?? '',
      coins: json['coins'] ?? 0,
      iconType: json['icon_type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'coins': coins, 'icon_type': iconType};
  }
}

class FeaturedRewardModel {
  final String image;
  final String title;
  final String validUntil;

  FeaturedRewardModel({
    required this.image,
    required this.title,
    required this.validUntil,
  });

  factory FeaturedRewardModel.fromJson(Map<String, dynamic> json) {
    return FeaturedRewardModel(
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      validUntil: json['valid_until'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'image': image, 'title': title, 'valid_until': validUntil};
  }
}

class RedeemVoucherModel {
  final String title;
  final String memberType;
  final int coins;
  final int gradientType;

  RedeemVoucherModel({
    required this.title,
    required this.memberType,
    required this.coins,
    required this.gradientType,
  });

  factory RedeemVoucherModel.fromJson(Map<String, dynamic> json) {
    return RedeemVoucherModel(
      title: json['title'] ?? '',
      memberType: json['member_type'] ?? '',
      coins: json['coins'] ?? 0,
      gradientType: json['gradient_type'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'member_type': memberType,
      'coins': coins,
      'gradient_type': gradientType,
    };
  }
}

/// 👉 dummy data, replace with API later
final MyCoinsModel myCoinsData = MyCoinsModel(
  membershipTier: "Gold",
  totalCoins: 1200,
  coinValue: 12,
  expiringCoins: 200,
  expiringDate: "31/12/2023",
  checkInDay: 4,
  checkInDays: [
    CheckInDayModel(label: "Day 1", coins: 10),
    CheckInDayModel(label: "Day 2", coins: 10),
    CheckInDayModel(label: "Day 3", coins: 10),
    CheckInDayModel(label: "Day 4", coins: 10),
    CheckInDayModel(label: "Today", coins: 10),
    CheckInDayModel(label: "Day 6", coins: 10),
    CheckInDayModel(label: "Day 7", coins: 10),
  ],
  missions: [
    MissionModel(title: "Completed 1 order", coins: 100, iconType: "order"),
    MissionModel(title: "Invite 1 friend", coins: 100, iconType: "invite"),
  ],
  featuredRewards: [
    FeaturedRewardModel(
      image:
          "https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=400",
      title: "Earn 200 Red Ant Coins Back on Food Orders",
      validUntil: "Valid until 9 Dec, 2023",
    ),
    FeaturedRewardModel(
      image:
          "https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?w=400",
      title: "Earn 200 Red Ant Coins Back on Taxi Rides",
      validUntil: "Valid until 9 Dec, 2023",
    ),
  ],
  redeemVouchers: [
    RedeemVoucherModel(
      title: "10% discount voucher",
      memberType: "For all members",
      coins: 1000,
      gradientType: 0,
    ),
    RedeemVoucherModel(
      title: "25% discount voucher",
      memberType: "For platinum member",
      coins: 2500,
      gradientType: 1,
    ),
    RedeemVoucherModel(
      title: "20% discount voucher",
      memberType: "For gold member",
      coins: 2000,
      gradientType: 2,
    ),
  ],
);
