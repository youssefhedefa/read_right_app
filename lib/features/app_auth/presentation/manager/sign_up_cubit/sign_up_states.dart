
abstract class SignUpState{}

class SignUpInitialState extends SignUpState{}

class SignUpLoadingState extends SignUpState{}

class SignUpSuccessState extends SignUpState{
  SignUpSuccessState();
}

class SignUpErrorState extends SignUpState{
  final String message;

  SignUpErrorState({required this.message});
}