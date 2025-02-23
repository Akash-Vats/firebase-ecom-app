class UserModel1 {
  final String uid;
  final String userName;
  final String email;
  final String phone;
  final String userImg;
  final String userDeviceToken;
  final String country;
  final String userAddress;
  final String street;
  final String userCity;
  final bool isAdmin;
  final bool isActive;
  final dynamic createdOn;

  UserModel1({
    required this.uid,
    required this.userName,
    required this.email,
    required this.phone,
    required this.userImg,
    required this.userDeviceToken,
    required this.country,
    required this.userAddress,
    required this.street,
    required this.userCity,
    required this.isAdmin,
    required this.isActive,
    this.createdOn,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
      'phone': phone,
      'userImg': userImg,
      'userDeviceToken': userDeviceToken,
      'country': country,
      'userCity': userCity,
      'userAddress': userAddress,
      'street': street,
      'isAdmin': isAdmin,
      'isActive': isActive,
      'createdOn': createdOn,
    };
  }

  factory UserModel1.fromMap(Map<String, dynamic> map) {
    return UserModel1(
      uid: map['uid'] ?? '',
      userName: map['userName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      userImg: map['userImg'] ?? '',
      userDeviceToken: map['userDeviceToken'] ?? '',
      country: map['country'] ?? '',
      userAddress: map['userAddress'] ?? '',
      street: map['street'] ?? '',
      userCity: map['userCity'] ?? '',
      isAdmin: map['isAdmin'] ?? false,
      createdOn: map['createdOn'],
      isActive: map['isActive'] ?? false,
    );
  }
}
