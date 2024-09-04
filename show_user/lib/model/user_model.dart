import 'address.dart';
import 'company.dart';

class User {
  final int id;
  final String name;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      address: Address.fromJson(json['address']), // Map address
      phone: json['phone'],
      website: json['website'],
      company: Company.fromJson(json['company']), // Map company
    );
  }
}






