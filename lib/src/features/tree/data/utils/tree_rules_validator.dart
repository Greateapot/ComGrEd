class TreeRulesValidator {
  TreeRulesValidator._();

  static final RegExp alphabet = RegExp(r'[01\{\}\[\]]+');

  static bool validate(String input) => alphabet.hasMatch(input);
}
