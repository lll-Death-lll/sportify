part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

@immutable
sealed class AuthActionState extends AuthState {}

final class AuthInitial extends AuthState {}

final class AuthCompletedState extends AuthState {
  final String clientId;

  AuthCompletedState({required this.clientId});
}

final class AuthSuccessState extends AuthState {}

final class AuthInProcessState extends AuthState {}

final class AuthFailureState extends AuthState {}
