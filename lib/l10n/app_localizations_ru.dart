// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppL10nRu extends AppL10n {
  AppL10nRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'Чайхана Ташкент Сити';

  @override
  String get back => 'Назад';

  @override
  String get next => 'Далее';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get close => 'Закрыть';

  @override
  String get done => 'Готово';

  @override
  String get skip => 'Пропустить';

  @override
  String get call => 'Вызвать';

  @override
  String get approve => 'Утвердить';

  @override
  String get onboardingTitle => 'Войдите в профиль';

  @override
  String get onboardingSubtitle =>
      'Чтобы заработать бонусные монеты и получить персональные предложения';

  @override
  String get register => 'Зарегистрироваться';

  @override
  String get login => 'Войти';

  @override
  String get signUpTitle => 'Давайте создадим аккаунт';

  @override
  String get phoneLabel => 'Номер Телефона';

  @override
  String get passwordLabel => 'Установите пароль';

  @override
  String get confirmPasswordLabel => 'Подтвердите пароль';

  @override
  String get promoCodeLabel => 'Промокод';

  @override
  String get phoneInvalid => 'Неправильный номер телефона';

  @override
  String get hasAccount => 'У вас уже есть аккаунт?';

  @override
  String get noAccount => 'У вас нет аккаунта?';

  @override
  String get registration => 'Регистрация';

  @override
  String get verifyTitle => 'Подтвердите свой номер телефона';

  @override
  String verifySubtitle(String phone) {
    return 'Мы только что отправили вам проверочный код на номер телефона $phone';
  }

  @override
  String get verifyCodeLabel => 'Код проверки';

  @override
  String get codeInvalid => 'Неправильный код, попробуйте еще раз';

  @override
  String get welcomeBack => 'С возвращением';

  @override
  String get enterPassword => 'Введите пароль';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get passwordInvalid => 'Неверный пароль, попробуйте еще раз';

  @override
  String get passwordChanged => 'Пароль был изменен';

  @override
  String get success => 'Успешно!';

  @override
  String get resetPassword => 'Сброс пароля';

  @override
  String get forgotSubtitle =>
      'Введите свой номер телефона, чтобы получить код подтверждения для сброса пароля';

  @override
  String get setNewPasswordTitle => 'Установите новый пароль';

  @override
  String get setNewPasswordSubtitle =>
      'Введите новый пароль, чтобы иметь возможность войти в свой аккаунт заново';

  @override
  String get enterPasswordSecond => 'Введите пароль';

  @override
  String get freeDelivery => 'Бесплатная доставка';

  @override
  String get menu => 'Меню';

  @override
  String get popular => 'Популярные';

  @override
  String get callWaiter => 'Позвать официанта';

  @override
  String get categoryNew => 'Новинки';

  @override
  String get categoryShashlyk => 'Шашлык';

  @override
  String get categoryHot => 'Горячие блюда';

  @override
  String get categorySalads => 'Салаты';

  @override
  String get categorySnacks => 'Закуски';

  @override
  String get callWaiterTitle => 'Позвать официанта';

  @override
  String get selectTable => 'Выберите номер вашего стола';

  @override
  String get tableNumberHint => 'номер стола';

  @override
  String get bringMenu => 'Принести меню';

  @override
  String get bringBill => 'Принести счёт';

  @override
  String get waiterOnTheWay => 'Официант уже в пути к вам!';

  @override
  String get cart => 'Корзина';

  @override
  String get cartEmpty => 'Корзина пуста';

  @override
  String get addToOrder => 'Добавить к заказу?';

  @override
  String get hasPromo => 'Есть промокод?';

  @override
  String get promoApplied => 'Промокод';

  @override
  String get goodsSubtotal => 'Товары с учётом скидки';

  @override
  String get bonuses => 'Бонусы';

  @override
  String get delivery => 'Доставка';

  @override
  String placeOrderFor(int amount) {
    return 'Оформить заказ за $amount ₽';
  }

  @override
  String get deliveryTitle => 'Доставка';

  @override
  String get addressLabel => 'Адрес';

  @override
  String get paymentMethod => 'Способ оплаты';

  @override
  String get coinsPayment => 'Coins';

  @override
  String get cashPayment => 'Наличные';

  @override
  String get tinkoffPayment => 'Тинькофф';

  @override
  String get addComment => 'Добавить комментарий';

  @override
  String get total => 'Итого';

  @override
  String get placeOrder => 'Оформить заказ';

  @override
  String get inRestaurantTab => 'В чайхане';

  @override
  String get myAddresses => 'Мои адреса';

  @override
  String get newAddress => 'Новый адрес';

  @override
  String get deliverHere => 'Доставить сюда';

  @override
  String get orderHere => 'Заказать здесь';

  @override
  String get streetHint => 'Город, улица и дом';

  @override
  String get entrance => 'Подъезд';

  @override
  String get doorCode => 'Код на двери';

  @override
  String get floor => 'Этаж';

  @override
  String get apartment => 'Квартира/офис';

  @override
  String get addressComment => 'Комментарии к адресу';

  @override
  String openUntil(String time) {
    return 'Открыто до $time';
  }

  @override
  String get phoneInfo => 'Phone';

  @override
  String get schedule => 'График';

  @override
  String orderNumber(int n, String time) {
    return 'Заказ №$n в $time';
  }

  @override
  String get orderAccepted => 'Приняли ваш заказ';

  @override
  String get orderAcceptedSub => 'Заказ будет доставлен в течение 30 минут';

  @override
  String get orderCooking => 'Готовим ваше блюдо';

  @override
  String get orderCookingSub => 'Ваш заказ будет доставлен в течение 30 минут';

  @override
  String orderDelivering(int n) {
    return 'Доставим через $n минут';
  }

  @override
  String get orderDeliveringSub =>
      'Курьер Алишер забрал заказ и направляется к вам';

  @override
  String get orderDelivered => 'Ваше блюдо доставлено';

  @override
  String get cancelOrder => 'Отменить заказ';

  @override
  String get contactUs => 'Связаться с нами';

  @override
  String get callCourier => 'Позвонить курьеру';

  @override
  String get rate => 'Оценить';

  @override
  String get rateOrder => 'Оцените заказ';

  @override
  String get whatLiked => 'Что понравилось?';

  @override
  String get whatDidnt => 'Что не понравилось?';

  @override
  String get rateHint =>
      'Расскажите, что не понравилось. Передадим вашу жалобу по адресу';

  @override
  String get thanksForReview => 'Спасибо за ваш отзыв!';

  @override
  String get reviewHelps =>
      'Каждый отзыв помогает нам улучшать качество обслуживания';

  @override
  String get topicGoodCourier => 'Отличный курьер';

  @override
  String get topicAllWishes => 'Учли все пожелания';

  @override
  String get topicPerfectOrder => 'Идеально собрали заказ';

  @override
  String get topicFastDelivery => 'Быстро привезли';

  @override
  String get topicLateDelivery => 'Доставка не пришла во время!';

  @override
  String get topicColdFood => 'Холодная еда';

  @override
  String get topicRudeCourier => 'Грубый курьер';

  @override
  String get profile => 'Профиль';

  @override
  String get bonus3Percent => 'Начисляем 3% с покупки';

  @override
  String get personalData => 'Личные данные и телефон';

  @override
  String get addressesMenuItem => 'Адреса';

  @override
  String get orderHistory => 'История заказ';

  @override
  String get inviteFriend => 'Пригласить друга';

  @override
  String get support => 'Поддержка';

  @override
  String get aboutChayxana => 'О Чайхане';

  @override
  String get logout => 'Выйти';

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get nameLabel => 'Имя Фамилия';

  @override
  String get emailLabel => 'Почта';

  @override
  String get language => 'Язык';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageEnglish => 'Английский';

  @override
  String get languageUzbek => 'Узбекский';

  @override
  String get splashTitle => 'ЧАЙХАНА';

  @override
  String get splashSubtitle => 'ТАШКЕНТ СИТИ';

  @override
  String get coinAccrual => 'Начисление монет';

  @override
  String get orders => 'Заказы';

  @override
  String get delivered => 'Доставлен';

  @override
  String get order => 'Заказ';

  @override
  String get deliveryDetails => 'Детали доставки';

  @override
  String get pickupOrder => 'Забрать заказ';

  @override
  String get orderDelivery => 'Доставка заказа';

  @override
  String get tinkoffPaymentLabel => 'Тинькофф оплата';

  @override
  String get inviteFriendTitle => 'Пригласить друга';

  @override
  String get inviteBonusTitle =>
      'Получи 500 ₽ бонус\nза каждого приглашенного друга';

  @override
  String get inviteBonusBody =>
      'Пригласите друга в Chayxala с помощью уникального промокода и получите скидку 500₽ на один заказ от 1200₽.';

  @override
  String get inviteByLink => 'Пригласить по ссылке';

  @override
  String get aboutUs => 'О нас';

  @override
  String get aboutUsBody =>
      'Мы готовим блюда, сохраняя рецепты, проверенные веками, и используем только свежие и натуральные ингредиенты';

  @override
  String get guestsAboutUs => 'Гости о нас';

  @override
  String get gallery => 'Галерея';

  @override
  String get galleryDescription =>
      'Наша чайхана — это не просто кафе, а уголок, где время замедляется, и можно по-настоящему расслабиться.';
}
