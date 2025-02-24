part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

@immutable
sealed class AuthActionState extends AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSuccessState extends AuthState {}

final class AuthInProcessState extends AuthActionState {}

final class AuthFailureState extends AuthState {}
