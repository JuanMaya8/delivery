import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/food_models.dart';
import 'product_detail_screen.dart';
import 'user_profile_screen.dart';
import 'customer_support_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNav = 0;
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Combos', 'Sliders', 'Classics'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      body: SafeArea(
        child: Column(
          children: [
            // White top section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(),
                  const SizedBox(height: 4),
                  Text(
                    'Order your favourite food!',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.textGrey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSearchBar(),
                  const SizedBox(height: 16),
                  _buildCategories(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            // Food grid
            Expanded(
              child: _buildFoodGrid(),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Foodgo',
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const UserProfileScreen()),
          ),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: const NetworkImage(
              'https://images.unsplash.com/photo-1494790108755-2616b612b494?w=100',
            ),
            backgroundColor: AppColors.bgGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.bgGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Icon(Icons.search, color: AppColors.textGrey, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Search',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textGrey,
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.tune, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final cat = _categories[index];
          final isSelected = cat == _selectedCategory;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.cardBorder,
                ),
              ),
              child: Text(
                cat,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : AppColors.textDark,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFoodGrid() {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemCount: sampleFoods.length,
      itemBuilder: (context, index) {
        return _FoodCard(
          food: sampleFoods[index],
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(food: sampleFoods[index]),
            ),
          ),
          onFavorite: () => setState(() {
            sampleFoods[index].isFavorite = !sampleFoods[index].isFavorite;
          }),
        );
      },
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: AppColors.primary,
      elevation: 4,
      child: const Icon(Icons.add, color: Colors.white, size: 28),
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: Colors.white,
      elevation: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home_rounded,
              isSelected: _selectedNav == 0,
              onTap: () => setState(() => _selectedNav = 0),
            ),
            _NavItem(
              icon: Icons.person_outline_rounded,
              isSelected: _selectedNav == 1,
              onTap: () {
                setState(() => _selectedNav = 1);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const UserProfileScreen()));
              },
            ),
            const SizedBox(width: 48), // FAB space
            _NavItem(
              icon: Icons.chat_bubble_outline_rounded,
              isSelected: _selectedNav == 2,
              onTap: () {
                setState(() => _selectedNav = 2);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const CustomerSupportScreen()));
              },
            ),
            _NavItem(
              icon: Icons.favorite_border_rounded,
              isSelected: _selectedNav == 3,
              onTap: () => setState(() => _selectedNav = 3),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Icon(
          icon,
          color: isSelected ? AppColors.primary : AppColors.textGrey,
          size: 26,
        ),
      ),
    );
  }
}

class _FoodCard extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const _FoodCard({
    required this.food,
    required this.onTap,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                food.imageUrl,
                height: 130,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  height: 130,
                  color: AppColors.bgGrey,
                  child: const Icon(Icons.fastfood, size: 48, color: AppColors.textLight),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    food.restaurant,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: AppColors.textGrey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: AppColors.rating, size: 15),
                      const SizedBox(width: 2),
                      Text(
                        '${food.rating}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: onFavorite,
                        child: Icon(
                          food.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: food.isFavorite ? AppColors.primary : AppColors.textGrey,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
