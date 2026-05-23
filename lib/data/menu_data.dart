import '../models/menu_item.dart';

const menuCategories = <MenuCategory>[
  MenuCategory(id: 'new', name: 'Новинки'),
  MenuCategory(id: 'shashlyk', name: 'Шашлык'),
  MenuCategory(id: 'hot', name: 'Горячие блюда'),
  MenuCategory(id: 'salads', name: 'Салаты'),
  MenuCategory(id: 'snacks', name: 'Закуски'),
];

String _img(int seed) => 'https://picsum.photos/seed/chayxana$seed/400/300';

final menuItems = <MenuItem>[
  MenuItem(id: 'n1', name: 'Мясо Гарнир', priceRub: 485, imageUrl: _img(11), categoryId: 'new'),
  MenuItem(id: 'n2', name: 'Шурпа', priceRub: 485, imageUrl: _img(12), categoryId: 'new'),
  MenuItem(id: 'n3', name: 'Лагман', priceRub: 520, imageUrl: _img(13), categoryId: 'new'),
  MenuItem(id: 'n4', name: 'Манты', priceRub: 460, imageUrl: _img(14), categoryId: 'new'),
  MenuItem(
    id: 's1',
    name: 'Шашлык корейка',
    priceRub: 485,
    oldPriceRub: 560,
    imageUrl: _img(21),
    categoryId: 'shashlyk',
    description:
        'Баранина считается лучшим мясом в Узбекистане. Она не имеет постороннего неприятного запаха, потому что здесь выращивают только курдючных баранов, не шерстных, которые имеют специфический запах.',
    portions: [
      Portion(pieces: 6, weightGram: 150, addPriceRub: 0),
      Portion(pieces: 8, weightGram: 180, addPriceRub: 90),
      Portion(pieces: 12, weightGram: 300, addPriceRub: 120),
    ],
  ),
  MenuItem(id: 's2', name: 'Шашлык из курицы', priceRub: 420, imageUrl: _img(22), categoryId: 'shashlyk'),
  MenuItem(id: 's3', name: 'Шашлык из говядины', priceRub: 510, imageUrl: _img(23), categoryId: 'shashlyk'),
  MenuItem(id: 's4', name: 'Люля-кебаб', priceRub: 495, imageUrl: _img(24), categoryId: 'shashlyk'),
  MenuItem(id: 'h1', name: 'Плов', priceRub: 450, imageUrl: _img(31), categoryId: 'hot'),
  MenuItem(id: 'h2', name: 'Казан-кабоб', priceRub: 580, imageUrl: _img(32), categoryId: 'hot'),
  MenuItem(id: 'sa1', name: 'Ачичук', priceRub: 280, imageUrl: _img(41), categoryId: 'salads'),
  MenuItem(id: 'sa2', name: 'Сельдь под шубой', priceRub: 320, imageUrl: _img(42), categoryId: 'salads'),
  MenuItem(id: 'sn1', name: 'Самса', priceRub: 180, imageUrl: _img(51), categoryId: 'snacks'),
  MenuItem(id: 'sn2', name: 'Чучвара', priceRub: 240, imageUrl: _img(52), categoryId: 'snacks'),
];

final popularItems = <MenuItem>[
  menuItems[4],
  menuItems[8],
  menuItems[0],
  menuItems[3],
];

class StoryCard {
  const StoryCard({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.headline,
    required this.body,
    required this.ctaLabel,
  });
  final String id;
  final String title;
  final String coverUrl;
  final String headline;
  final String body;
  final String ctaLabel;
}

const stories = <StoryCard>[
  StoryCard(
    id: 'st1',
    title: 'Приведи друга,\nполучишь -500₽',
    coverUrl: 'https://picsum.photos/seed/story1/600/900',
    headline: 'Приведи Друга\nПолучишь 500р',
    body: 'Приведи друга в нашу столовую, и мы подарим тебе 500р скидку на каждый ваш визит. Чем больше друзей, тем больше акций.',
    ctaLabel: 'Пригласить',
  ),
  StoryCard(
    id: 'st2',
    title: 'Скидка\n15% от цены',
    coverUrl: 'https://picsum.photos/seed/story2/600/900',
    headline: 'Скидка 15%\nот цены',
    body: 'Только на этой неделе — скидка 15% на все горячие блюда и шашлык. Заходи и попробуй наши фирменные рецепты.',
    ctaLabel: 'Заказать',
  ),
  StoryCard(
    id: 'st3',
    title: 'Скидка\n15% от цены',
    coverUrl: 'https://picsum.photos/seed/story3/600/900',
    headline: 'Скидка 15%\nот цены',
    body: 'Доставка по городу со скидкой 15%. Минимальная сумма заказа — 1000₽. Принимаем заказы с 10:00 до 23:00.',
    ctaLabel: 'Заказать',
  ),
  StoryCard(
    id: 'st4',
    title: 'Скидка\n15% от цены',
    coverUrl: 'https://picsum.photos/seed/story4/600/900',
    headline: 'Скидка 15%\nот цены',
    body: 'Зарегистрируйся в нашей программе лояльности и получай постоянные скидки на любимые блюда.',
    ctaLabel: 'Подключить',
  ),
];
