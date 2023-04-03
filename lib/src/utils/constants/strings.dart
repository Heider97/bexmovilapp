// App
const String appTitle = 'Bex Movil';

// Networking and APIs
const String baseUrl = 'https://demo.bexdeliveries.com/api/v1/';
const String defaultApiKey = 'ff957763c54c44d8b00e5e082bc76cb0';
const String defaultSources = 'bbc-news, abc-news, al-jazeera-english';

// Storage and Databases
const String articlesTableName = 'articles_table';
const String databaseName = 'app_database';

//routes
const splashRoute = '/splash';
const politicsRoute = '/politics';
const companyRoute = '/company';
const permissionRoute = '/permission';
const loginRoute = '/login';
const homeRoute = '/home';
const categoryRoute = '/category';
const productRoute = '/product';

const databaseRoute = '/database';



// Form Error
final RegExp emailValidatorRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
const String kEmailNullError = 'Por favor ingresa un correo';
const String kInvalidEmailError = 'Porfavor ingresa un correo válido';
const String kPassNullError = 'Porfavor ingresa una contraseña';
const String kShortPassError = 'La contraseña es demasiado corta';
const String kMatchPassError = 'La contraseña no coindice';
const String kNameNullError = 'Porfavor ingresa un nombre';
const String kPhoneNumberNullError = 'Porfavor ingresa tu número de telefono';
const String kAddressNullError = 'Porfavor ingresa tu dirección';

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
