import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_parking_ui_new/app/home/data/models/payment_card_body.dart';
import 'package:flutter_parking_ui_new/app/home/data/models/payment_card_model.dart';
import 'package:flutter_parking_ui_new/app/login/cubit/profile_cubit.dart';

abstract class PaymentCardsRepo {
  static Future<PaymentCardModel?> addPaymentCard(PaymentCardBody card) async {
    try {
      final ref = FirebaseFirestore.instance.collection('PaymentCards').doc();
      await ref.set(card.toJson());

      return PaymentCardModel(
        id: ref.id,
        userId: card.userId ?? ProfileCubit.instance.user?.id ?? "",
        cardHolderName: card.cardHolderName ?? "",
        cardNumber: card.cardNumber ?? "",
        expiryDate: card.expiryDate ?? "",
        createdAt: card.createdAt ?? DateTime.now(),
      );
    } catch (e) {
      return null;
    }
  }

  static Future<List<PaymentCardModel>> getPaymentCards() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('PaymentCards')
          .where('userId', isEqualTo: ProfileCubit.instance.user?.id)
          .get();

      print("🚨🚨🚨🚨🚨");
      print(querySnapshot.docs);

      return querySnapshot.docs.map((doc) {
        final cardJson = Map<String, dynamic>.from(doc.data());

        cardJson['id'] = doc.id;
        print(cardJson);
        print(cardJson.runtimeType);

        try {
          return PaymentCardModel.fromJson(cardJson);
        } catch (e) {
          print(e);
          return PaymentCardModel.fromJson(cardJson);
        }
      }).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<int> numOfPaymentMethods() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('PaymentCards')
          .where('userId', isEqualTo: ProfileCubit.instance.user?.id)
          .get();

      print("🚨🚨🚨🚨");
      print(querySnapshot.docs.length);

      return querySnapshot.docs.length;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  static Future<bool> deletePaymentCard(String cardId) async {
    try {
      await FirebaseFirestore.instance
          .collection('PaymentCards')
          .doc(cardId)
          .delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
