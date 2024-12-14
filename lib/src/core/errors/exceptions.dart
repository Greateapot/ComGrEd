class ColorConverterInvalidValueException implements Exception {
  final String? message;

  const ColorConverterInvalidValueException([this.message]);

  @override
  String toString() => message != null
      ? 'ColorConverterInvalidValueException: $message'
      : 'ColorConverterInvalidValueException';
}
