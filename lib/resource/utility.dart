
class Utility {
  static String emailAddressValidationPattern = r"([a-zA-Z0-9_@.])";
  static String password = r"[a-zA-Z0-9#!_@$%^&*-]";
  static String emailText = "email";
  static String passwordText = "password";
  static String nameEmptyValidation = "Name is required";
  static String emailEmptyValidation = "Email is required";
  static String kUserNameEmptyValidation = 'Please Enter Valid Email';
  static String kPasswordEmptyValidation = 'Please Enter Password';
  static String kPasswordLengthValidation = 'Must be more than 6 charater';
  static String kPasswordInValidValidation = 'Password Invalid';
  static String mobileNumberInValidValidation = "Mobile Number is required";
  static String bucketURL='gs://studentapp-a47d3.appspot.com';
  static String alphabetValidationPattern = r"[a-zA-Z]";
  static String alphabetSpaceValidationPattern = r"[a-zA-Z ]";
  static String alphabetDigitsValidationPattern = r"[a-zA-Z0-9]";
  static String alphabetDigitsSpaceValidationPattern = r"[a-zA-Z0-9 ]";

  static String alphabetDigitsSpacePlusValidationPattern = r"[a-zA-Z0-9+ ]";

  static String alphabetDigitsSpecialValidationPattern = r"[a-zA-Z0-9#$%_@.]";

  static String alphabetDigitsDashValidationPattern = r"[a-zA-Z0-9-]";
  static String digitsValidationPattern = r"[0-9]";

  static String assignmentNotDownloadMessage = "Assignment is not download until your course topic is not completed";
  static String assignmentNotUploadMessage = "Assignment is not upload until your course topic is not completed";
  static String assignmentUploadSuccessfullyMessage = "Assignment Upload Successfully";
  static String assignmentDownloadSuccessfullyMessage = "Assignment Download Successfully";
  static String assignmentDownloadProblemMessage = "Problem Downloading Assignment";
  static String passwordNotMatch ="Password and Conform password does not match!";
  static String termsConditions ="Terms & Conditions";
  static String termsConditionsMessage ="Please check Term Condition!";
  static String uploadingTitle ="Uploading Message";
  static String downloadingTitle ="Download Message";
  static String loginError ="Login Error";
  static String invalidPasswordMessage ="The password is invalid or the user does not have a password.";
  static String userNotExist ="User Not Exist!";
  static String notificationText =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  static String aboutUs =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. \n  \nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. \n \nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud ";
  static int kPasswordLength = 6;

  static Map<String, String> courseLogoText = {
    'CLanguage': 'assets/icons/cL.png',
    'C++': 'assets/icons/Cpp.png',
    'Dart': 'assets/icons/dartn.png',
    'Flutter': 'assets/icons/flutter.png'
  };


  static String validateUserName(String value) {
    Pattern pattern =r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    bool regex = new RegExp(pattern).hasMatch(value);
    if (value.isEmpty) {
      return kUserNameEmptyValidation;
    }else if(regex==false)
    {
      return kUserNameEmptyValidation;
    }
    return null;
  }

  static String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return kPasswordEmptyValidation;
    } else if (value.length < kPasswordLength) {
      return kPasswordLengthValidation;
    }
    return null;

  }
}
