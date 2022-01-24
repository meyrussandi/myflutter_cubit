part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthShowPassword extends AuthState {}
class AuthHidePassword extends AuthState {}

class Authenticated extends AuthState{
  final UserModel userModel;
  final String token;

  const Authenticated({required this.userModel,required this.token});

  @override
  List<Object> get props => [userModel,token];
}

class NoAuthenticated extends AuthState {}

class AuthSuccess extends AuthState{
  final String message;
  const AuthSuccess(this.message);

  @override
  List<Object> get props => [];
}

class AuthFailed extends AuthState{

  final String message;
  const AuthFailed(this.message);

  @override
  List<Object> get props => [];
}

