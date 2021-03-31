abstract class LoginState {
  const LoginState();
}

class LoginFormInitial extends LoginState {
  const LoginFormInitial();
}

class LoginFormInProgress extends LoginState {
  const LoginFormInProgress();
}

class LoginFormHasError extends LoginState {
  const LoginFormHasError();
}
