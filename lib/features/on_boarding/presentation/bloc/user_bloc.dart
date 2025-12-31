import 'package:ecomm_422/core/constants/app_constants.dart';
import 'package:ecomm_422/core/constants/app_urls.dart';
import 'package:ecomm_422/core/services/api_service.dart';
import 'package:ecomm_422/features/on_boarding/presentation/bloc/user_event.dart';
import 'package:ecomm_422/features/on_boarding/presentation/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  APIService apiService;

  UserBloc({required this.apiService}) : super(UserInitialState()) {
    on<UserRegisterEvent>((event, emit) async {
      emit(UserLoadingState());

      try {
        var responseBody = await apiService.postAPI(
          url: AppUrls.sign_up_url,
          mBody: {
            "name": event.name,
            "mobile_number": event.mobNo,
            "email": event.email,
            "password": event.pass,
          },
        );

        if (responseBody["status"]) {
          emit(UserSuccessState());
          ///if you want to navigate from register page to directly on HOME page
          ///then store token value in prefs
        } else {
          emit(UserFailureState(errorMsg: responseBody["message"]));
        }
      } catch (e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });

    on<UserAuthenticateEvent>((event, emit) async{
      emit(UserLoadingState());

      try {
        var responseBody = await apiService.postAPI(
          url: AppUrls.login_url,
          mBody: {
            "email" : event.email,
            "password" : event.pass
          },
        );

        if (responseBody["status"]) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(AppConstants.prefUserToken, responseBody["tokan"]);
          emit(UserSuccessState());
        } else {
          emit(UserFailureState(errorMsg: responseBody["message"]));
        }
      } catch (e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });
  }
}
