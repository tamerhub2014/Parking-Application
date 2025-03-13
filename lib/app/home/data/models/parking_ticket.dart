import 'package:flutter_parking_ui_new/app/home/data/models/parking_model.dart';

enum ParkingTicketStatus {
  pending("PENDING"),
  completed("COMPLETED");

  final String value;

  const ParkingTicketStatus(this.value);

  static ParkingTicketStatus fromString(String value) {
    for (ParkingTicketStatus status in ParkingTicketStatus.values) {
      if (status.value == value) {
        return status;
      }
    }
    return ParkingTicketStatus.pending;
  }
}

class ParkingTicket {
  final String id;
  final String userId;
  ParkingModel? parking;
  ParkingTicketStatus? status;
  DateTime? from;
  DateTime? to;
  DateTime? createdAt;

  ParkingTicket({
    required this.id,
    required this.userId,
    this.parking,
    this.status,
    this.from,
    this.to,
    this.createdAt,
  });

  factory ParkingTicket.fromJson(Map<String, dynamic> json) {
    return ParkingTicket(
      id: json["id"],
      userId: json["userId"],
      parking: ParkingModel.fromJson(json["parking"]),
      status: ParkingTicketStatus.fromString(json["status"]),
      from: DateTime.parse(json["from"]),
      to: DateTime.parse(json["to"]),
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "parking": parking?.toJson(),
      "status": status?.value,
      "from": from?.toIso8601String(),
      "to": to?.toIso8601String(),
      "createdAt": createdAt?.toIso8601String(),
    };
  }
}
