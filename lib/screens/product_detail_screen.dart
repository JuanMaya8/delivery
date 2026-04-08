import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/food_models.dart';
import 'customize_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final FoodItem food;

  const ProductDetailScreen({super.key, required this.food});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  double _spiciness = 0.4;
  int _portion = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroImage(context),
                  _buildContent(),
                ],
              ),
            ),
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    return Stack(
      children: [
        // Food image
        Container(
          height: 280,
          width: double.infinity,
          color: Colors.white,
          child: Image.network(
            widget.food.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: AppColors.bgGrey,
              child: const Icon(Icons.fastfood, size: 80, color: AppColors.textLight),
            ),
          ),
        ),
        // Back button
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          child: _CircleButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.pop(context),
          ),
        ),
        // Search button
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          right: 16,
          child: _CircleButton(
            icon: Icons.search,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            children: [
              Expanded(
                child: Text(
                  '${widget.food.name} ${widget.food.restaurant}',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Rating & time
          Row(
            children: [
              const Icon(Icons.star_rounded, color: AppColors.rating, size: 16),
              const SizedBox(width: 4),
              Text(
                '${widget.food.rating}',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '— ${widget.food.deliveryTime} mins',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Description
          Text(
            widget.food.description,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: AppColors.textGrey,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          // Spicy & Portion row
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Spicy slider
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Spicy',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 4,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                        activeTrackColor: AppColors.primary,
                        inactiveTrackColor: AppColors.cardBorder,
                        thumbColor: AppColors.primary,
                        overlayColor: AppColors.primary.withOpacity(0.2),
                      ),
                      child: Slider(
                        value: _spiciness,
                        onChanged: (val) => setState(() => _spiciness = val),
                        min: 0,
                        max: 1,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Mild', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.primary)),
                        Text('Hot', style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textGrey)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              // Portion counter
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Portion',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _PortionButton(
                        icon: Icons.remove,
                        onTap: () {
                          if (_portion > 1) setState(() => _portion--);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          '$_portion',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      _PortionButton(
                        icon: Icons.add,
                        onTap: () => setState(() => _portion++),
                        isPrimary: true,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Price button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '\$${widget.food.price.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Order Now button
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CustomizeScreen(
                    food: widget.food,
                    portion: _portion,
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  'ORDER NOW',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: AppColors.textDark),
      ),
    );
  }
}

class _PortionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const _PortionButton({
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: isPrimary
              ? null
              : Border.all(color: AppColors.cardBorder),
        ),
        child: Icon(
          icon,
          size: 16,
          color: isPrimary ? Colors.white : AppColors.textDark,
        ),
      ),
    );
  }
}
