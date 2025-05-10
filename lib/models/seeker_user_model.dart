import 'user_role.dart';

class SeekerUserModel {
  final int id;
  final String name;
  final String email;
  final String? address;
  final String? phoneNumber;
  final String? gender;
  final UserRole role;
  final String? profilePhoto;
  final String? dateOfBirth;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SeekerUserModel({
    required this.id,
    required this.name,
    required this.email,
    this.address,
    this.phoneNumber,
    this.gender,
    required this.role,
    this.profilePhoto,
    this.dateOfBirth,
    this.createdAt,
    this.updatedAt,
  });

  factory SeekerUserModel.fromJson(Map<String, dynamic> json) {
    return SeekerUserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      address: json['address'],
      phoneNumber: json['phone_number'],
      gender: json['gender'],
      role: UserRoleExt.fromString(json['role']) ?? UserRole.seeker,
      profilePhoto: json['profile_photo'],
      dateOfBirth: json['date_of_birth'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'phone_number': phoneNumber,
      'gender': gender,
      'role': role.toJson(),
      'profile_photo': profilePhoto,
      'date_of_birth': dateOfBirth,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
