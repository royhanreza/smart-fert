import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../core/app_colors.dart';
import '../widgets/sensor_card.dart';
import '../widgets/animated_list_item.dart';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({super.key});

  @override
  State<RecommendationPage> createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  bool _isRefreshing = false;
  Key _animKey = UniqueKey();

  Future<void> _onRefresh() async {
    setState(() {
      _isRefreshing = true;
    });
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      setState(() {
        _isRefreshing = false;
        _animKey = UniqueKey();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rekomendasi Pupuk',
          style: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: _isRefreshing ? null : _onRefresh,
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _isRefreshing
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: AppColors.accent,
                        ),
                      )
                    : Icon(
                        Iconsax.refresh,
                        color: AppColors.textSecondary,
                        size: 22,
                      ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        key: _animKey,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLastUpdated(),
            // Recommendation hero card
            AnimatedListItem(index: 0, child: _buildRecommendationCard()),
            const SizedBox(height: 24),

            AnimatedListItem(
              index: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 14),
                child: Text(
                  'Detail Kondisi',
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
            ),

            AnimatedListItem(
              index: 2,
              child: Row(
                children: [
                  Expanded(
                    child: SensorCard(
                      icon: Iconsax.drop,
                      label: 'pH Tanah',
                      value: '6.5',
                      unit: 'pH',
                      status: 'Normal',
                      statusColor: AppColors.primary,
                      highlightMode: SensorHighlightMode.status,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SensorCard(
                      icon: Iconsax.cloud_drizzle,
                      label: 'Kelembaban',
                      value: '65',
                      unit: '%',
                      status: 'Cukup',
                      statusColor: AppColors.primary,
                      highlightMode: SensorHighlightMode.status,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            AnimatedListItem(
              index: 3,
              child: Row(
                children: [
                  Expanded(
                    child: SensorCard(
                      icon: Iconsax.flash_1,
                      label: 'EC Tanah',
                      value: '1.2',
                      unit: 'mS/cm',
                      status: 'Sedang',
                      statusColor: AppColors.accent,
                      highlightMode: SensorHighlightMode.status,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SensorCard(
                      icon: Iconsax.cloud_sunny,
                      label: 'Curah Hujan',
                      value: '120',
                      unit: 'mm',
                      status: 'Normal',
                      statusColor: AppColors.primary,
                      highlightMode: SensorHighlightMode.status,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Background Fertilizer Image
          Positioned(
            right: -250,
            bottom: -50,
            // top tidak perlu diisi agar tingginya tidak mengikuti tinggi card
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'assets/fertilizer.png',
                height: 450, // Set ukuran yang pas secara manual di sini
                fit: BoxFit.contain,
                // cacheHeight: 700, // Optimize memory decode
              ),
            ),
          ),

          // Foreground Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.accentTint,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(Iconsax.tree, color: AppColors.accent, size: 26),
                ),
                const SizedBox(height: 16),
                Text(
                  'Rekomendasi Pupuk',
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '300g/pokok',
                  style: GoogleFonts.outfit(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentTint,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Berdasarkan kondisi tanah saat ini',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastUpdated() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 4),
      child: Row(
        children: [
          Icon(Iconsax.clock, size: 14, color: AppColors.textTertiary),
          const SizedBox(width: 6),
          Text(
            'Terakhir diperbaharui: 7 Mei 2026, 21:10',
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
