class FoodItem {
  final String id;
  final String name;
  final String restaurant;
  final String description;
  final double price;
  final double rating;
  final int deliveryTime; // minutes
  final String imageUrl;
  bool isFavorite;

  FoodItem({
    required this.id,
    required this.name,
    required this.restaurant,
    required this.description,
    required this.price,
    required this.rating,
    required this.deliveryTime,
    required this.imageUrl,
    this.isFavorite = false,
  });
}

class Topping {
  final String name;
  final String imageUrl;
  bool selected;

  Topping({required this.name, required this.imageUrl, this.selected = false});
}

class SideOption {
  final String name;
  final String imageUrl;
  bool selected;

  SideOption({required this.name, required this.imageUrl, this.selected = false});
}

final List<FoodItem> sampleFoods = [
  FoodItem(
    id: '1',
    name: 'Cheeseburger',
    restaurant: "Wendy's Burger",
    description:
        "The Cheeseburger Wendy's Burger is a classic fast food burger that packs a punch of flavor in every bite. Made with a juicy beef patty cooked to perfection, it's topped with melted American cheese, crispy lettuce, ripe tomato, and crunchy pickles.",
    price: 8.24,
    rating: 4.9,
    deliveryTime: 26,
    imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600',
    isFavorite: false,
  ),
  FoodItem(
    id: '2',
    name: 'Hamburger',
    restaurant: 'Veggie Burger',
    description:
        'Enjoy our delicious Hamburger Veggie Burger, made with a savory blend of fresh vegetables and herbs, topped with crisp lettuce, juicy tomatoes, and tangy pickles, all served on a soft, toasted bun.',
    price: 9.99,
    rating: 4.8,
    deliveryTime: 14,
    imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=600',
    isFavorite: true,
  ),
  FoodItem(
    id: '3',
    name: 'Hamburger',
    restaurant: 'Chicken Burger',
    description:
        'Our chicken burger is a delicious and healthier alternative to traditional beef burgers, perfect for those looking for a lighter meal option. Try it today and experience the mouth-watering flavors of our Hamburger Chicken Burger!',
    price: 12.48,
    rating: 4.6,
    deliveryTime: 42,
    imageUrl: 'https://images.unsplash.com/photo-1553979459-d2229ba7433a?w=600',
    isFavorite: false,
  ),
  FoodItem(
    id: '4',
    name: 'Hamburger',
    restaurant: 'Fried Chicken Burger',
    description:
        'Indulge in our crispy and savory Fried Chicken Burger, made with a juicy chicken patty, hand-breaded and deep-fried to perfection, served on a warm bun with lettuce, tomato, and a creamy sauce.',
    price: 26.99,
    rating: 4.5,
    deliveryTime: 14,
    imageUrl: 'https://images.unsplash.com/photo-1562967914-608f82629710?w=600',
    isFavorite: false,
  ),
];

final List<Topping> sampleToppings = [
  Topping(name: 'Tomato', imageUrl: 'https://images.unsplash.com/photo-1558818498-28c1e002b655?w=100', selected: true),
  Topping(name: 'Onions', imageUrl: 'https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?w=100', selected: false),
  Topping(name: 'Pickles', imageUrl: 'https://images.unsplash.com/photo-1632778149955-e80f8ceca2e8?w=100', selected: false),
  Topping(name: 'Bacons', imageUrl: 'https://images.unsplash.com/photo-1553909489-cd47e0907980?w=100', selected: false),
];

final List<SideOption> sampleSides = [
  SideOption(name: 'Fries', imageUrl: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=100', selected: true),
  SideOption(name: 'Coleslaw', imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=100', selected: false),
  SideOption(name: 'Salad', imageUrl: 'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=100', selected: false),
  SideOption(name: 'Onion', imageUrl: 'https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?w=100', selected: false),
];
