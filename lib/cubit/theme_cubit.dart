import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour7/cubit/theme_states.dart';
import '../../../shared/local/cash_helper.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  ThemeCubit() : super(ThemeInitialState());

  static ThemeCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  //تابع تغيير الثيم يعمل في حالتين
  //1- عند تشغيل البرنامج بحيث يتذكر آخر وضع للثيم
  //2- في حال الضغط على أيقونة تغيير الثيم

  void changeThemeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ThemeChangesModeState());
    } else {
      isDark = !isDark;
      CashHelper.putBoolean(
          key: 'isDark',
          value: isDark,
      )
          .then((value) {
        emit(ThemeChangesModeState());
      });
    }
  }
}
