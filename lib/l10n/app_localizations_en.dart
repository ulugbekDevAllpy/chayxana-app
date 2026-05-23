// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppL10nEn extends AppL10n {
  AppL10nEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Chayxana Tashkent City';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get done => 'Done';

  @override
  String get skip => 'Skip';

  @override
  String get call => 'Call';

  @override
  String get approve => 'Approve';

  @override
  String get onboardingTitle => 'Sign in to your profile';

  @override
  String get onboardingSubtitle => 'Earn bonus coins and get personal offers';

  @override
  String get register => 'Register';

  @override
  String get login => 'Log in';

  @override
  String get signUpTitle => 'Let\'s create an account';

  @override
  String get phoneLabel => 'Phone Number';

  @override
  String get passwordLabel => 'Set password';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get promoCodeLabel => 'Promo code';

  @override
  String get phoneInvalid => 'Invalid phone number';

  @override
  String get hasAccount => 'Already have an account?';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get registration => 'Registration';

  @override
  String get verifyTitle => 'Verify your phone number';

  @override
  String verifySubtitle(String phone) {
    return 'We just sent a verification code to $phone';
  }

  @override
  String get verifyCodeLabel => 'Verification code';

  @override
  String get codeInvalid => 'Wrong code, please try again';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get passwordInvalid => 'Wrong password, please try again';

  @override
  String get passwordChanged => 'Password changed';

  @override
  String get success => 'Success!';

  @override
  String get resetPassword => 'Reset password';

  @override
  String get forgotSubtitle =>
      'Enter your phone number to get a verification code for password reset';

  @override
  String get setNewPasswordTitle => 'Set a new password';

  @override
  String get setNewPasswordSubtitle =>
      'Enter a new password to be able to sign in to your account again';

  @override
  String get enterPasswordSecond => 'Re-enter password';

  @override
  String get freeDelivery => 'Free delivery';

  @override
  String get menu => 'Menu';

  @override
  String get popular => 'Popular';

  @override
  String get callWaiter => 'Call waiter';

  @override
  String get categoryNew => 'New';

  @override
  String get categoryShashlyk => 'Shashlik';

  @override
  String get categoryHot => 'Hot dishes';

  @override
  String get categorySalads => 'Salads';

  @override
  String get categorySnacks => 'Snacks';

  @override
  String get callWaiterTitle => 'Call waiter';

  @override
  String get selectTable => 'Select your table number';

  @override
  String get tableNumberHint => 'table number';

  @override
  String get bringMenu => 'Bring menu';

  @override
  String get bringBill => 'Bring bill';

  @override
  String get waiterOnTheWay => 'The waiter is on the way!';

  @override
  String get cart => 'Cart';

  @override
  String get cartEmpty => 'Cart is empty';

  @override
  String get addToOrder => 'Add to order?';

  @override
  String get hasPromo => 'Have a promo code?';

  @override
  String get promoApplied => 'Promo code';

  @override
  String get goodsSubtotal => 'Items with discount';

  @override
  String get bonuses => 'Bonuses';

  @override
  String get delivery => 'Delivery';

  @override
  String placeOrderFor(int amount) {
    return 'Place order for $amount ₽';
  }

  @override
  String get deliveryTitle => 'Delivery';

  @override
  String get addressLabel => 'Address';

  @override
  String get paymentMethod => 'Payment method';

  @override
  String get coinsPayment => 'Coins';

  @override
  String get cashPayment => 'Cash';

  @override
  String get tinkoffPayment => 'Tinkoff';

  @override
  String get addComment => 'Add comment';

  @override
  String get total => 'Total';

  @override
  String get placeOrder => 'Place order';

  @override
  String get inRestaurantTab => 'Dine in';

  @override
  String get myAddresses => 'My addresses';

  @override
  String get newAddress => 'New address';

  @override
  String get deliverHere => 'Deliver here';

  @override
  String get orderHere => 'Order here';

  @override
  String get streetHint => 'City, street and house';

  @override
  String get entrance => 'Entrance';

  @override
  String get doorCode => 'Door code';

  @override
  String get floor => 'Floor';

  @override
  String get apartment => 'Apartment/office';

  @override
  String get addressComment => 'Address comment';

  @override
  String openUntil(String time) {
    return 'Open until $time';
  }

  @override
  String get phoneInfo => 'Phone';

  @override
  String get schedule => 'Schedule';

  @override
  String orderNumber(int n, String time) {
    return 'Order №$n at $time';
  }

  @override
  String get orderAccepted => 'Order accepted';

  @override
  String get orderAcceptedSub =>
      'The order will be delivered within 30 minutes';

  @override
  String get orderCooking => 'Cooking your meal';

  @override
  String get orderCookingSub =>
      'Your order will be delivered within 30 minutes';

  @override
  String orderDelivering(int n) {
    return 'Delivery in $n minutes';
  }

  @override
  String get orderDeliveringSub =>
      'Courier Alisher picked up the order and is heading to you';

  @override
  String get orderDelivered => 'Your meal delivered';

  @override
  String get cancelOrder => 'Cancel order';

  @override
  String get contactUs => 'Contact us';

  @override
  String get callCourier => 'Call courier';

  @override
  String get rate => 'Rate';

  @override
  String get rateOrder => 'Rate order';

  @override
  String get whatLiked => 'What did you like?';

  @override
  String get whatDidnt => 'What didn\'t you like?';

  @override
  String get rateHint =>
      'Tell us what you didn\'t like. We will forward your complaint';

  @override
  String get thanksForReview => 'Thank you for your review!';

  @override
  String get reviewHelps => 'Every review helps us improve service quality';

  @override
  String get topicGoodCourier => 'Great courier';

  @override
  String get topicAllWishes => 'All wishes considered';

  @override
  String get topicPerfectOrder => 'Perfect order assembly';

  @override
  String get topicFastDelivery => 'Fast delivery';

  @override
  String get topicLateDelivery => 'Delivery was late';

  @override
  String get topicColdFood => 'Cold food';

  @override
  String get topicRudeCourier => 'Rude courier';

  @override
  String get profile => 'Profile';

  @override
  String get bonus3Percent => 'Earn 3% on every purchase';

  @override
  String get personalData => 'Personal data and phone';

  @override
  String get addressesMenuItem => 'Addresses';

  @override
  String get orderHistory => 'Order history';

  @override
  String get inviteFriend => 'Invite a friend';

  @override
  String get support => 'Support';

  @override
  String get aboutChayxana => 'About Chayxana';

  @override
  String get logout => 'Log out';

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get nameLabel => 'Name Surname';

  @override
  String get emailLabel => 'Email';

  @override
  String get language => 'Language';

  @override
  String get languageRussian => 'Russian';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageUzbek => 'Uzbek';

  @override
  String get splashTitle => 'CHAYXANA';

  @override
  String get splashSubtitle => 'TASHKENT CITY';

  @override
  String get coinAccrual => 'Coin accrual';

  @override
  String get orders => 'Orders';

  @override
  String get delivered => 'Delivered';

  @override
  String get order => 'Order';

  @override
  String get deliveryDetails => 'Delivery details';

  @override
  String get pickupOrder => 'Pickup order';

  @override
  String get orderDelivery => 'Order delivery';

  @override
  String get tinkoffPaymentLabel => 'Tinkoff payment';

  @override
  String get inviteFriendTitle => 'Invite a friend';

  @override
  String get inviteBonusTitle => 'Get 500 ₽ bonus\nfor every invited friend';

  @override
  String get inviteBonusBody =>
      'Invite a friend to Chayxala using your unique promo code and get a 500₽ discount on any order over 1200₽.';

  @override
  String get inviteByLink => 'Invite by link';

  @override
  String get aboutUs => 'About us';

  @override
  String get aboutUsBody =>
      'We cook dishes, preserving recipes proven over centuries and using only fresh and natural ingredients';

  @override
  String get guestsAboutUs => 'Guests about us';

  @override
  String get gallery => 'Gallery';

  @override
  String get galleryDescription =>
      'Our chayxana is more than just a café — it\'s a place where time slows down and you can truly relax.';
}
