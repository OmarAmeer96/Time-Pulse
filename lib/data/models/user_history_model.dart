class UserHistoryModel {
  final String checkInTime;
  final String checkOutTime;
  final String email;
  final String employeeId;

  UserHistoryModel(
      {required this.checkInTime,
      required this.checkOutTime,
      required this.email,
      required this.employeeId});
}
