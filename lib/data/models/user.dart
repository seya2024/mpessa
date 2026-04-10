class User {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String email;
  double balance;
  final String profilePicture;
  
  User({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    this.balance = 0.0,
    this.profilePicture = '',
  });
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      balance: json['balance']?.toDouble() ?? 0.0,
      profilePicture: json['profilePicture'] ?? '',
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'balance': balance,
      'profilePicture': profilePicture,
    };
  }
}