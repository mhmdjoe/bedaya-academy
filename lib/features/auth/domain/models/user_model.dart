enum UserRole { student, teacher }

class UserModel {
  final String id;
  final String email;
  final String name;
  final UserRole role;
  final String? photoUrl;
  
  // Teacher specific fields
  final String? expertise;
  final String? bio;
  final int? experienceYears;
  final List<String>? subjects;
  final double? sessionPrice;
  final double rating;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.photoUrl,
    this.expertise,
    this.bio,
    this.experienceYears,
    this.subjects,
    this.sessionPrice,
    this.rating = 4.5,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role.index,
      'photoUrl': photoUrl,
      'expertise': expertise,
      'bio': bio,
      'experienceYears': experienceYears,
      'subjects': subjects,
      'sessionPrice': sessionPrice,
      'rating': rating,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      role: UserRole.values[json['role']],
      photoUrl: json['photoUrl'],
      expertise: json['expertise'],
      bio: json['bio'],
      experienceYears: json['experienceYears'],
      subjects: json['subjects'] != null ? List<String>.from(json['subjects']) : null,
      sessionPrice: json['sessionPrice'],
      rating: json['rating'] ?? 4.5,
    );
  }
}
