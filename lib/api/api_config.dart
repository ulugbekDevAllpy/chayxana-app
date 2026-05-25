/// ============================================================
/// Backend integratsiyasi konfiguratsiyasi
/// ============================================================
/// Sizning haqiqiy backend Postman collection asosida sozlangan.
/// API URL'ni o'zgartirish kerak bo'lsa, faqat [baseUrl] ni yangilang.
/// ============================================================
class ApiConfig {
  ApiConfig._();

  /// Backend manzili — postman'dagi `{{url}}` o'zgaruvchisi
  /// Misol: 'https://api.tashkentciti.ru/api'
  /// Bo'sh qoldirilsa, ilova mock ma'lumot bilan ishlaydi.
  static const String baseUrl = '';

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);

  /// API javob bermasa mock ma'lumotga qaytish (default true)
  static const bool useMockFallback = true;

  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}

/// Postman collection asosida endpoint'lar
class Endpoints {
  Endpoints._();

  // ─── Auth ────────────────────────────────────────────────
  /// POST /login/user — { phone, password }
  static const String login = '/login/user';

  /// POST /register — { phone, password, mail, referal }
  static const String signUp = '/register';

  /// GET /me — joriy foydalanuvchi (Bearer token bilan)
  static const String me = '/me';

  /// PATCH /user/{id} — multipart form (name, surname, mail, address, entrance, floor, room, photo...)
  static String updateUser(String id) => '/user/$id';

  // ─── Catalog / Menu ─────────────────────────────────────
  /// GET /products/category — kategoriyalar ro'yxati
  static const String categories = '/products/category';

  /// GET /product?category_id={id} — kategoriya bo'yicha mahsulotlar
  static const String products = '/product';

  /// GET /product/{id} — bitta mahsulot
  static String productById(String id) => '/product/$id';

  /// GET /products/search?search={q}
  static const String productsSearch = '/products/search';

  // ─── Stories ─────────────────────────────────────────────
  /// GET /stories
  static const String stories = '/stories';
  static String storyById(String id) => '/stories/$id';

  // ─── Orders (requests) ──────────────────────────────────
  /// POST /request — buyurtma yuborish
  static const String placeOrder = '/request';

  // ─── Promo ───────────────────────────────────────────────
  /// GET /check/promo?check_promo={code}
  static const String checkPromo = '/check/promo';

  /// GET /discounts/request?promo_code={code}
  static const String applyPromo = '/discounts/request';

  // ─── Branches & Tables ──────────────────────────────────
  /// GET /lists/branches
  static const String branches = '/lists/branches';

  /// GET /lists/tables yoki GET /tables?branch_id={id}
  static const String listsTables = '/lists/tables';
  static const String tables = '/tables';

  // ─── Gallery ─────────────────────────────────────────────
  /// GET /gallery
  static const String gallery = '/gallery';
  static String galleryById(String id) => '/gallery/$id';

  // ─── Feedbacks (mehmonlar sharhi) ──────────────────────
  /// GET /feedbacks
  static const String feedbacks = '/feedbacks';
  static String feedbackById(String id) => '/feedbacks/$id';

  // ─── Workers (oshpaz va xodimlar) ──────────────────────
  /// GET /workers
  static const String workers = '/workers';
  static String workerById(String id) => '/workers/$id';
  static String rateWorker(String id) => '/rate/workers/$id';

  // ─── Notes (eslatmalar) ─────────────────────────────────
  static const String notes = '/notes';
  static String noteById(String id) => '/notes/$id';

  // ─── Courier (kuryer rejimi) ───────────────────────────
  static const String courier = '/courier';
  static const String courierApply = '/courier/new';

  // ─── Chat ────────────────────────────────────────────────
  static const String chatDialogs = '/chat/dialogs';
  static const String chatDialog = '/chat/dialog';
  static String chatMessages(String dialogId) => '/chat/messages/$dialogId';
  static const String chatSendMessage = '/chat/messages';
}
