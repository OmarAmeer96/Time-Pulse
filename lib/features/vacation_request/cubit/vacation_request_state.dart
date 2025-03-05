part of 'vacation_request_cubit.dart';

abstract class VacationRequestState {}

class VacationRequestInitial extends VacationRequestState {}

class VacationRequestLoading extends VacationRequestState {}

class VacationRequestLoaded extends VacationRequestState {}

class VacationRequestUnavailable extends VacationRequestState {}
