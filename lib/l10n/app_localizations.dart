import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppL10n
/// returned by `AppL10n.of(context)`.
///
/// Applications need to include `AppL10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppL10n.localizationsDelegates,
///   supportedLocales: AppL10n.supportedLocales,
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
/// be consistent with the languages listed in the AppL10n.supportedLocales
/// property.
abstract class AppL10n {
  AppL10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppL10n of(BuildContext context) {
    return Localizations.of<AppL10n>(context, AppL10n)!;
  }

  static const LocalizationsDelegate<AppL10n> delegate = _AppL10nDelegate();

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
    Locale('uz'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Chayxana Tashkent City'**
  String get appName;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to your profile'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Earn bonus coins and get personal offers'**
  String get onboardingSubtitle;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s create an account'**
  String get signUpTitle;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Set password'**
  String get passwordLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordLabel;

  /// No description provided for @promoCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Promo code'**
  String get promoCodeLabel;

  /// No description provided for @phoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get phoneInvalid;

  /// No description provided for @hasAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get hasAccount;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @registration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registration;

  /// No description provided for @verifyTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your phone number'**
  String get verifyTitle;

  /// No description provided for @verifySubtitle.
  ///
  /// In en, this message translates to:
  /// **'We just sent a verification code to {phone}'**
  String verifySubtitle(String phone);

  /// No description provided for @verifyCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get verifyCodeLabel;

  /// No description provided for @codeInvalid.
  ///
  /// In en, this message translates to:
  /// **'Wrong code, please try again'**
  String get codeInvalid;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @passwordInvalid.
  ///
  /// In en, this message translates to:
  /// **'Wrong password, please try again'**
  String get passwordInvalid;

  /// No description provided for @passwordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password changed'**
  String get passwordChanged;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get success;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @forgotSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to get a verification code for password reset'**
  String get forgotSubtitle;

  /// No description provided for @setNewPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Set a new password'**
  String get setNewPasswordTitle;

  /// No description provided for @setNewPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter a new password to be able to sign in to your account again'**
  String get setNewPasswordSubtitle;

  /// No description provided for @enterPasswordSecond.
  ///
  /// In en, this message translates to:
  /// **'Re-enter password'**
  String get enterPasswordSecond;

  /// No description provided for @freeDelivery.
  ///
  /// In en, this message translates to:
  /// **'Free delivery'**
  String get freeDelivery;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @popular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get popular;

  /// No description provided for @callWaiter.
  ///
  /// In en, this message translates to:
  /// **'Call waiter'**
  String get callWaiter;

  /// No description provided for @categoryNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get categoryNew;

  /// No description provided for @categoryShashlyk.
  ///
  /// In en, this message translates to:
  /// **'Shashlik'**
  String get categoryShashlyk;

  /// No description provided for @categoryHot.
  ///
  /// In en, this message translates to:
  /// **'Hot dishes'**
  String get categoryHot;

  /// No description provided for @categorySalads.
  ///
  /// In en, this message translates to:
  /// **'Salads'**
  String get categorySalads;

  /// No description provided for @categorySnacks.
  ///
  /// In en, this message translates to:
  /// **'Snacks'**
  String get categorySnacks;

  /// No description provided for @callWaiterTitle.
  ///
  /// In en, this message translates to:
  /// **'Call waiter'**
  String get callWaiterTitle;

  /// No description provided for @selectTable.
  ///
  /// In en, this message translates to:
  /// **'Select your table number'**
  String get selectTable;

  /// No description provided for @tableNumberHint.
  ///
  /// In en, this message translates to:
  /// **'table number'**
  String get tableNumberHint;

  /// No description provided for @bringMenu.
  ///
  /// In en, this message translates to:
  /// **'Bring menu'**
  String get bringMenu;

  /// No description provided for @bringBill.
  ///
  /// In en, this message translates to:
  /// **'Bring bill'**
  String get bringBill;

  /// No description provided for @waiterOnTheWay.
  ///
  /// In en, this message translates to:
  /// **'The waiter is on the way!'**
  String get waiterOnTheWay;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @cartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Cart is empty'**
  String get cartEmpty;

  /// No description provided for @addToOrder.
  ///
  /// In en, this message translates to:
  /// **'Add to order?'**
  String get addToOrder;

  /// No description provided for @hasPromo.
  ///
  /// In en, this message translates to:
  /// **'Have a promo code?'**
  String get hasPromo;

  /// No description provided for @promoApplied.
  ///
  /// In en, this message translates to:
  /// **'Promo code'**
  String get promoApplied;

  /// No description provided for @goodsSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Items with discount'**
  String get goodsSubtotal;

  /// No description provided for @bonuses.
  ///
  /// In en, this message translates to:
  /// **'Bonuses'**
  String get bonuses;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @placeOrderFor.
  ///
  /// In en, this message translates to:
  /// **'Place order for {amount} ₽'**
  String placeOrderFor(int amount);

  /// No description provided for @deliveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get deliveryTitle;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressLabel;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment method'**
  String get paymentMethod;

  /// No description provided for @coinsPayment.
  ///
  /// In en, this message translates to:
  /// **'Coins'**
  String get coinsPayment;

  /// No description provided for @cashPayment.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cashPayment;

  /// No description provided for @tinkoffPayment.
  ///
  /// In en, this message translates to:
  /// **'Tinkoff'**
  String get tinkoffPayment;

  /// No description provided for @addComment.
  ///
  /// In en, this message translates to:
  /// **'Add comment'**
  String get addComment;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @placeOrder.
  ///
  /// In en, this message translates to:
  /// **'Place order'**
  String get placeOrder;

  /// No description provided for @inRestaurantTab.
  ///
  /// In en, this message translates to:
  /// **'Dine in'**
  String get inRestaurantTab;

  /// No description provided for @myAddresses.
  ///
  /// In en, this message translates to:
  /// **'My addresses'**
  String get myAddresses;

  /// No description provided for @newAddress.
  ///
  /// In en, this message translates to:
  /// **'New address'**
  String get newAddress;

  /// No description provided for @deliverHere.
  ///
  /// In en, this message translates to:
  /// **'Deliver here'**
  String get deliverHere;

  /// No description provided for @orderHere.
  ///
  /// In en, this message translates to:
  /// **'Order here'**
  String get orderHere;

  /// No description provided for @streetHint.
  ///
  /// In en, this message translates to:
  /// **'City, street and house'**
  String get streetHint;

  /// No description provided for @entrance.
  ///
  /// In en, this message translates to:
  /// **'Entrance'**
  String get entrance;

  /// No description provided for @doorCode.
  ///
  /// In en, this message translates to:
  /// **'Door code'**
  String get doorCode;

  /// No description provided for @floor.
  ///
  /// In en, this message translates to:
  /// **'Floor'**
  String get floor;

  /// No description provided for @apartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment/office'**
  String get apartment;

  /// No description provided for @addressComment.
  ///
  /// In en, this message translates to:
  /// **'Address comment'**
  String get addressComment;

  /// No description provided for @openUntil.
  ///
  /// In en, this message translates to:
  /// **'Open until {time}'**
  String openUntil(String time);

  /// No description provided for @phoneInfo.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phoneInfo;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @orderNumber.
  ///
  /// In en, this message translates to:
  /// **'Order №{n} at {time}'**
  String orderNumber(int n, String time);

  /// No description provided for @orderAccepted.
  ///
  /// In en, this message translates to:
  /// **'Order accepted'**
  String get orderAccepted;

  /// No description provided for @orderAcceptedSub.
  ///
  /// In en, this message translates to:
  /// **'The order will be delivered within 30 minutes'**
  String get orderAcceptedSub;

  /// No description provided for @orderCooking.
  ///
  /// In en, this message translates to:
  /// **'Cooking your meal'**
  String get orderCooking;

  /// No description provided for @orderCookingSub.
  ///
  /// In en, this message translates to:
  /// **'Your order will be delivered within 30 minutes'**
  String get orderCookingSub;

  /// No description provided for @orderDelivering.
  ///
  /// In en, this message translates to:
  /// **'Delivery in {n} minutes'**
  String orderDelivering(int n);

  /// No description provided for @orderDeliveringSub.
  ///
  /// In en, this message translates to:
  /// **'Courier Alisher picked up the order and is heading to you'**
  String get orderDeliveringSub;

  /// No description provided for @orderDelivered.
  ///
  /// In en, this message translates to:
  /// **'Your meal delivered'**
  String get orderDelivered;

  /// No description provided for @cancelOrder.
  ///
  /// In en, this message translates to:
  /// **'Cancel order'**
  String get cancelOrder;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contactUs;

  /// No description provided for @callCourier.
  ///
  /// In en, this message translates to:
  /// **'Call courier'**
  String get callCourier;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rate;

  /// No description provided for @rateOrder.
  ///
  /// In en, this message translates to:
  /// **'Rate order'**
  String get rateOrder;

  /// No description provided for @whatLiked.
  ///
  /// In en, this message translates to:
  /// **'What did you like?'**
  String get whatLiked;

  /// No description provided for @whatDidnt.
  ///
  /// In en, this message translates to:
  /// **'What didn\'t you like?'**
  String get whatDidnt;

  /// No description provided for @rateHint.
  ///
  /// In en, this message translates to:
  /// **'Tell us what you didn\'t like. We will forward your complaint'**
  String get rateHint;

  /// No description provided for @thanksForReview.
  ///
  /// In en, this message translates to:
  /// **'Thank you for your review!'**
  String get thanksForReview;

  /// No description provided for @reviewHelps.
  ///
  /// In en, this message translates to:
  /// **'Every review helps us improve service quality'**
  String get reviewHelps;

  /// No description provided for @topicGoodCourier.
  ///
  /// In en, this message translates to:
  /// **'Great courier'**
  String get topicGoodCourier;

  /// No description provided for @topicAllWishes.
  ///
  /// In en, this message translates to:
  /// **'All wishes considered'**
  String get topicAllWishes;

  /// No description provided for @topicPerfectOrder.
  ///
  /// In en, this message translates to:
  /// **'Perfect order assembly'**
  String get topicPerfectOrder;

  /// No description provided for @topicFastDelivery.
  ///
  /// In en, this message translates to:
  /// **'Fast delivery'**
  String get topicFastDelivery;

  /// No description provided for @topicLateDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery was late'**
  String get topicLateDelivery;

  /// No description provided for @topicColdFood.
  ///
  /// In en, this message translates to:
  /// **'Cold food'**
  String get topicColdFood;

  /// No description provided for @topicRudeCourier.
  ///
  /// In en, this message translates to:
  /// **'Rude courier'**
  String get topicRudeCourier;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @bonus3Percent.
  ///
  /// In en, this message translates to:
  /// **'Earn 3% on every purchase'**
  String get bonus3Percent;

  /// No description provided for @personalData.
  ///
  /// In en, this message translates to:
  /// **'Personal data and phone'**
  String get personalData;

  /// No description provided for @addressesMenuItem.
  ///
  /// In en, this message translates to:
  /// **'Addresses'**
  String get addressesMenuItem;

  /// No description provided for @orderHistory.
  ///
  /// In en, this message translates to:
  /// **'Order history'**
  String get orderHistory;

  /// No description provided for @inviteFriend.
  ///
  /// In en, this message translates to:
  /// **'Invite a friend'**
  String get inviteFriend;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @aboutChayxana.
  ///
  /// In en, this message translates to:
  /// **'About Chayxana'**
  String get aboutChayxana;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name Surname'**
  String get nameLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageRussian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get languageRussian;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageUzbek.
  ///
  /// In en, this message translates to:
  /// **'Uzbek'**
  String get languageUzbek;

  /// No description provided for @splashTitle.
  ///
  /// In en, this message translates to:
  /// **'CHAYXANA'**
  String get splashTitle;

  /// No description provided for @splashSubtitle.
  ///
  /// In en, this message translates to:
  /// **'TASHKENT CITY'**
  String get splashSubtitle;

  /// No description provided for @coinAccrual.
  ///
  /// In en, this message translates to:
  /// **'Coin accrual'**
  String get coinAccrual;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @deliveryDetails.
  ///
  /// In en, this message translates to:
  /// **'Delivery details'**
  String get deliveryDetails;

  /// No description provided for @pickupOrder.
  ///
  /// In en, this message translates to:
  /// **'Pickup order'**
  String get pickupOrder;

  /// No description provided for @orderDelivery.
  ///
  /// In en, this message translates to:
  /// **'Order delivery'**
  String get orderDelivery;

  /// No description provided for @tinkoffPaymentLabel.
  ///
  /// In en, this message translates to:
  /// **'Tinkoff payment'**
  String get tinkoffPaymentLabel;

  /// No description provided for @inviteFriendTitle.
  ///
  /// In en, this message translates to:
  /// **'Invite a friend'**
  String get inviteFriendTitle;

  /// No description provided for @inviteBonusTitle.
  ///
  /// In en, this message translates to:
  /// **'Get 500 ₽ bonus\nfor every invited friend'**
  String get inviteBonusTitle;

  /// No description provided for @inviteBonusBody.
  ///
  /// In en, this message translates to:
  /// **'Invite a friend to Chayxala using your unique promo code and get a 500₽ discount on any order over 1200₽.'**
  String get inviteBonusBody;

  /// No description provided for @inviteByLink.
  ///
  /// In en, this message translates to:
  /// **'Invite by link'**
  String get inviteByLink;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About us'**
  String get aboutUs;

  /// No description provided for @aboutUsBody.
  ///
  /// In en, this message translates to:
  /// **'We cook dishes, preserving recipes proven over centuries and using only fresh and natural ingredients'**
  String get aboutUsBody;

  /// No description provided for @guestsAboutUs.
  ///
  /// In en, this message translates to:
  /// **'Guests about us'**
  String get guestsAboutUs;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @galleryDescription.
  ///
  /// In en, this message translates to:
  /// **'Our chayxana is more than just a café — it\'s a place where time slows down and you can truly relax.'**
  String get galleryDescription;
}

class _AppL10nDelegate extends LocalizationsDelegate<AppL10n> {
  const _AppL10nDelegate();

  @override
  Future<AppL10n> load(Locale locale) {
    return SynchronousFuture<AppL10n>(lookupAppL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppL10nDelegate old) => false;
}

AppL10n lookupAppL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppL10nEn();
    case 'ru':
      return AppL10nRu();
    case 'uz':
      return AppL10nUz();
  }

  throw FlutterError(
    'AppL10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
