part of 'user_cubit.dart';

abstract class UserState {
  String employeeName;
  UserState({
    this.employeeName = '',
  });
}

class UserInitial extends UserState {
  UserInitial({super.employeeName});
}

class UserCheckedIn extends UserState {
  UserCheckedIn({super.employeeName});
}

class UserCheckedOut extends UserState {
  UserCheckedOut({super.employeeName});
}

class UserNotInCompanyArea extends UserState {
  UserNotInCompanyArea({super.employeeName});
}

class UserLocationLoading extends UserState {
  UserLocationLoading({super.employeeName});
}

class UserLocationLoaded extends UserState {
  UserLocationLoaded({super.employeeName});
}
