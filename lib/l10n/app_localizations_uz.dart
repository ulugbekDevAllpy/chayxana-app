// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppL10nUz extends AppL10n {
  AppL10nUz([String locale = 'uz']) : super(locale);

  @override
  String get appName => 'Choyxona Toshkent Siti';

  @override
  String get back => 'Orqaga';

  @override
  String get next => 'Keyingi';

  @override
  String get save => 'Saqlash';

  @override
  String get cancel => 'Bekor qilish';

  @override
  String get close => 'Yopish';

  @override
  String get done => 'Tayyor';

  @override
  String get skip => 'O\'tkazib yuborish';

  @override
  String get call => 'Chaqirish';

  @override
  String get approve => 'Tasdiqlash';

  @override
  String get onboardingTitle => 'Profilga kiring';

  @override
  String get onboardingSubtitle =>
      'Bonus tangalar yig\'ish va shaxsiy takliflar olish uchun';

  @override
  String get register => 'Ro\'yxatdan o\'tish';

  @override
  String get login => 'Kirish';

  @override
  String get signUpTitle => 'Yangi hisob yarataylik';

  @override
  String get phoneLabel => 'Telefon raqami';

  @override
  String get passwordLabel => 'Parolni o\'rnating';

  @override
  String get confirmPasswordLabel => 'Parolni tasdiqlang';

  @override
  String get promoCodeLabel => 'Promokod';

  @override
  String get phoneInvalid => 'Telefon raqami noto\'g\'ri';

  @override
  String get hasAccount => 'Hisobingiz bormi?';

  @override
  String get noAccount => 'Hisobingiz yo\'qmi?';

  @override
  String get registration => 'Ro\'yxatdan o\'tish';

  @override
  String get verifyTitle => 'Telefon raqamingizni tasdiqlang';

  @override
  String verifySubtitle(String phone) {
    return 'Biz $phone raqamiga tekshiruv kodi yubordik';
  }

  @override
  String get verifyCodeLabel => 'Tekshiruv kodi';

  @override
  String get codeInvalid => 'Kod noto\'g\'ri, qayta urinib ko\'ring';

  @override
  String get welcomeBack => 'Qaytib kelganingiz bilan';

  @override
  String get enterPassword => 'Parolni kiriting';

  @override
  String get forgotPassword => 'Parolni unutdingizmi?';

  @override
  String get passwordInvalid => 'Parol noto\'g\'ri, qayta urinib ko\'ring';

  @override
  String get passwordChanged => 'Parol o\'zgartirildi';

  @override
  String get success => 'Muvaffaqiyatli!';

  @override
  String get resetPassword => 'Parolni tiklash';

  @override
  String get forgotSubtitle =>
      'Parolni tiklash uchun tasdiq kodi olish maqsadida telefon raqamingizni kiriting';

  @override
  String get setNewPasswordTitle => 'Yangi parol o\'rnating';

  @override
  String get setNewPasswordSubtitle =>
      'Hisobingizga qayta kira olish uchun yangi parol kiriting';

  @override
  String get enterPasswordSecond => 'Parolni qayta kiriting';

  @override
  String get freeDelivery => 'Bepul yetkazib berish';

  @override
  String get menu => 'Menyu';

  @override
  String get popular => 'Mashhur';

  @override
  String get callWaiter => 'Ofitsiantni chaqirish';

  @override
  String get categoryNew => 'Yangiliklar';

  @override
  String get categoryShashlyk => 'Shashlik';

  @override
  String get categoryHot => 'Issiq taomlar';

  @override
  String get categorySalads => 'Salatlar';

  @override
  String get categorySnacks => 'Yengil taomlar';

  @override
  String get callWaiterTitle => 'Ofitsiantni chaqirish';

  @override
  String get selectTable => 'Stolingiz raqamini tanlang';

  @override
  String get tableNumberHint => 'stol raqami';

  @override
  String get bringMenu => 'Menyu olib kelish';

  @override
  String get bringBill => 'Hisob olib kelish';

  @override
  String get waiterOnTheWay => 'Ofitsiant siz tomon kelmoqda!';

  @override
  String get cart => 'Savatcha';

  @override
  String get cartEmpty => 'Savatcha bo\'sh';

  @override
  String get addToOrder => 'Buyurtmaga qo\'shasizmi?';

  @override
  String get hasPromo => 'Promokod bormi?';

  @override
  String get promoApplied => 'Promokod';

  @override
  String get goodsSubtotal => 'Tovarlar (chegirma bilan)';

  @override
  String get bonuses => 'Bonuslar';

  @override
  String get delivery => 'Yetkazib berish';

  @override
  String placeOrderFor(int amount) {
    return '$amount ₽ ga buyurtma berish';
  }

  @override
  String get deliveryTitle => 'Yetkazib berish';

  @override
  String get addressLabel => 'Manzil';

  @override
  String get paymentMethod => 'To\'lov usuli';

  @override
  String get coinsPayment => 'Tangalar';

  @override
  String get cashPayment => 'Naqd';

  @override
  String get tinkoffPayment => 'Tinkoff';

  @override
  String get addComment => 'Izoh qo\'shish';

  @override
  String get total => 'Jami';

  @override
  String get placeOrder => 'Buyurtma berish';

  @override
  String get inRestaurantTab => 'Choyxonada';

  @override
  String get myAddresses => 'Mening manzillarim';

  @override
  String get newAddress => 'Yangi manzil';

  @override
  String get deliverHere => 'Bu yerga yetkazish';

  @override
  String get orderHere => 'Bu yerdan buyurtma';

  @override
  String get streetHint => 'Shahar, ko\'cha va uy';

  @override
  String get entrance => 'Padyezd';

  @override
  String get doorCode => 'Eshik kodi';

  @override
  String get floor => 'Qavat';

  @override
  String get apartment => 'Kvartira/ofis';

  @override
  String get addressComment => 'Manzil izohi';

  @override
  String openUntil(String time) {
    return 'Ochiq $time gacha';
  }

  @override
  String get phoneInfo => 'Telefon';

  @override
  String get schedule => 'Jadval';

  @override
  String orderNumber(int n, String time) {
    return 'Buyurtma №$n, $time';
  }

  @override
  String get orderAccepted => 'Buyurtmangiz qabul qilindi';

  @override
  String get orderAcceptedSub => 'Buyurtma 30 daqiqa ichida yetkaziladi';

  @override
  String get orderCooking => 'Ovqatingiz tayyorlanmoqda';

  @override
  String get orderCookingSub => 'Buyurtma 30 daqiqa ichida yetkaziladi';

  @override
  String orderDelivering(int n) {
    return '$n daqiqada yetkazamiz';
  }

  @override
  String get orderDeliveringSub =>
      'Kuryer Alisher buyurtmani olib siz tomon yo\'lga chiqdi';

  @override
  String get orderDelivered => 'Buyurtmangiz yetkazildi';

  @override
  String get cancelOrder => 'Bekor qilish';

  @override
  String get contactUs => 'Biz bilan bog\'lanish';

  @override
  String get callCourier => 'Kuryerga qo\'ng\'iroq';

  @override
  String get rate => 'Baholash';

  @override
  String get rateOrder => 'Buyurtmani baholang';

  @override
  String get whatLiked => 'Nima yoqdi?';

  @override
  String get whatDidnt => 'Nima yoqmadi?';

  @override
  String get rateHint =>
      'Nima yoqmaganini ayting. Sizning shikoyatingizni yetkazamiz';

  @override
  String get thanksForReview => 'Sharhingiz uchun rahmat!';

  @override
  String get reviewHelps =>
      'Har bir sharh xizmat sifatini yaxshilashga yordam beradi';

  @override
  String get topicGoodCourier => 'Ajoyib kuryer';

  @override
  String get topicAllWishes => 'Hamma istaklar bajarildi';

  @override
  String get topicPerfectOrder => 'Buyurtma mukammal yig\'ildi';

  @override
  String get topicFastDelivery => 'Tez yetkazib berdi';

  @override
  String get topicLateDelivery => 'Yetkazib berish kechikdi!';

  @override
  String get topicColdFood => 'Sovuq ovqat';

  @override
  String get topicRudeCourier => 'Qo\'pol kuryer';

  @override
  String get profile => 'Profil';

  @override
  String get bonus3Percent => 'Har xaridingizdan 3% bonus';

  @override
  String get personalData => 'Shaxsiy ma\'lumot va telefon';

  @override
  String get addressesMenuItem => 'Manzillar';

  @override
  String get orderHistory => 'Buyurtma tarixi';

  @override
  String get inviteFriend => 'Do\'st chaqirish';

  @override
  String get support => 'Yordam';

  @override
  String get aboutChayxana => 'Choyxona haqida';

  @override
  String get logout => 'Chiqish';

  @override
  String get deleteAccount => 'Hisobni o\'chirish';

  @override
  String get nameLabel => 'Ism Familiya';

  @override
  String get emailLabel => 'Email';

  @override
  String get language => 'Til';

  @override
  String get languageRussian => 'Rus tili';

  @override
  String get languageEnglish => 'Ingliz tili';

  @override
  String get languageUzbek => 'O\'zbek tili';

  @override
  String get splashTitle => 'CHOYXONA';

  @override
  String get splashSubtitle => 'TOSHKENT SITI';

  @override
  String get coinAccrual => 'Tanga to\'planishi';

  @override
  String get orders => 'Buyurtmalar';

  @override
  String get delivered => 'Yetkazildi';

  @override
  String get order => 'Buyurtma';

  @override
  String get deliveryDetails => 'Yetkazib berish tafsilotlari';

  @override
  String get pickupOrder => 'Buyurtmani olish';

  @override
  String get orderDelivery => 'Buyurtma yetkazib berish';

  @override
  String get tinkoffPaymentLabel => 'Tinkoff to\'lovi';

  @override
  String get inviteFriendTitle => 'Do\'st chaqirish';

  @override
  String get inviteBonusTitle =>
      'Har bir taklif qilgan do\'stingiz uchun\n500 ₽ bonus oling';

  @override
  String get inviteBonusBody =>
      'Do\'stingizni o\'zingizning noyob promokodingiz orqali Chayxala\'ga taklif qiling va 1200₽ dan ortiq har qanday buyurtmada 500₽ chegirma oling.';

  @override
  String get inviteByLink => 'Havola orqali taklif qilish';

  @override
  String get aboutUs => 'Biz haqimizda';

  @override
  String get aboutUsBody =>
      'Biz asrlar davomida sinovdan o\'tgan retseptlarni saqlab, faqat yangi va tabiiy ingredientlardan foydalanib taom tayyorlaymiz';

  @override
  String get guestsAboutUs => 'Mehmonlar biz haqimizda';

  @override
  String get gallery => 'Galereya';

  @override
  String get galleryDescription =>
      'Bizning choyxonamiz oddiy kafe emas — bu vaqt sekinlashadigan va siz haqiqatdan dam ola oladigan joy.';
}
