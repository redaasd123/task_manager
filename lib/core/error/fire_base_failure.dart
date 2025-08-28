abstract class Failure {
  final String message;
  const Failure(this.message);
}

class FirebaseFailure extends Failure {
  const FirebaseFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(String message) : super(message);
}
