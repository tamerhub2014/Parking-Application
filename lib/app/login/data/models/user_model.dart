enum LoginMethod {
  email("email"),
  google("google"),
  ;

  final String text;
  const LoginMethod(this.text);

  static LoginMethod fromString(String value) {
    switch (value) {
      case 'email':
        return LoginMethod.email;
      case 'google':
        return LoginMethod.google;
      default:
        return LoginMethod.email;
    }
  }
}

class UserModel {
  final String id;
  String name;
  String email;
  UserLocation? location;
  LoginMethod loginMethod;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      this.location,
      required this.loginMethod});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      location: json['location'] != null
          ? UserLocation.fromJson(json['location'])
          : null,
      loginMethod: LoginMethod.fromString(json['loginMethod']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'location': location?.toJson(),
      'loginMethod': loginMethod.text,
    };
  }
}

class UserLocation {
  String? country;
  String? city;
  String? longitude;
  String? latitude;

  UserLocation({this.country, this.city, this.longitude, this.latitude});

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      country: json['country'],
      city: json['city'],
      longitude: json['longitude'],
      latitude: json['latitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'city': city,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  @override
  String toString() {
    return '$city, $country';
  }
}
