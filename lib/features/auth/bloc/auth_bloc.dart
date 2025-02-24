import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sportify/features/auth/bloc/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
