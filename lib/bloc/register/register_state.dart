class RegisterState {
  final String firstName;
  final String secondName;
  final String username;
  final String password;
  final String image;
  final List<String> contactUserIds;
  final bool isUserNameValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String responeMessage;

  RegisterState({
    required this.firstName,
    required this.secondName,
    required this.username,
    required this.password,
    required this.image,
    required this.contactUserIds,
    required this.isUserNameValid,
    required this.isPasswordValid,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    required this.responeMessage,
  });

  factory RegisterState.initial() {
    return RegisterState(
      firstName: "",
      secondName: "",
      username: "",
      password: "",
      image: "",
      contactUserIds: [],
      isUserNameValid: false,
      isPasswordValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      responeMessage: "",
    );
  }

  factory RegisterState.registering(
      String firstName,
      String secondName,
      String username,
      String password,
      String image,
      List<String> contactUserIds) {
    return RegisterState(
      firstName: firstName,
      secondName: secondName,
      username: username,
      password: password,
      image: image,
      contactUserIds: contactUserIds,
      isUserNameValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      responeMessage: "",
    );
  }

  factory RegisterState.failure(
      String firstName,
      String secondName,
      String username,
      String password,
      String image,
      List<String> contactUserIds,
      String responeMessage) {
    return RegisterState(
      firstName: firstName,
      secondName: secondName,
      username: username,
      password: password,
      image: image,
      contactUserIds: contactUserIds,
      isUserNameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      responeMessage: responeMessage,
    );
  }

  factory RegisterState.success(
      String firstName,
      String secondName,
      String username,
      String password,
      String image,
      List<String> contactUserIds,
      String responeMessage) {
    return RegisterState(
      firstName: firstName,
      secondName: secondName,
      username: username,
      password: password,
      image: image,
      contactUserIds: contactUserIds,
      isUserNameValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      responeMessage: responeMessage,
    );
  }

  RegisterState copyWith({
    String? firstName,
    String? secondName,
    String? username,
    String? password,
    String? image,
    List<String>? contactUserIds,
    bool? isUserNameValid,
    bool? isPasswordValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? responeMessage,
  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      username: username ?? this.username,
      password: password ?? this.password,
      image: image ?? this.image,
      contactUserIds: contactUserIds ?? this.contactUserIds,
      isUserNameValid: isUserNameValid ?? this.isUserNameValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      responeMessage: responeMessage ?? this.responeMessage,
    );
  }
}
