// App
const String appTitle = 'Bex Movil';

// Networking and APIs
const String baseUrl = 'https://demo.bexdeliveries.com/api/v1/';
const String defaultApiKey = 'ff957763c54c44d8b00e5e082bc76cb0';
const String defaultSources = 'bbc-news, abc-news, al-jazeera-english';

// Storage and Databases
const String articlesTableName = 'articles_table';
const String databaseName = 'app_database';

//routes\

class Routes {
  static const splashRoute = '/splash';
  static const politicsRoute = '/politics';
  static const companyRoute = '/company';
  static const permissionRoute = '/permission';
  static const loginRoute = '/login';
  static const homeRoute = '/home';
  static const categoryRoute = '/category';
  static const productRoute = '/product';
  static const calendarRoute = '/calendar';
  static const productivityRoute = '/productivity';
  static const selectEnterpriseRoute = '/select-enterprise';
  static const databaseRoute = '/database';
}

// Form Error

final RegExp emailValidatorRegExp =
    RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
const String kEmailNullError = 'Por favor ingresa un correo';
const String kInvalidEmailError = 'Porfavor ingresa un correo válido';
const String kPassNullError = 'Porfavor ingresa una contraseña';
const String kShortPassError = 'La contraseña es demasiado corta';
const String kMatchPassError = 'La contraseña no coindice';
const String kNameNullError = 'Por favor ingresa un nombre';
const String kPhoneNumberNullError = 'Por favor ingresa tu número de telefono';
const String kAddressNullError = 'Por favor ingresa tu dirección';

const String buttonTextDefault = "Permitir";
const String buttonTextSuccess = "Continuar";
const String buttonTextPermanentlyDenied = "Configuración";
const String titleDefault = "Permiso necesario";
const String displayMessageDefault =
    "Para brindarle la mejor experiencia de usuario, necesitamos algunos permisos. Por favor permítelo.";
const String displayMessageSuccess =
    "Éxito, se otorgaron todos los permisos. Por favor, haga clic en el botón de abajo para continuar.";
const String displayMessageDenied =
    "Para brindarle la mejor experiencia de usuario, necesitamos algunos permisos, pero parece que lo negó.";
const String displayMessagePermanentlydenied =
    "Para brindarle la mejor experiencia de usuario, necesitamos algunos permisos, pero parece que lo denegó permanentemente. Vaya a la configuración y actívela manualmente para continuar.";

class Assets {
  static const String background1 = 'assets/background_1.jpg';
  static const String bank = 'assets/bank.svg';
  static const String coloring = 'assets/coloring.svg';
  static const String cod = 'assets/cod.svg';
  static const String debit = 'assets/debit.svg';
  static const String email = 'assets/email.svg';
  static const String eyeMakeup = 'assets/eye_makeup.svg';
  static const String facebook = 'assets/facebook.svg';
  static const String google = 'assets/google.svg';
  static const String haircut = 'assets/haircut.svg';
  static const String hairstyle = 'assets/hairstyle.svg';
  static const String language = 'assets/language.svg';
  static const String logo = 'assets/logo.svg';
  static const String makeUp = 'assets/make_up.svg';
  static const String map = 'assets/map.png';
  static const String multipleImage = 'assets/multiple_image.svg';
  static const String nails = 'assets/nails.svg';
  static const String offer = 'assets/offer.svg';
  static const String onBoarding1 = 'assets/on_boarding_1.jpg';
  static const String onBoarding2 = 'assets/on_boarding_2.jpg';
  static const String onBoarding3 = 'assets/on_boarding_3.jpg';
  static const String otp = 'assets/otp.svg';
  static const String paypal = 'assets/paypal.svg';
  static const String profilePhoto =
      'https://i.pinimg.com/564x/d3/c0/dc/d3c0dc09efe8a84160c4639003d5f1b5.jpg';
  static const String shampoo = 'assets/shampoo.svg';
  static const String shaving = 'assets/shaving.svg';
  static const String signIn = 'assets/sign_in.jpg';
  static const String spa = 'assets/spa.svg';
}

class Const {
  static const int splashDuration = 3;
  static const double textFieldRadius = 12;

  static const double buttonRadius = 15;
  static const double padding = 8;
  static const double margin = 18;
  static const double radius = 12;
  static const double space5 = 5;
  static const double space8 = 8;
  static const double space12 = 12;
  static const double space15 = 15;
  static const double space25 = 25;
  static const double space40 = 40;
  static const double space50 = 50;
}
