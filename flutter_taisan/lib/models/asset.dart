import 'filter_options.dart';

class Asset {
  final String title;
  final String location;
  final String owner;
  final String category;
  final bool hasWarranty;
  final bool inUse;
  final bool isPinned;
  
  // Filter-related fields
  final WarrantyStatus warrantyStatus;
  final UsageStatus usageStatus;
  final OwnershipType ownershipType;

  Asset({
    required this.title,
    required this.location,
    required this.owner,
    required this.category,
    this.hasWarranty = false,
    this.inUse = false,
    this.isPinned = false,
    required this.warrantyStatus,
    required this.usageStatus,
    required this.ownershipType,
  });
}
