import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @homeAppBarTitle.
  ///
  /// In ru, this message translates to:
  /// **'Управление Инвентарем'**
  String get homeAppBarTitle;

  /// No description provided for @menuUnderDevelopment.
  ///
  /// In ru, this message translates to:
  /// **'Меню (в разработке)'**
  String get menuUnderDevelopment;

  /// No description provided for @searchTitle.
  ///
  /// In ru, this message translates to:
  /// **'Поиск предмета'**
  String get searchTitle;

  /// No description provided for @scanButton.
  ///
  /// In ru, this message translates to:
  /// **'Скан'**
  String get scanButton;

  /// No description provided for @searchFieldLabel.
  ///
  /// In ru, this message translates to:
  /// **'Введите название или номер'**
  String get searchFieldLabel;

  /// No description provided for @searchButton.
  ///
  /// In ru, this message translates to:
  /// **'Найти'**
  String get searchButton;

  /// No description provided for @barcodeDialogTitle.
  ///
  /// In ru, this message translates to:
  /// **'Сканирование штрихкода'**
  String get barcodeDialogTitle;

  /// No description provided for @barcodeDialogHint.
  ///
  /// In ru, this message translates to:
  /// **'Наведите камеру на штрихкод или введите его вручную ниже'**
  String get barcodeDialogHint;

  /// No description provided for @barcodeFieldLabel.
  ///
  /// In ru, this message translates to:
  /// **'Штрихкод или инв. номер'**
  String get barcodeFieldLabel;

  /// No description provided for @scannerUnavailableMessage.
  ///
  /// In ru, this message translates to:
  /// **'Камера недоступна. Используйте ручной ввод.'**
  String get scannerUnavailableMessage;

  /// No description provided for @scannerPermissionDeniedMessage.
  ///
  /// In ru, this message translates to:
  /// **'Нет доступа к камере. Используйте ручной ввод.'**
  String get scannerPermissionDeniedMessage;

  /// No description provided for @scannerReadButton.
  ///
  /// In ru, this message translates to:
  /// **'Сканировать камерой'**
  String get scannerReadButton;

  /// No description provided for @scannerScanningLabel.
  ///
  /// In ru, this message translates to:
  /// **'Сканирование...'**
  String get scannerScanningLabel;

  /// No description provided for @saveButton.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get saveButton;

  /// No description provided for @cancelButton.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get cancelButton;

  /// No description provided for @searchButtonDialog.
  ///
  /// In ru, this message translates to:
  /// **'Поиск'**
  String get searchButtonDialog;

  /// No description provided for @notFoundDialogTitle.
  ///
  /// In ru, this message translates to:
  /// **'Предмет не найден'**
  String get notFoundDialogTitle;

  /// No description provided for @notFoundDialogContent.
  ///
  /// In ru, this message translates to:
  /// **'Предмет с номером \"{query}\" не найден в базе данных.'**
  String notFoundDialogContent(String query);

  /// No description provided for @createButton.
  ///
  /// In ru, this message translates to:
  /// **'Создать'**
  String get createButton;

  /// No description provided for @inventoryButton.
  ///
  /// In ru, this message translates to:
  /// **'Инвентарь'**
  String get inventoryButton;

  /// No description provided for @employeesButton.
  ///
  /// In ru, this message translates to:
  /// **'Сотрудники'**
  String get employeesButton;

  /// No description provided for @roomsButton.
  ///
  /// In ru, this message translates to:
  /// **'Помещения'**
  String get roomsButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
