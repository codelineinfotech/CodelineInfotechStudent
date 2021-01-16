class Utility {
  static String alphabetValidationPattern = r"[a-zA-Z]";
  static String alphabetSpaceValidationPattern = r"[a-zA-Z ]";
  static String alphabetDigitsValidationPattern = r"[a-zA-Z0-9]";
  static String alphabetDigitsSpaceValidationPattern = r"[a-zA-Z0-9 ]";
  static String alphabetDigitsSpecialValidationPattern = r"[a-zA-Z0-9_@.]";
  static String alphabetDigitsDashValidationPattern = r"[a-zA-Z0-9-]";
  static String digitsValidationPattern = r"[0-9]";
  static String emailAddressValidationPattern = r"([a-zA-Z0-9_@.]+)";

  // static String emailAddressValidationPattern = r"^([a-z]+)$";
  // r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
}
