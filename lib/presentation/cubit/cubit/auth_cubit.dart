// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:example_flutter_app/data/repository_imp/repository_imp.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._authRepositoryImp,
  ) : super(const AuthState.initial());

  final AuthRepositoryImp _authRepositoryImp;

  Future<void> init() async {
    emit(const AuthState.initial());
    try {
      final isAuth = await _authRepositoryImp.isLogged();
      if (isAuth) {
        emit(const AuthState.authenticated());
      } else {
        emit(const AuthState.unauthenticated());
      }
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(const AuthState.loading());
    try {
      await _authRepositoryImp.login(email, password);
      emit(const AuthState.authenticated());
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(const AuthState.loading());
    try {
      await _authRepositoryImp.logout();
      emit(const AuthState.unauthenticated());
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }
}
