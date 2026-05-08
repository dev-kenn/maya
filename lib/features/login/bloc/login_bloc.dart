import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

    LoginBloc(this.authRepository)
      : super(const LoginState()) {
    on<UsernameChanged>(_onUsernameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutRequested>(_logout);
  }

  void _logout(
    LogoutRequested event,
    Emitter<LoginState> emit
  ) {
    emit(LoginUnAuthenticated());
  }

  void _onUsernameChanged(
    UsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(username: event.username));
  }

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    
    String username = state.username;
    String password = state.password;

    if (username.isEmpty || password.isEmpty) {
      emit(LoginFailure(errorMessage: 'Please enter username and password'));
      return;
    }
    
    emit(LoginLoading());

    try {
      final token = await authRepository.login(
        username: username,
        password: password,
      );
      
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }
}