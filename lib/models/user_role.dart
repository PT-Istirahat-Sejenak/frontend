enum UserRole {
  pendonor,
  pencari,
}

extension UserRoleExt on UserRole {
  String toJson() {
    switch (this) {
      case UserRole.pendonor:
        return 'pendonor';
      case UserRole.pencari:
        return 'pencari';
    }
  }

  static UserRole? fromString(String? role) {
    switch (role) {
      case 'pendonor':
        return UserRole.pendonor;
      case 'pencari':
        return UserRole.pencari;
      default:
        return null;
    }
  }
}
