import 'package:flutter_parking_ui_new/app/login/cubit/profile_cubit.dart';

class PaymentCardBody {
  String? userId;
  String? cardHolderName;
  String? cardNumber;
  String? expiryDate;
  DateTime? createdAt;

  PaymentCardBody({
    this.userId,
    this.cardHolderName,
    this.cardNumber,
    this.expiryDate,
    this.createdAt,
  });

  factory PaymentCardBody.fromJson(Map<String, dynamic> json) {
    return PaymentCardBody(
      userId: json['userId'],
      cardHolderName: json['cardHolderName'],
      cardNumber: json['cardNumber'],
      expiryDate: json['expiryDate'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? "")?.toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId ?? ProfileCubit.instance.user?.id,
      'cardHolderName': cardHolderName,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'createdAt': createdAt?.toUtc().toIso8601String() ??
          DateTime.now().toUtc().toIso8601String(),
    };
  }
}
