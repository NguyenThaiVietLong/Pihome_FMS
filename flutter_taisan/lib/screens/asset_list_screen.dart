import 'package:flutter/material.dart';
import '../models/asset.dart';
import '../models/filter_options.dart';
import '../widgets/asset_card.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/search_filter_section.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/filter_bottom_sheet.dart';

class AssetListScreen extends StatefulWidget {
  const AssetListScreen({super.key});

  @override
  State<AssetListScreen> createState() => _AssetListScreenState();
}

class _AssetListScreenState extends State<AssetListScreen> {
  int _selectedTab = 0;
  int _selectedBottomNav = 1;
  FilterOptions _filterOptions = FilterOptions();

  // Sample data with updated filter fields
  final List<Asset> _allAssets = [
    Asset(
      title: 'Đèn hành lang tầng G',
      location: 'CHILL CORNER/BLOCK A/A0102',
      owner: 'Chủ đầu tư',
      category: 'Hệ thống điện',
      hasWarranty: true,
      inUse: true,
      isPinned: true,
      warrantyStatus: WarrantyStatus.withinPeriod,
      usageStatus: UsageStatus.inUse,
      ownershipType: OwnershipType.investor,
    ),
    Asset(
      title: 'Đèn hành lang tầng G',
      location: 'CHILL CORNER/BLOCK A/A0102',
      owner: 'Chủ đầu tư',
      category: 'Hệ thống điện',
      hasWarranty: true,
      inUse: true,
      isPinned: false,
      warrantyStatus: WarrantyStatus.withinPeriod,
      usageStatus: UsageStatus.inUse,
      ownershipType: OwnershipType.investor,
    ),
    Asset(
      title: 'Đèn hành lang tầng G',
      location: 'CHILL CORNER/BLOCK A/A0102',
      owner: 'Chủ đầu tư',
      category: 'Hệ thống điện',
      hasWarranty: true,
      inUse: true,
      isPinned: true,
      warrantyStatus: WarrantyStatus.withinPeriod,
      usageStatus: UsageStatus.inUse,
      ownershipType: OwnershipType.investor,
    ),
    Asset(
      title: 'Hệ thống HVAC',
      location: 'CHILL CORNER/BLOCK B/B0201',
      owner: 'Ban quản lý',
      category: 'Hệ thống điều hòa',
      hasWarranty: false,
      inUse: false,
      isPinned: false,
      warrantyStatus: WarrantyStatus.expired,
      usageStatus: UsageStatus.underRepair,
      ownershipType: OwnershipType.managementBoard,
    ),
    Asset(
      title: 'Thang máy số 1',
      location: 'CHILL CORNER/BLOCK A/LOBBY',
      owner: 'Ban quản trị',
      category: 'Hệ thống vận chuyển',
      hasWarranty: true,
      inUse: true,
      isPinned: false,
      warrantyStatus: WarrantyStatus.nearExpiry,
      usageStatus: UsageStatus.inUse,
      ownershipType: OwnershipType.boardOfDirectors,
    ),
  ];

  // Apply filters to asset list
  List<Asset> get _filteredAssets {
    if (!_filterOptions.hasActiveFilters) {
      return _allAssets;
    }

    return _allAssets.where((asset) {
      bool matchesWarranty = _filterOptions.warrantyStatuses.isEmpty ||
          _filterOptions.warrantyStatuses.contains(asset.warrantyStatus);
      
      bool matchesUsage = _filterOptions.usageStatuses.isEmpty ||
          _filterOptions.usageStatuses.contains(asset.usageStatus);
      
      bool matchesOwnership = _filterOptions.ownershipTypes.isEmpty ||
          _filterOptions.ownershipTypes.contains(asset.ownershipType);

      return matchesWarranty && matchesUsage && matchesOwnership;
    }).toList();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: FilterBottomSheet(
          initialFilters: _filterOptions,
          onApply: (filters) {
            setState(() {
              _filterOptions = filters;
            });
          },
        ),
      ),
    );
  }

  void _removeFilter(String categoryName) {
    setState(() {
      // Remove entire category based on category name
      switch (categoryName) {
        case 'Tình trạng':
          _filterOptions.warrantyStatuses.clear();
          break;
        case 'Trạng thái':
          _filterOptions.usageStatuses.clear();
          break;
        case 'Hình thức':
          _filterOptions.ownershipTypes.clear();
          break;
      }
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
            groupedFilters: _filterOptions.groupedFilterChips,
            assetCount: _filteredAssets.length,
            onRemoveFilter: _removeFilter,
            onFilterPressed: _showFilterBottomSheet,
          ),
          
          // Asset List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredAssets.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AssetCard(asset: _filteredAssets[index]),
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

