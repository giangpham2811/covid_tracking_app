String mathFunc(Match match) {
  return '${match[1]}.';
}

RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

const String HomeViewRoute = '/';
const String GlobalViewRoute = '/global';
const String CountryViewRoute = '/country';
const String FaqsViewRoute = '/faqs';
const String CountryDetailsViewRoute = '/countryDetails';
const String AccountViewRoute = '/account';
const String FavoriteViewRoute = '/favorite';
const String SignInViewRoute = '/signIn';
const String SignUpViewRoute = '/signUp';
const String ResetPasswordViewRoute = '/resetPassword';

List<String> routeList = <String>{
  GlobalViewRoute,
  CountryViewRoute,
  FaqsViewRoute,
  FavoriteViewRoute,
} as List<String>;

//To Validate email
String? validateEmail(String value) {
  const Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final RegExp regex = RegExp(pattern.toString());
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}
