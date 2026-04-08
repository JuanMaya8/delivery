import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/food_models.dart';
import '../theme/app_theme.dart';
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
        Container(
          height: 300,
          width: double.infinity,
          color: Colors.white,
          alignment: Alignment.center,
          child: Image.network(
            widget.food.imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.bgGrey,
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(
                Icons.fastfood_rounded,
                size: 86,
                color: AppColors.textLight,
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 16,
          child: _CircleButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.pop(context),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          right: 16,
          child: _CircleButton(
            icon: Icons.search_rounded,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.food.name} ${widget.food.restaurant}',
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.star_rounded, color: AppColors.rating, size: 16),
              const SizedBox(width: 4),
              Text(
                '${widget.food.rating}',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textGrey,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '- ${widget.food.deliveryTime} mins',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.food.description,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: AppColors.textGrey,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Spicy',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 4,
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 7),
                        activeTrackColor: AppColors.primary,
                        inactiveTrackColor: AppColors.cardBorder,
                        thumbColor: AppColors.primary,
                        overlayColor: AppColors.primary.withOpacity(0.12),
                      ),
                      child: Slider(
                        value: _spiciness,
                        onChanged: (value) => setState(() => _spiciness = value),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Mild',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: const Color(0xFF41C352),
                          ),
                        ),
                        Text(
                          'Hot',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Portion',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
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
                        isPrimary: true,
                        onTap: () => setState(() => _portion++),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 34),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14),
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
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  'ORDER NOW',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.8,
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
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 16, color: AppColors.textDark),
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
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: isPrimary ? null : Border.all(color: AppColors.cardBorder),
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
