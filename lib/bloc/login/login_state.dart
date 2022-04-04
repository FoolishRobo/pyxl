class LoginState {
  final String userName;
  final String password;
  final bool isusernameValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  LoginState({
    required this.userName,
    required this.password,
    required this.isusernameValid,
    required this.isPasswordValid,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory LoginState.initial() {
    return LoginState(
      userName: "",
      password: "",
      isusernameValid: false,
      isPasswordValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.loading(String userName, String password) {
    return LoginState(
      userName: userName,
      password: password,
      isusernameValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory LoginState.failure(String userName, String password) {
    return LoginState(
      userName: userName,
      password: password,
      isusernameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory LoginState.success(String userName, String password) {
    return LoginState(
      userName: userName,
      password: password,
      isusernameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  LoginState copyWith({
    String? userName,
    String? password,
    bool? isusernameValid,
    bool? isPasswordValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return LoginState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      isusernameValid: isusernameValid ?? this.isusernameValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
