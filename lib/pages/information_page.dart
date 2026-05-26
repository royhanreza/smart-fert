import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../core/app_colors.dart';
import '../widgets/sensor_card.dart';
import '../widgets/animated_list_item.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
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
          'Informasi',
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
                          color: AppColors.primary,
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

            AnimatedListItem(
              index: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 16),
                child: Text(
                  'Data Sensor',
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
            ),

            AnimatedListItem(
              index: 1,
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
                      highlightMode: SensorHighlightMode.value,
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
                      highlightMode: SensorHighlightMode.value,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            AnimatedListItem(
              index: 2,
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
                      highlightMode: SensorHighlightMode.value,
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
                      highlightMode: SensorHighlightMode.value,
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
