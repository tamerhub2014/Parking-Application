class PaymentCardModel {
  final String id;
  final String userId;
  final String cardHolderName;
  final String cardNumber;
  final String expiryDate;
  DateTime? createdAt;

  PaymentCardModel({
    required this.id,
    required this.userId,
    required this.cardHolderName,
    required this.cardNumber,
    required this.expiryDate,
    this.createdAt,
  });

  factory PaymentCardModel.fromJson(Map<String, dynamic> json) {
    try {
      print("🚨🚨🚨🚨🚨  1");
      print(json['id']);
      print("🚨🚨🚨🚨🚨  2");
      print(json['userId']);
      print("🚨🚨🚨🚨🚨  3");
      print(json['cardHolderName']);
      print("🚨🚨🚨🚨🚨  4");
      print(json['cardNumber']);
      print("🚨🚨🚨🚨🚨  5");
      print(json['expiryDate']);
      print("🚨🚨🚨🚨🚨  6");
      print(json['createdAt']);
      print("🚨🚨🚨🚨🚨  7");
    } catch (e) {
      print(e);
    }

    return PaymentCardModel(
      id: json['id'],
      userId: json['userId'],
      cardHolderName: json['cardHolderName'],
      cardNumber: json['cardNumber'],
      expiryDate: json['expiryDate'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? "")?.toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'cardHolderName': cardHolderName,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'createdAt': createdAt?.toUtc().toIso8601String(),
    };
  }
}
