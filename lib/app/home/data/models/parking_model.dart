class ParkingModel {
  final String placeId;
  String? name;
  num? latitude;
  num? longitude;
  String? vicinity;
  List<String>? types;
  num? rating;
  int? userRatingsTotal;
  bool? openNow;
  List<Photo>? photos;

  ParkingModel({
    required this.placeId,
    this.name,
    this.latitude,
    this.longitude,
    this.vicinity,
    this.types,
    this.rating,
    this.userRatingsTotal,
    this.openNow,
    this.photos,
  });

  factory ParkingModel.fromJson(Map<String, dynamic> json) {
    return ParkingModel(
      placeId: json['place_id'],
      name: json['name'],
      latitude: json['geometry']?['location']?['lat'],
      longitude: json['geometry']?['location']?['lng'],
      vicinity: json['vicinity'],
      types: (json['types'] as List<dynamic>? ?? []).cast<String>(),
      rating: json['rating'],
      userRatingsTotal: json['user_ratings_total'],
      openNow: json['opening_hours']?['open_now'], // Safely access 'open_now'
      photos: (json['photos'] as List<dynamic>?)
          ?.map((photoJson) => Photo.fromJson(photoJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place_id': placeId,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'vicinity': vicinity,
      'types': types,
      'rating': rating,
      'user_ratings_total': userRatingsTotal,
      'opening_hours': {
        'open_now': openNow,
      },
      'photos': photos?.map((photo) => photo.toJson()).toList(),
    };
  }
}

class Photo {
  String? photoReference;
  num? height;
  num? width;

  Photo({
    this.photoReference,
    this.height,
    this.width,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      photoReference: json['photo_reference'],
      height: json['height'],
      width: json['width'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'photo_reference': photoReference,
      'height': height,
      'width': width,
    };
  }
}
