sealed class Failure {
  final String message;

  const Failure(this.message);

  @override
  String toString() => message;
}

class SensorFailure extends Failure {
  const SensorFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure([String message = 'An unexpected error occurred'])
      : super(message);
}
