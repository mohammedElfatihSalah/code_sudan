import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DemoLocalizations {
  DemoLocalizations(this.locale);

  final Locale locale;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'login_page': 'Login Page',
      'login_info': 'Login Information',
      'enter_email': 'Enter Email',
      'enter_password': 'Enter Password',
      'login': 'Login',
      'no_account': 'No Account',
      'create_one': 'Create one',
      'register_page': 'Register Page',
      'user_name': 'User Name',
      'renter_password': 'Enter Password Again',
      'register': 'Sign Up',
      'register_info': 'Register Information',
      'have_account': 'Have Account!',
      'enter_name': 'Enter a UserName',
      'name_8_characters': 'Name must at least be 8 characters',
      'name_dont_start_with_number': 'Name shouldnot start with number',
      'enter_password': 'Enter Password',
      'password_8_characters': 'Password must be at least 8 charcaters',
      'must_contains_character': 'Must contains character',
      'must_contains_number': "Must contains number",
      'enter_email': 'Enter Email',
      'enter_valid_email': 'Enter a valid email',
      'password_not_equal': 'Password should be equal',
      'error': 'Error',
      'ok': 'Ok',
      'yes': 'Yes',
      'no': 'No',
      'process_is_success': 'Successful',
      'account_created': 'Account is succesfully created',
      'go_to_login': 'Login',
      'home': 'Home',
      'our_programs': 'Courses',
      'who_we_are': 'Who we are?',
      'are_u_sure_to_logout': 'Are you sure you want to logout?',
      'topics': 'Topics',
      'courses': 'Courses',
      'enroll': 'Enroll',
      'resume': 'Resume',
      'save_progress': 'Save Progress',
      
      'register_for_our_courses': 'Register in our programs'
    },
    'ar': {
      'login_page': 'صفحه الدخول',
      'login_info': 'معلومات الدخول',
      'enter_email': 'ادخل الايميل',
      'enter_password': 'ادخل كلمه السر',
      'login': 'تسجيل دخول',
      'no_account': 'لا يوجد حساب',
      'create_one': 'حساب جديد',
      'register_page': 'صفحه انشاء حساب',
      'user_name': 'اسم المستخدم',
      'renter_password': 'ادخل كلمه السر مره اخرى',
      'register': 'حساب جديد',
      'register_info': 'معلومات حساب جديد',
      'have_account': 'تملك حسابا',
      'enter_name': 'ادخل اسم مستخدم',
      'name_8_characters': 'الاسم يجب ان يكون اكثر من 8 حروف',
      'name_dont_start_with_number': 'الاسم يجب الا يبتدئ برقم',
      'enter_password': 'ادخل كلمه سر',
      'password_8_characters': 'كلمه السر يجب ان تتكون من 8 حروف على الاقل',
      'must_contains_character': 'يجب ان تحتوي على حرف',
      'must_contains_number': "يجب ان تحتوي على رقم",
      'enter_email': 'ادخل الايميل',
      'enter_valid_email': 'ادخل ايميل صحيح',
      'password_not_equal': 'كلمه السر يجب ان تكون متطابقه',
      'error': 'حدث خطأ ما',
      'ok': 'حسنا',
      'yes': 'حسنا',
      'no': 'لا',
      'process_is_success': 'نجحت العمليه',
      'account_created': 'تم انشاء حساب بنجاح',
      'go_to_login': 'تسجيل دخول',
      'home': 'الصفحة الرئيسيه',
      'our_programs': 'كورساتنا',
      'who_we_are': 'من نحن؟',
      'are_u_sure_to_logout': 'هل تود المغادرة؟',
      'topics': 'الدروس',
      'courses': 'الكورسات',
      'enroll': 'الالتحاق',
      'resume': 'المتابعه',
      'save_progress': 'حفظ التقدم',
      'register_for_our_courses': 'التسجيل لبرامجنا'
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode][key];
  }

  static const LocalizationsDelegate<DemoLocalizations> delegate =
      DemoLocalizationsDelegate();
}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) {
    return SynchronousFuture<DemoLocalizations>(DemoLocalizations(locale));
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}
