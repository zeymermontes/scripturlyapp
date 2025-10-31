import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'es'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? esText = '',
  }) =>
      [enText, esText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // landing
  {
    'ny2nfvhp': {
      'en': 'Meet Scripturly',
      'es': 'Conoce Scripturly',
    },
    '8cewtnkc': {
      'en': 'Your spiritual health companion',
      'es': 'Tu compañero de salud espiritual',
    },
    '8yutwj41': {
      'en':
          'I agree to Scripturly terms & conditions and acknowledge the Privacy Policy',
      'es':
          'Acepto los términos y condiciones de Scripturly y reconozco la Política de Privacidad.',
    },
    '2wh36y94': {
      'en': 'Create account',
      'es': 'Crear una cuenta',
    },
    'tus4urj1': {
      'en': 'Login',
      'es': 'Acceso',
    },
    '1g0uenun': {
      'en': 'Home',
      'es': 'Hogar',
    },
  },
  // createAccount
  {
    'wg0ynx9d': {
      'en': 'Meet Scripturly',
      'es': 'Conoce Scripturly',
    },
    'zrzfcw3p': {
      'en': 'Your spiritual health companion',
      'es': 'Tu compañero de salud espiritual',
    },
    'gb7r7kqh': {
      'en': 'Continue with Apple',
      'es': 'Continúa con Apple',
    },
    'ltah7pi2': {
      'en': 'Continue with Google',
      'es': 'Continúa con Google',
    },
    'lc16enoh': {
      'en': 'Continue with Email',
      'es': 'Continuar con el correo electrónico',
    },
    'owt9dmo4': {
      'en': 'Already have an account?',
      'es': '¿Ya tienes una cuenta?',
    },
    'u2q9wpzy': {
      'en': 'Sign In',
      'es': 'Iniciar sesión',
    },
    '5tz18tqp': {
      'en': 'Home',
      'es': 'Perfil',
    },
  },
  // viaEmail
  {
    'ur4vmthq': {
      'en': 'Welcome to Scripturly',
      'es': 'Conoce Scripturly',
    },
    '71pwlw58': {
      'en':
          'Create an account to access daily verses, custom reading plan, and more ',
      'es':
          'Crea una cuenta para acceder a versículos diarios, un plan de lectura personalizado y mucho más.',
    },
    '16dqfw5m': {
      'en': 'First name',
      'es': 'Nombre',
    },
    '2wls87tt': {
      'en': 'Last name',
      'es': 'Apellido',
    },
    'ihmd3wx8': {
      'en': 'Email address',
      'es': 'Correo electrónico',
    },
    'fmohp7fy': {
      'en': 'Password (8+ characters)',
      'es': 'Contraseña (8+ caracteres)',
    },
    'hzpin14p': {
      'en': 'Confirm password ',
      'es': 'Confirmar Contraseña',
    },
    'e1isxr5m': {
      'en':
          'By continuing, you agree to Scripturly Terms & Conditions and acknowledge the Privacy Policy',
      'es':
          'Al continuar, aceptas los Términos y Condiciones de Scripturly y reconoces la Política de Privacidad.',
    },
    'dajvjf6q': {
      'en': 'First name is required',
      'es': 'El nombre es obligatorio.',
    },
    'sfc0v2u0': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    'b254g3t1': {
      'en': 'Last name is required',
      'es': 'El apellido es obligatorio.',
    },
    '1205qfwb': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    'vapithav': {
      'en': 'Email address is required',
      'es': 'Se requiere una dirección de correo electrónico.',
    },
    '8oey7jgk': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    'lspupsjx': {
      'en': 'Password (8+ characters) is required',
      'es': 'Se requiere contraseña (de al menos 8 caracteres).',
    },
    '4u3wue10': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    '0dn6wr57': {
      'en': 'Confirm password  is required',
      'es': 'Se requiere confirmar la contraseña',
    },
    'tgyahicq': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    'gwc82xl9': {
      'en': 'Continue',
      'es': 'Continuar',
    },
    'pg3pmcm0': {
      'en': 'Home',
      'es': '',
    },
  },
  // Paywall
  {
    '2u81hs8u': {
      'en': 'Get immersed into the Word like never before',
      'es': 'Sumérgete en la Palabra como nunca antes.',
    },
    '182mrbzj': {
      'en': '14-day trial, then \$9.99/month',
      'es': 'Prueba gratuita de 14 días, luego \$9.99 al mes.',
    },
    'm4jd26qi': {
      'en': 'Remove ads',
      'es': 'Eliminar anuncios',
    },
    'gxzux53h': {
      'en': 'Never see adds',
      'es': 'Nunca verás anuncios',
    },
    'yqr3qkek': {
      'en': 'Remove ads',
      'es': 'Eliminar anuncios',
    },
    'h1m2edjr': {
      'en': 'Never see adds',
      'es': 'Nunca verás anuncios',
    },
    '54qj02jm': {
      'en': 'Remove ads',
      'es': 'Eliminar anuncios',
    },
    'o1i2bl6r': {
      'en': 'Never see adds',
      'es': 'Nunca verás anuncios',
    },
    'zpnmlh7o': {
      'en': 'Remove ads',
      'es': 'Eliminar anuncios',
    },
    'ubv01v7z': {
      'en': 'Never see adds',
      'es': 'Nunca verás anuncios',
    },
    'cikabd7f': {
      'en': 'Remove ads',
      'es': 'Eliminar anuncios',
    },
    'mvjsfwbg': {
      'en': 'Never see adds',
      'es': 'Nunca verás anuncios',
    },
    'o0ofygsl': {
      'en': 'Start your plan today',
      'es': 'Empieza tu plan hoy',
    },
    '4fc8ea3i': {
      'en': 'Home',
      'es': '',
    },
  },
  // Read
  {
    'lpf0ivxc': {
      'en': 'Read',
      'es': 'Perfil',
    },
  },
  // ConfirmSocialLogin
  {
    'f73td1zh': {
      'en': 'Welcome to Scripturly',
      'es': 'Bienvenido a Scripturly',
    },
    '0955jmi4': {
      'en':
          'Create an account to access daily verses, custom reading plan, and more ',
      'es':
          'Crea una cuenta para acceder a versículos diarios, un plan de lectura personalizado y mucho más.',
    },
    'r77frmu9': {
      'en': 'First name',
      'es': 'Nombre de pila',
    },
    'ju5b7e84': {
      'en': 'Last name',
      'es': 'Apellido',
    },
    '48djvegm': {
      'en': 'Email address',
      'es': 'Correo electrónico',
    },
    'h4zj1mzd': {
      'en':
          'By continuing, you agree to Scripturly Terms & Conditions and acknowledge the Privacy Policy',
      'es':
          'Al continuar, aceptas los Términos y Condiciones de Scripturly y reconoces la Política de Privacidad.',
    },
    '4goal2oo': {
      'en': 'First name is required',
      'es': 'El nombre es obligatorio.',
    },
    '6dei9gzq': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    '7q3kqppv': {
      'en': 'Last name is required',
      'es': 'El apellido es obligatorio.',
    },
    'gireq3kt': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    'q53iubom': {
      'en': 'Email address is required',
      'es': 'Se requiere una dirección de correo electrónico.',
    },
    '0foaxthd': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    'lhky7za0': {
      'en': 'Password (8+ characters) is required',
      'es': 'Se requiere contraseña (de al menos 8 caracteres).',
    },
    'ab4q2kmn': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    'ep47wapn': {
      'en': 'Confirm password  is required',
      'es': 'Se requiere confirmar la contraseña',
    },
    '5r07kjmu': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    '5uhs44d7': {
      'en': 'Continue',
      'es': 'Continuar',
    },
    '6xs5yme1': {
      'en': 'Home',
      'es': '',
    },
  },
  // Login
  {
    'rdcnwkxx': {
      'en': 'Welcome back',
      'es': 'Bienvenido de nuevo',
    },
    '8eehekhz': {
      'en': 'Continue your spiritual journey today',
      'es': 'Continúa hoy tu camino espiritual.',
    },
    'ccfd8dkt': {
      'en': 'Email address',
      'es': '',
    },
    'of3z2tuu': {
      'en': 'Password (8+ characters)',
      'es': 'Contraseña (8+ caracteres)',
    },
    'r78jplkp': {
      'en': 'Forgot my password',
      'es': 'Olvidé mi contraseña',
    },
    'grlqq7wi': {
      'en': 'First name is required',
      'es': '',
    },
    'ybpbqy68': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    '6z4nihao': {
      'en': 'Last name is required',
      'es': '',
    },
    'j8yafc64': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    'vtewkpis': {
      'en': 'Email address is required',
      'es': '',
    },
    'k0bpsk02': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    '9joy4ls5': {
      'en': 'Password (8+ characters) is required',
      'es': '',
    },
    '2eigbg8v': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    'semkk7pp': {
      'en': 'Confirm password  is required',
      'es': '',
    },
    'cdu86i9x': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    '4qpo88na': {
      'en': 'Log in',
      'es': 'Acceso',
    },
    'lu6svbso': {
      'en': 'or',
      'es': 'o',
    },
    'tqg24yky': {
      'en': 'Home',
      'es': '',
    },
  },
  // resetPassword
  {
    'piiqz1m8': {
      'en': 'Reset you password',
      'es': 'Restablecer contraseña',
    },
    'an65k53t': {
      'en': 'We’ll send you an email with instructions to reset your password',
      'es':
          'Te enviaremos un correo electrónico con instrucciones para restablecer tu contraseña.',
    },
    'qltsbq46': {
      'en': 'Email address',
      'es': '',
    },
    'ww7v7k3x': {
      'en': 'First name is required',
      'es': '',
    },
    '9tbiae7h': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    '9koth6tv': {
      'en': 'Last name is required',
      'es': '',
    },
    'g5o4hre4': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    'bjzhady8': {
      'en': 'Email address is required',
      'es': '',
    },
    '1iyxelog': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    'qrrxj3do': {
      'en': 'Password (8+ characters) is required',
      'es': '',
    },
    '4mcy9jfy': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    'djzzw5ts': {
      'en': 'Confirm password  is required',
      'es': '',
    },
    'o9tr5d6j': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    '191q9uvp': {
      'en': 'Send reset email',
      'es': 'Enviar correo electrónico de restablecimiento',
    },
    'bavv9don': {
      'en': 'Home',
      'es': '',
    },
  },
  // verse
  {
    'fj6a7zt5': {
      'en': 'John 3:16',
      'es': 'Juan 3:16',
    },
    '7vj1170l': {
      'en':
          'For God so loved the world that He gave His only begotten Son, that whoever believes in Him should not perish but have everlasting life.',
      'es':
          'Porque de tal manera amó Dios al mundo, que dio a su Hijo unigénito, para que todo aquel que en él cree no se pierda, sino que tenga vida eterna.',
    },
    '1bxkxvaj': {
      'en': 'Continue your path',
      'es': 'Continúa tu camino',
    },
    '6tr72l76': {
      'en': 'Home',
      'es': '',
    },
  },
  // bridgeTolanguage
  {
    'ydp63l35': {
      'en': 'Home',
      'es': '',
    },
  },
  // welcome
  {
    '0uyyeroj': {
      'en': 'Welcome to Scripturly',
      'es': 'Juan 3:16',
    },
    'r6js7d1s': {
      'en':
          'Let\'s take a moment to personalize your journey and help you connect with the Bible in a new way.',
      'es':
          'Porque de tal manera amó Dios al mundo, que dio a su Hijo unigénito, para que todo aquel que en él cree no se pierda, sino que tenga vida eterna.',
    },
    '4710eyc4': {
      'en': 'Let\'s go',
      'es': 'Continúa tu camino',
    },
    'st0mwqch': {
      'en': 'Home',
      'es': 'Home',
    },
  },
  // onBorad1
  {
    'eidjj7dh': {
      'en': 'How familiar are you with the Bible?',
      'es': 'Conoce Scripturly',
    },
    '7qabg4qg': {
      'en': 'Select one option.',
      'es':
          'Crea una cuenta para acceder a versículos diarios, un plan de lectura personalizado y mucho más.',
    },
    '3sbtd004': {
      'en': 'Continue',
      'es': 'Continuar',
    },
    '69kr80in': {
      'en': 'Home',
      'es': 'Home',
    },
  },
  // onBorad2
  {
    '8658sdt2': {
      'en': 'What brings you to Scripturly?',
      'es': 'Conoce Scripturly',
    },
    '35jtpw53': {
      'en': 'Select up to 2 options.',
      'es':
          'Crea una cuenta para acceder a versículos diarios, un plan de lectura personalizado y mucho más.',
    },
    '46bng7uv': {
      'en': 'Continue',
      'es': 'Continuar',
    },
    '4lxt4eok': {
      'en': 'Home',
      'es': 'Home',
    },
  },
  // onBorad3
  {
    'vagi37dh': {
      'en': 'What brings you to Scripturly?',
      'es': 'Conoce Scripturly',
    },
    'ton7y9a4': {
      'en': 'Continue',
      'es': 'Continuar',
    },
    '9ex57teh': {
      'en': 'Skip this',
      'es': 'Continuar',
    },
    'xm85qev5': {
      'en': 'Home',
      'es': 'Home',
    },
  },
  // onBoradPathA
  {
    'teiyx8gt': {
      'en': 'We\'ve selected a great starting point for you.',
      'es': 'Conoce Scripturly',
    },
    'uu2q298w': {
      'en': 'Based on your goals, we recommend the ',
      'es': '',
    },
    '1vw62aap': {
      'en': 'King James Version (KJV)',
      'es': '',
    },
    'gi9yibwh': {
      'en':
          '. It\'s written in natural, everyday English, making it one of the easiest-to-understand and most engaging modern translations.',
      'es': '',
    },
    'n47bwlf0': {
      'en': 'Get Started',
      'es': 'Continuar',
    },
    'osj1qa4d': {
      'en': 'Change version',
      'es': 'Continuar',
    },
    'p6i5tu6l': {
      'en': 'Home',
      'es': 'Home',
    },
  },
  // onBoradPathB
  {
    'l5ozsxel': {
      'en': 'Which Bible version do you prefer?',
      'es': 'Conoce Scripturly',
    },
    '06ehutf8': {
      'en': 'Select the versions that suits you best',
      'es':
          'Crea una cuenta para acceder a versículos diarios, un plan de lectura personalizado y mucho más.',
    },
    'hsu86rv2': {
      'en': 'Continue',
      'es': 'Continuar',
    },
    'u4lupj7k': {
      'en': 'Home',
      'es': 'Home',
    },
  },
  // loading
  {
    '9b3aobz3': {
      'en': 'Home',
      'es': '',
    },
  },
  // Profile
  {
    'ndtc25fp': {
      'en': 'Account info',
      'es': 'Información de la cuenta',
    },
    'swywzvhy': {
      'en': 'Change Password',
      'es': 'Cambiar la contraseña',
    },
    'ni5zhvmf': {
      'en': 'Reading Preferences',
      'es': 'Preferencias de lectura',
    },
    'r1autr11': {
      'en': 'Logout',
      'es': 'Cerrar sesión',
    },
    'k1l05dab': {
      'en': 'Delete my account',
      'es': 'Cerrar sesión',
    },
    'gi2zhuwa': {
      'en':
          'Are you sure you want to delete your account? All your data and progress will be lost.',
      'es': '',
    },
    '2yyfl8fy': {
      'en': 'Delete account',
      'es': '',
    },
    'edledeww': {
      'en': 'Cancel',
      'es': '',
    },
    'ta0tfd8c': {
      'en': 'ME',
      'es': 'Perfil',
    },
  },
  // profileDetails
  {
    '2tgbxjom': {
      'en': 'Basic info',
      'es': 'Restablecer contraseña',
    },
    '1agl2yfi': {
      'en': 'First Name',
      'es': 'Correo electrónico',
    },
    'cyjey933': {
      'en': 'Last Name',
      'es': 'Correo electrónico',
    },
    'sjstnzpe': {
      'en': 'Email address',
      'es': 'Correo electrónico',
    },
    'hlri48wd': {
      'en': 'First Name is required',
      'es': 'Se requiere una dirección de correo electrónico.',
    },
    'gzdddb2i': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    'l881of89': {
      'en': 'Last Name is required',
      'es': 'Apellido es obligatorio ',
    },
    'qtcf0czk': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    'apupo6c8': {
      'en': 'Email address is required',
      'es': '',
    },
    '50neflb5': {
      'en': 'Please choose an option from the dropdown',
      'es': '',
    },
    'ssftoov0': {
      'en': 'Email can\'t be changed',
      'es': 'El correo no puede ser cambiado',
    },
    'jmuw9ypy': {
      'en': 'Upgrade profile',
      'es': 'Enviar correo electrónico de restablecimiento',
    },
    'wx1fc0q5': {
      'en': 'Home',
      'es': 'Home',
    },
  },
  // resetPasswordCopy
  {
    'hufwyftq': {
      'en': 'Reset you password',
      'es': 'Restablecer contraseña',
    },
    'rw8dbdf9': {
      'en': 'We’ll send you an email with instructions to reset your password',
      'es':
          'Te enviaremos un correo electrónico con instrucciones para restablecer tu contraseña.',
    },
    'h9fc45wr': {
      'en': 'Email address',
      'es': 'Correo electrónico',
    },
    '9xc5wnsx': {
      'en': 'First name is required',
      'es': 'El nombre es obligatorio.',
    },
    'pycxxb5r': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    'ke53pulo': {
      'en': 'Last name is required',
      'es': 'El apellido es obligatorio.',
    },
    'hhnbmkaj': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    'tfiagcc7': {
      'en': 'Email address is required',
      'es': 'Se requiere una dirección de correo electrónico.',
    },
    '2mhy0cfz': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    '9k97bexo': {
      'en': 'Password (8+ characters) is required',
      'es': 'Se requiere contraseña (de al menos 8 caracteres).',
    },
    '0z70r6gx': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    '3m0tnt00': {
      'en': 'Confirm password  is required',
      'es': 'Se requiere confirmar la contraseña',
    },
    'fcntc5qa': {
      'en': 'Please choose an option from the dropdown',
      'es': 'Por favor, seleccione una opción del menú desplegable.',
    },
    'srpmr20j': {
      'en': 'Send reset email',
      'es': 'Enviar correo electrónico de restablecimiento',
    },
    'ya6z3t3d': {
      'en': 'Home',
      'es': 'Home',
    },
  },
  // deleteAccount
  {
    't8q6n8on': {
      'en': 'Delete your account',
      'es': '',
    },
    'f0mb0w2e': {
      'en': 'Home',
      'es': '',
    },
  },
  // policy
  {
    '8yspgv48': {
      'en': 'Home',
      'es': 'Perfil',
    },
  },
  // terms
  {
    'w8gx5pyq': {
      'en': 'Home',
      'es': 'Perfil',
    },
  },
  // BooksIndex
  {
    'z94u8n9z': {
      'en': 'Books of the Bible',
      'es': 'Libros de la Biblia',
    },
    'jqzvdvkx': {
      'en': 'Old Testament',
      'es': 'Antiguo Testamento',
    },
    '63443c6c': {
      'en': 'New Testament',
      'es': 'Nuevo Testamento',
    },
  },
  // versesPopUp
  {
    'rqjgc0sp': {
      'en': 'Select a verse:',
      'es': 'Selecciona un versículo:',
    },
  },
  // onboardingHeader
  {
    'ltxuqmtu': {
      'en': 'Already have an account?',
      'es': '¿Ya tienes una cuenta?',
    },
    'ohfgdt79': {
      'en': 'Sign In',
      'es': 'Iniciar sesión',
    },
    'wz03b1c4': {
      'en': 'Don\'t have an account?',
      'es': '¿No tienes una cuenta?',
    },
    '141157zq': {
      'en': 'Sign up',
      'es': 'Inscribirse',
    },
  },
  // readerSettings
  {
    'zvt0abck': {
      'en': 'Reading preferences',
      'es': 'Preferencias de lectura',
    },
    '2as4b6mt': {
      'en': 'Font size',
      'es': 'Tamaño de fuente',
    },
    'cybsqixg': {
      'en': 'Adjust the size of letters',
      'es': 'Ajusta el tamaño de las letras',
    },
    't81tk131': {
      'en': 'Font style',
      'es': 'Estilo de fuente',
    },
    'g73pp3un': {
      'en': 'Select a style that suites you',
      'es': 'Elige un estilo que te favorezca.',
    },
    'lk1273t6': {
      'en': 'For God so loved the world that he gave his only begotten son',
      'es':
          'Porque de tal manera amó Dios al mundo, que dio a su Hijo unigénito',
    },
    'hsqxklf4': {
      'en': 'For God so loved the world that he gave his only begotten son',
      'es':
          'Porque de tal manera amó Dios al mundo, que dio a su Hijo unigénito',
    },
    'rjep7d75': {
      'en': 'Theme',
      'es': 'Tema',
    },
    'jixdjifk': {
      'en': 'Select a theme that suits you',
      'es': 'Selecciona un tema que te guste.',
    },
  },
  // sideBarV2
  {
    '9rdaud9s': {
      'en': 'Select book and chapter',
      'es': 'Seleccione el libro y el capítulo',
    },
    '2w12uua5': {
      'en': 'v1.0.0+15',
      'es': 'v1.0.0+13',
    },
    'irff3syz': {
      'en': 'Select chapter',
      'es': 'Seleccionar capítulo',
    },
    't6x8kezg': {
      'en': 'Select a verse',
      'es': 'Selecciona un versículo',
    },
  },
  // tapAVerse
  {
    '7a8fz7yw': {
      'en': 'ScripturlyAI',
      'es': 'ScripturlyAI',
    },
    'pwa43nsn': {
      'en': 'Cross-reference',
      'es': 'Referencia cruzada',
    },
    '3laq8k5s': {
      'en': 'Expand with AI',
      'es': 'Expandir con IA',
    },
    'jii1qwnn': {
      'en': 'Generating Response...',
      'es': 'Generando respuesta...',
    },
  },
  // converseAverse
  {
    't1w33csi': {
      'en': 'You',
      'es': 'Tú',
    },
    'o1sgjzmj': {
      'en': '9:00 AM',
      'es': '9:00 AM',
    },
    '34ynfmkw': {
      'en': 'ScripturlyAI',
      'es': 'ScripturlyAI',
    },
    'rgg9ukey': {
      'en': 'Cross-reference',
      'es': 'Referencia cruzada',
    },
    'n2zjj2x6': {
      'en': 'Generating Response...',
      'es': 'Generando respuesta...',
    },
    'm291yrbx': {
      'en': 'Type your message',
      'es': 'Escribe tu mensaje',
    },
  },
  // crossReferences
  {
    'y8bns2v8': {
      'en': 'John 1, 23:32',
      'es': 'Juan 1, 23:32',
    },
    '310dlq4a': {
      'en':
          'This verse talks about xcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'es':
          'Este verso habla de xcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    },
    '5d3km1d7': {
      'en': 'John 1, 23:32',
      'es': 'Juan 1, 23:32',
    },
    '6h2fp6zs': {
      'en':
          'This verse talks about xcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      'es':
          'Este verso habla de xcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    },
  },
  // Miscellaneous
  {
    '0v7ozxq4': {
      'en': 'Create account',
      'es': 'Crear una cuenta',
    },
    'l0nx7kwq': {
      'en': 'Home',
      'es': 'Home',
    },
    '44v9han0': {
      'en': '',
      'es': '',
    },
    's594ex4e': {
      'en': '',
      'es': '',
    },
    'nu6xgjom': {
      'en': '',
      'es': '',
    },
    '11h0j5z5': {
      'en': '',
      'es': '',
    },
    '9d1r3ikg': {
      'en': '',
      'es': '',
    },
    'x1gen62k': {
      'en': '',
      'es': '',
    },
    'gw9qex9f': {
      'en': '',
      'es': '',
    },
    'yf8ii0wn': {
      'en': '',
      'es': '',
    },
    'k5sh77r3': {
      'en': '',
      'es': '',
    },
    'pdkrwer4': {
      'en': '',
      'es': '',
    },
    '3c99wz2e': {
      'en': '',
      'es': '',
    },
    '82z1w3we': {
      'en': '',
      'es': '',
    },
    'xj71uhks': {
      'en': '',
      'es': '',
    },
    'he9go2rc': {
      'en': '',
      'es': '',
    },
    'wcdvdx2f': {
      'en': '',
      'es': '',
    },
    'ij0o7va9': {
      'en': '',
      'es': '',
    },
    'uiecqsti': {
      'en': '',
      'es': '',
    },
    '852e9q1s': {
      'en': '',
      'es': '',
    },
    'tvmvdhbh': {
      'en': '',
      'es': '',
    },
    'lsgb1jol': {
      'en': '',
      'es': '',
    },
    '9fzhsddh': {
      'en': '',
      'es': '',
    },
    'zx2yt233': {
      'en': '',
      'es': '',
    },
    'xhbsiffa': {
      'en': '',
      'es': '',
    },
    'q08gbgdq': {
      'en': '',
      'es': '',
    },
    '3at36dh0': {
      'en': '',
      'es': '',
    },
  },
].reduce((a, b) => a..addAll(b));
