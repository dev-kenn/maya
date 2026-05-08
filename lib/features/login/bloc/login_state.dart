part of 'login_bloc.dart';


class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure({
    required this.errorMessage,
  });
}

class LoginUnAuthenticated extends LoginState {}

class LoginState extends Equatable {
  final String username;
  final String password;
  final String token;
  final String userId;

  const LoginState({
    this.username = '',
    this.password = '',
    this.token = '',
    this.userId = '',
  });

  LoginState copyWith({
    String? username,
    String? password,
    String? token,
    String? userId,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      token: token ?? this.token,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object> get props => [
        username,
        password,
        token,
        userId,
      ];
}