enum UserRole {
  patient,
  seeker,
}

extension UserRoleExt on UserRole {
  String toJson() {
    switch (this) {
      case UserRole.patient:
        return 'donor';
      case UserRole.seeker:
        return 'seeker';
    }
  }

  static UserRole? fromString(String? role) {
    switch (role) {
      case 'donor':
        return UserRole.patient;
      case 'seeker':
        return UserRole.seeker;
      default:
        return null;
    }
  }
}
