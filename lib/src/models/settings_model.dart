class PasswordChangeInfo {
  final String oldPassword;
  final String newPassword;
  final String confirmNewPassword;

  PasswordChangeInfo({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });
}
