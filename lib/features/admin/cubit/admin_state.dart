abstract class AdminState {}

class AdminPageInitial extends AdminState {}

class AdminPageLoading extends AdminState {}

class AdminPageLoaded extends AdminState {}

class AdminPageError extends AdminState {
  final String message;
  AdminPageError(this.message);
}

class EmployeeAdding extends AdminState {}

class EmployeeAdded extends AdminState {}
