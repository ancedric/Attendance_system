class User {
  final String reference;
  final String name;
  final String email;

  User({required this.reference, required this.name, required this.email});

  Map<String, dynamic> toJson() => {
    "reference": reference,
    "name": name,
    "email": email,
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      reference: json['reference'],
      name: json['name'],
      email: json['email'],
    );
  }
}
