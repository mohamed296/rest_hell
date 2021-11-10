abstract class AuthState {}

class AuthInatioalState extends AuthState {}

class ChangeAuth extends AuthState {}

class ShowPassword extends AuthState {}

class AuthLodingState extends AuthState {}

class AuthScassesState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;
  AuthErrorState({
    required this.error,
  });
}

class UserLodingState extends AuthState {}

class UserScassesState extends AuthState {}

class UserErrorState extends AuthState {
  final String error;
  UserErrorState({
    required this.error,
  });
}
