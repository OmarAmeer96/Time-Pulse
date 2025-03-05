import 'package:flutter_bloc/flutter_bloc.dart';
part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  int currentIndex = 0;
  MainCubit() : super(MainInitial());
  changeIndex(int index) {
    currentIndex = index;
    emit(IndexChanged());
  }
}
