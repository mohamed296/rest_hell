import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_hell/shared/provider/app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInatioalState());
  static AppCubit get(context) => BlocProvider.of(context);
}
