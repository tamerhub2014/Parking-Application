import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_parking_ui_new/app/home/data/models/parking_ticket_body.dart';
import 'package:flutter_parking_ui_new/app/login/cubit/profile_cubit.dart';

import '../../../home/data/models/parking_ticket.dart';

abstract class ParkingTicketsRepo {
  static Future<ParkingTicket?> addParkingTicket(
      ParkingTicketBody ticket) async {
    try {
      final ref = FirebaseFirestore.instance.collection('ParkingTickets').doc();
      await ref.set(ticket.toJson());

      return ParkingTicket(
        id: ref.id,
        userId: ticket.userId ?? ProfileCubit.instance.user?.id ?? "",
        parking: ticket.parking,
        status: ticket.status,
        from: ticket.from,
        to: ticket.to,
        createdAt: ticket.createdAt,
      );
    } catch (e) {
      return null;
    }
  }

  static Future<List<ParkingTicket>> getParkingTickets(
      ParkingTicketStatus status) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('ParkingTickets')
          .where('userId', isEqualTo: ProfileCubit.instance.user?.id)
          .where('status', isEqualTo: status.value)
          .orderBy('createdAt', descending: true)
          .get();

      print("🚨🚨🚨🚨🚨");
      print(querySnapshot.docs);

      return querySnapshot.docs.map((doc) {
        final ticketJson = Map<String, dynamic>.from(doc.data());
        ticketJson['id'] = doc.id;

        print(ticketJson);
        print(ticketJson.runtimeType);

        try {
          return ParkingTicket.fromJson(ticketJson);
        } catch (e) {
          print(e);
          return ParkingTicket.fromJson(ticketJson);
        }
      }).toList();
    } catch (e) {
      print("🚨🚨🚨🚨🚨");
      print(e);
      return [];
    }
  }

  static Future<void> updateParkingTicketCompleted(String ticketId) async {
    try {
      await FirebaseFirestore.instance
          .collection('ParkingTickets')
          .doc(ticketId)
          .update({'status': ParkingTicketStatus.completed.value});
    } catch (e) {
      print("🚨🚨🚨");
      print(e);
    }
  }

  static Future<void> updateParkingTicketEndingTime(
      String ticketId, DateTime newDate) async {
    try {
      await FirebaseFirestore.instance
          .collection('ParkingTickets')
          .doc(ticketId)
          .update({'to': newDate.toIso8601String()});
    } catch (e) {
      print(" ");
      print(e);
    }
  }
}
