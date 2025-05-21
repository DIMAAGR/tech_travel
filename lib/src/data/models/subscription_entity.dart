import 'package:tech_travel/src/domain/entities/subscription_entity.dart';

class SubscriptionModel extends SubscriptionEntity {
  SubscriptionModel({
    required super.type,
    required super.expireIn,
    required super.inscriptionDate,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      type: SubscriptionType.fromString(json['type'] ?? ''),
      expireIn: ExpireTime.fromString(json['expireIn'] ?? ''),
      inscriptionDate: DateTime.parse(json['inscriptionDate'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.type,
      'expireIn': expireIn.expire,
      'inscriptionDate': inscriptionDate.toIso8601String(),
    };
  }
}
