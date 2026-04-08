import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/food_models.dart';
import 'payment_screen.dart';

class CustomizeScreen extends StatefulWidget {
  final FoodItem food;
  final int portion;

  const CustomizeScreen({super.key, required this.food, required this.portion});

  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {
  double _spiciness = 0.6;
  late int _portion;
  late List<Topping> _toppings;
  late List<SideOption> _sides;

  @override
  void initState() {
    super.initState();
    _portion = widget.portion;
    _toppings = List.from(sampleToppings.map((t) => Topping(
          name: t.name,
          imageUrl: t.imageUrl,
          selected: t.selected,
        )));
    _sides = List.from(sampleSides.map((s) => SideOption(
          name: s.name,
          imageUrl: s.imageUrl,
          selected: s.selected,
        )));
  }

  double get _total => widget.food.price * _portion;

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
                  _buildHeader(context),
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

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        // Food image
        Container(
          height: 220,
          width: double.infinity,
          color: Colors.white,
          child: Image.network(
            widget.food.imageUrl,
            fit: BoxFit.contain,
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
          child: _CircleBtn(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.pop(context),
          ),
        ),
        // Search button
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          right: 16,
          child: _CircleBtn(icon: Icons.search, onTap: () {}),
        ),
        // Description overlay
        Positioned(
          right: 0,
          top: 60,
          child: Container(
            width: 180,
            padding: const EdgeInsets.all(12),
            child: Text(
              'Customize Your Burger to Your Tastes. Ultimate Experience',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Spicy slider
          _buildLabel('Spicy'),
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
              onChanged: (v) => setState(() => _spiciness = v),
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
          const SizedBox(height: 16),

          // Portion counter
          _buildLabel('Portion'),
          const SizedBox(height: 10),
          Row(
            children: [
              _PortionBtn(
                icon: Icons.remove,
                onTap: () { if (_portion > 1) setState(() => _portion--); },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '$_portion',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              _PortionBtn(
                icon: Icons.add,
                onTap: () => setState(() => _portion++),
                isPrimary: true,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Toppings
          _buildLabel('Toppings'),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _toppings.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final topping = _toppings[index];
                return _ToppingCard(
                  topping: topping,
                  onTap: () => setState(() => topping.selected = !topping.selected),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // Side options
          _buildLabel('Side options'),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _sides.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final side = _sides[index];
                return _SideCard(
                  side: side,
                  onTap: () => setState(() => side.selected = !side.selected),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 12, 20, MediaQuery.of(context).padding.bottom + 12),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.textGrey,
                ),
              ),
              Text(
                '\$${_total.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PaymentScreen(
                  total: _total,
                  food: widget.food,
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
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
        ],
      ),
    );
  }
}

class _CircleBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleBtn({required this.icon, required this.onTap});

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
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: AppColors.textDark),
      ),
    );
  }
}

class _PortionBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  const _PortionBtn({
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
          border: isPrimary ? null : Border.all(color: AppColors.cardBorder),
        ),
        child: Icon(icon, size: 16, color: isPrimary ? Colors.white : AppColors.textDark),
      ),
    );
  }
}

class _ToppingCard extends StatelessWidget {
  final Topping topping;
  final VoidCallback onTap;

  const _ToppingCard({required this.topping, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.bgGrey,
              borderRadius: BorderRadius.circular(12),
              border: topping.selected
                  ? Border.all(color: AppColors.primary, width: 2)
                  : null,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                topping.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.eco, color: AppColors.textGrey),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                topping.name,
                style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textGrey),
              ),
              const SizedBox(width: 2),
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: topping.selected ? AppColors.primary : AppColors.cardBorder,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, size: 10, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SideCard extends StatelessWidget {
  final SideOption side;
  final VoidCallback onTap;

  const _SideCard({required this.side, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.bgGrey,
              borderRadius: BorderRadius.circular(12),
              border: side.selected
                  ? Border.all(color: AppColors.primary, width: 2)
                  : null,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                side.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.restaurant, color: AppColors.textGrey),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                side.name,
                style: GoogleFonts.poppins(fontSize: 10, color: AppColors.textGrey),
              ),
              const SizedBox(width: 2),
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: side.selected ? AppColors.primary : AppColors.cardBorder,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, size: 10, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
