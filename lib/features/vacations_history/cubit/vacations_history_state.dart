part of 'vacations_history_cubit.dart';

abstract class VacationsHistoryState {}

class VacationsHistoryInitial extends VacationsHistoryState {}

class VacationsHistoryLoading extends VacationsHistoryState {}

class VacationsHistoryLoaded extends VacationsHistoryState {}

class EmptyVacationsHistory extends VacationsHistoryState {}
