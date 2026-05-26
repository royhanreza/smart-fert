import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../core/app_colors.dart';
import '../widgets/moisture_gauge.dart';
import '../widgets/menu_card.dart';
import '../widgets/animated_list_item.dart';
import 'information_page.dart';
import 'recommendation_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.45],
            colors: [
              Color(0xFFEDF5EE), // very subtle green tint at top
              Color(0xFFF6F7FB), // regular background
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                AnimatedListItem(index: 0, child: _buildHeader(context)),
                const SizedBox(height: 28),

                // Moisture Gauge
                AnimatedListItem(
                  index: 1,
                  child: const MoistureGauge(percentage: 65, status: 'Cukup'),
                ),
                const SizedBox(height: 28),

                // Section title
                AnimatedListItem(
                  index: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 14),
                    child: Text(
                      'Menu',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),

                // Menu: Information
                AnimatedListItem(
                  index: 3,
                  child: MenuCard(
                    icon: Iconsax.chart_1,
                    title: 'Informasi',
                    subtitle: 'Data sensor tanah & cuaca',
                    iconColor: AppColors.primary,
                    onTap: () {
                      Navigator.push(
                        context,
                        _buildPageRoute(const InformationPage()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),

                // Menu: Recommendation
                AnimatedListItem(
                  index: 4,
                  child: MenuCard(
                    icon: Iconsax.tree,
                    title: 'Rekomendasi Pupuk',
                    subtitle: 'Jumlah pupuk yang dibutuhkan',
                    iconColor: AppColors.accent,
                    onTap: () {
                      Navigator.push(
                        context,
                        _buildPageRoute(const RecommendationPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          clipBehavior: Clip.antiAlias,
          child: Image.asset('assets/icon.png', fit: BoxFit.contain),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SmartFert',
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'Monitoring & Rekomendasi',
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  PageRouteBuilder _buildPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(curved),
          child: FadeTransition(opacity: curved, child: child),
        );
      },
    );
  }
}
