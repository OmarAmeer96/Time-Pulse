part of 'history_cubit.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {}

class EmptyHistory extends HistoryState {}
