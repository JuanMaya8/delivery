import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/food_models.dart';
import 'success_screen.dart';

class PaymentScreen extends StatefulWidget {
  final double total;
  final FoodItem food;

  const PaymentScreen({super.key, required this.total, required this.food});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPayment = 0; // 0=credit card, 1=debit card
  bool _saveCard = true;

  double get _taxes => 0.3;
  double get _deliveryFee => 1.5;
  double get _grandTotal => widget.total + _taxes + _deliveryFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildOrderSummary(),
                    const SizedBox(height: 32),
                    _buildPaymentMethods(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: AppColors.textDark, size: 20),
          ),
          Text(
            '',
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const Icon(Icons.search, color: AppColors.textDark, size: 22),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order summary',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 20),
        _SummaryRow(label: 'Order', value: '\$${widget.total.toStringAsFixed(2)}'),
        const SizedBox(height: 12),
        _SummaryRow(label: 'Taxes', value: '\$${_taxes.toStringAsFixed(1)}'),
        const SizedBox(height: 12),
        _SummaryRow(label: 'Delivery fees', value: '\$${_deliveryFee.toStringAsFixed(1)}'),
        const SizedBox(height: 16),
        const Divider(color: AppColors.cardBorder, thickness: 1),
        const SizedBox(height: 16),
        _SummaryRow(
          label: 'Total:',
          value: '\$${_grandTotal.toStringAsFixed(2)}',
          isBold: true,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Estimated delivery time:',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: AppColors.textGrey,
              ),
            ),
            Text(
              '15 - 30mins',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: AppColors.textDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment methods',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 16),
        // Credit card
        _PaymentMethodCard(
          isSelected: _selectedPayment == 0,
          onTap: () => setState(() => _selectedPayment = 0),
          child: Row(
            children: [
              // Mastercard logo
              Container(
                width: 48,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFEB001B),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 4,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEB001B),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 4,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF79E1B).withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const Text(
                      'MC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Credit card',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    '5165 **** **** 0505',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _RadioDot(isSelected: _selectedPayment == 0),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Debit card (VISA)
        _PaymentMethodCard(
          isSelected: _selectedPayment == 1,
          onTap: () => setState(() => _selectedPayment = 1),
          child: Row(
            children: [
              // Visa logo
              Container(
                width: 48,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1F71),
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.center,
                child: Text(
                  'VISA',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Debit card',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    '3566 **** **** 0505',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _RadioDot(isSelected: _selectedPayment == 1),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Save card checkbox
        GestureDetector(
          onTap: () => setState(() => _saveCard = !_saveCard),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: _saveCard ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: _saveCard ? AppColors.primary : AppColors.cardBorder,
                  ),
                ),
                child: _saveCard
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 10),
              Text(
                'Save card details for future payments',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
        ),
      ],
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total price',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.textGrey,
                ),
              ),
              Text(
                '\$${_grandTotal.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => _showSuccessDialog(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Pay Now',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const SuccessDialog(),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: isBold ? AppColors.textDark : AppColors.textGrey,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: AppColors.textDark,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final Widget child;

  const _PaymentMethodCard({
    required this.isSelected,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.cardBorder,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  final bool isSelected;

  const _RadioDot({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.cardBorder,
          width: 2,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            )
          : null,
    );
  }
}
