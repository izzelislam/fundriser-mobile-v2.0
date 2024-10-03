import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fundriser/model/login_model.dart';
import 'package:fundriser/model/login_success_model.dart';
import 'package:fundriser/model/profile_model.dart';
import 'package:fundriser/service/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      try {
        emit(AuthLoading());
        LoginSuccess res = await AuthService().login(event.data);
        await AuthService().saveCredential(res.token!);
        ProfileModel profile = await AuthService().getProfile();
        emit(AuthSuccess(profile));
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    });

    on<AuthGetProfile>((event, emit) async {
      try {
        emit(AuthLoading());
        ProfileModel profile = await AuthService().getProfile();
        emit(AuthSuccess(profile));
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    });

    on<AuthLogout>((event, emit) async {
      try {
        emit(AuthLoading());
        await AuthService().logOut();
        emit(AuthInitial());
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    });

    on<AuthUpdatePassword>((event, emit) async {
      try {
        emit(AuthLoading());
        await AuthService().changePassword(event.oldPassword, event.newPassword, event.confirmPassword);
         ProfileModel profile = await AuthService().getProfile();
        emit(AuthSuccess(profile));
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    });
  }

}
