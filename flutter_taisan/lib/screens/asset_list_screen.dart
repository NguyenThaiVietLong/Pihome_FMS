import 'package:flutter/material.dart';
import '../models/asset.dart';
import '../widgets/asset_card.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/search_filter_section.dart';
import '../widgets/bottom_nav_bar.dart';

class AssetListScreen extends StatefulWidget {
  const AssetListScreen({super.key});

  @override
  State<AssetListScreen> createState() => _AssetListScreenState();
}

class _AssetListScreenState extends State<AssetListScreen> {
  int _selectedTab = 0;
  int _selectedBottomNav = 1;
  final List<String> _activeFilters = ['Đang sử dụng', 'Trong thời hạn'];

  // Sample data
  final List<Asset> _assets = [
    Asset(
      title: 'Đèn hành lang tầng G',
      location: 'CHILL CORNER/BLOCK A/A0102',
      owner: 'Chủ đầu tư',
      category: 'Hệ thống điện',
      hasWarranty: true,
      inUse: true,
      isPinned: true,
    ),
    Asset(
      title: 'Đèn hành lang tầng G',
      location: 'CHILL CORNER/BLOCK A/A0102',
      owner: 'Chủ đầu tư',
      category: 'Hệ thống điện',
      hasWarranty: true,
      inUse: true,
      isPinned: false,
    ),
    Asset(
      title: 'Đèn hành lang tầng G',
      location: 'CHILL CORNER/BLOCK A/A0102',
      owner: 'Chủ đầu tư',
      category: 'Hệ thống điện',
      hasWarranty: true,
      inUse: true,
      isPinned: true,
    ),
    Asset(
      title: 'Đèn hành lang tầng G',
      location: 'CHILL CORNER/BLOCK A/A0102',
      owner: 'Chủ đầu tư',
      category: 'Hệ thống điện',
      hasWarranty: false,
      inUse: false,
      isPinned: false,
    ),
  ];

  void _removeFilter(String filter) {
    setState(() {
      _activeFilters.remove(filter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom App Bar with status bar, title, and tabs
          CustomAppBar(
            selectedTab: _selectedTab,
            onTabChanged: (index) {
              setState(() {
                _selectedTab = index;
              });
            },
          ),
          
          // Search and Filter Section
          SearchFilterSection(
            activeFilters: _activeFilters,
            assetCount: _assets.length,
            onRemoveFilter: _removeFilter,
          ),
          
          // Asset List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _assets.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AssetCard(asset: _assets[index]),
                );
              },
            ),
          ),
        ],
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedBottomNav,
        onItemSelected: (index) {
          setState(() {
            _selectedBottomNav = index;
          });
        },
      ),
    );
  }
}
