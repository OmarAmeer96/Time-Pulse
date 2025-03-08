abstract class VacationsState {}

class VacationsInitial extends VacationsState {}

class VacationsLoading extends VacationsState {}

class VacationsLoaded extends VacationsState {}

class EmptyVacations extends VacationsState {}

class VacationsError extends VacationsState {
  final String message;
  VacationsError(this.message);
}
