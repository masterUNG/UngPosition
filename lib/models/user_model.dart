import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String gender;
  final String user;
  final String password;
  final String lat;
  final String lng;
  UserModel({
    this.id,
    this.name,
    this.gender,
    this.user,
    this.password,
    this.lat,
    this.lng,
  });

  UserModel copyWith({
    String id,
    String name,
    String gender,
    String user,
    String password,
    String lat,
    String lng,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      user: user ?? this.user,
      password: password ?? this.password,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'user': user,
      'password': password,
      'lat': lat,
      'lng': lng,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      gender: map['gender'],
      user: map['user'],
      password: map['password'],
      lat: map['lat'],
      lng: map['lng'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, gender: $gender, user: $user, password: $password, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.id == id &&
      other.name == name &&
      other.gender == gender &&
      other.user == user &&
      other.password == password &&
      other.lat == lat &&
      other.lng == lng;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      gender.hashCode ^
      user.hashCode ^
      password.hashCode ^
      lat.hashCode ^
      lng.hashCode;
  }
}
