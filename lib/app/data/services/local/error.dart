class LocalError {
  const LocalError({required this.message, this.code});

  final String message;
  final int? code;

  @override
  String toString() => 'LocalError(message: $message, code: $code)';
}
