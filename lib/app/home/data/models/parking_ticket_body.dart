import 'package:flutter_parking_ui_new/app/home/data/models/parking_model.dart';

import 'parking_ticket.dart';

class ParkingTicketBody {
  String? userId;
  ParkingModel? parking;
  ParkingTicketStatus? status;
  DateTime? from;
  DateTime? to;
  DateTime? createdAt;

  ParkingTicketBody({
    required this.userId,
    required this.parking,
    this.status = ParkingTicketStatus.pending,
    required this.from,
    required this.to,
    this.createdAt,
  });

  factory ParkingTicketBody.fromJson(Map<String, dynamic> json) {
    return ParkingTicketBody(
      userId: json["userId"],
      parking: ParkingModel.fromJson(json["parking"]),
      status: ParkingTicketStatus.fromString(json["status"]),
      from: DateTime.tryParse(json["from"] ?? "")?.toLocal(),
      to: DateTime.tryParse(json["to"] ?? "")?.toLocal(),
      createdAt: DateTime.tryParse(json["createdAt"] ?? "")?.toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "parking": parking?.toJson(),
      "status": status?.value,
      "from": from?.toUtc().toIso8601String(),
      "to": to?.toUtc().toIso8601String(),
      "createdAt": createdAt?.toUtc().toIso8601String() ??
          DateTime.now().toUtc().toIso8601String(),
    };
  }
}
