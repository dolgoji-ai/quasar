class Member {
  final String name;
  final String phoneNumber;

  Member({required this.name, required this.phoneNumber});

  Map<String, dynamic> toJson() {
    return {'name': name, 'phoneNumber': phoneNumber};
  }

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }
}
