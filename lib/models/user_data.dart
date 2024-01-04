import 'dart:convert';

class UserData {
  String? userId;
  String? userType;
  bool? sound;

  UserData({required this.userId, required this.userType, required this.sound});

  Map<String, dynamic> toMap() => {
        "id": userId,
        "user_type": userType,
        "sound": sound,
      };

  factory UserData.fromMap(map) => UserData(
      userId: map['id'], userType: map['user_type'], sound: map['sound']);

  @override
  String toString() {
    return json.encoder.convert(toMap());
  }

  factory UserData.fomString(String data) =>
      UserData.fromMap(json.decoder.convert(data));
}
