enum SubscriptionType {
  premium('premium'),
  basic('basic'),
  none('none');

  final String type;

  const SubscriptionType(this.type);

  static SubscriptionType fromString(String type) => switch (type) {
        'premium' => SubscriptionType.premium,
        'basic' => SubscriptionType.basic,
        _ => SubscriptionType.none,
      };
}

enum ExpireTime {
  soon('coming soon'),
  next('next month'),
  today('today'),
  expired('expired');

  final String expire;

  const ExpireTime(this.expire);

  static ExpireTime fromString(String type) => switch (type) {
        'soon' => ExpireTime.soon,
        'next' => ExpireTime.next,
        'today' => ExpireTime.today,
        _ => ExpireTime.expired,
      };
}

class SubscriptionEntity {
  final SubscriptionType type;
  final ExpireTime expireIn;
  final DateTime inscriptionDate;

  SubscriptionEntity({
    required this.expireIn,
    required this.inscriptionDate,
    required this.type,
  });
}
