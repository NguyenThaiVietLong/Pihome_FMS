// Filter enums
enum WarrantyStatus {
  notYetDue('Chưa tới thời hạn'),
  withinPeriod('Trong thời hạn'),
  nearExpiry('Sắp đến thời hạn'),
  expired('Hết thời hạn');

  final String displayName;
  const WarrantyStatus(this.displayName);
}

enum UsageStatus {
  inUse('Đang sử dụng'),
  notInUse('Ngưng sử dụng'),
  underRepair('Chờ sửa chữa'),
  cancelled('Hủy');

  final String displayName;
  const UsageStatus(this.displayName);
}

enum OwnershipType {
  investor('Chủ đầu tư'),
  managementBoard('Ban quản lý'),
  boardOfDirectors('Ban quản trị'),
  customer('Khách hàng'),
  other('Các đơn vị khác');

  final String displayName;
  const OwnershipType(this.displayName);
}

// Filter options class
class FilterOptions {
  Set<WarrantyStatus> warrantyStatuses;
  Set<UsageStatus> usageStatuses;
  Set<OwnershipType> ownershipTypes;

  FilterOptions({
    Set<WarrantyStatus>? warrantyStatuses,
    Set<UsageStatus>? usageStatuses,
    Set<OwnershipType>? ownershipTypes,
  })  : warrantyStatuses = warrantyStatuses ?? {},
        usageStatuses = usageStatuses ?? {},
        ownershipTypes = ownershipTypes ?? {};

  // Check if any filters are active
  bool get hasActiveFilters =>
      warrantyStatuses.isNotEmpty ||
      usageStatuses.isNotEmpty ||
      ownershipTypes.isNotEmpty;

  // Get count of active filters
  int get activeFilterCount =>
      warrantyStatuses.length +
      usageStatuses.length +
      ownershipTypes.length;

  // Reset all filters
  void reset() {
    warrantyStatuses.clear();
    usageStatuses.clear();
    ownershipTypes.clear();
  }

  // Get all active filter labels
  List<String> get activeFilterLabels {
    final labels = <String>[];
    labels.addAll(warrantyStatuses.map((e) => e.displayName));
    labels.addAll(usageStatuses.map((e) => e.displayName));
    labels.addAll(ownershipTypes.map((e) => e.displayName));
    return labels;
  }

  // Get grouped filter chips (one per category)
  Map<String, String> get groupedFilterChips {
    final chips = <String, String>{};
    
    if (warrantyStatuses.isNotEmpty) {
      final labels = warrantyStatuses.map((e) => e.displayName).toList();
      chips['Tình trạng'] = labels.length > 2
          ? '${labels.take(2).join(', ')}, ...'
          : labels.join(', ');
    }
    
    if (usageStatuses.isNotEmpty) {
      final labels = usageStatuses.map((e) => e.displayName).toList();
      chips['Trạng thái'] = labels.length > 2
          ? '${labels.take(2).join(', ')}, ...'
          : labels.join(', ');
    }
    
    if (ownershipTypes.isNotEmpty) {
      final labels = ownershipTypes.map((e) => e.displayName).toList();
      chips['Hình thức'] = labels.length > 2
          ? '${labels.take(2).join(', ')}, ...'
          : labels.join(', ');
    }
    
    return chips;
  }

  // Copy method
  FilterOptions copyWith({
    Set<WarrantyStatus>? warrantyStatuses,
    Set<UsageStatus>? usageStatuses,
    Set<OwnershipType>? ownershipTypes,
  }) {
    return FilterOptions(
      warrantyStatuses: warrantyStatuses ?? Set.from(this.warrantyStatuses),
      usageStatuses: usageStatuses ?? Set.from(this.usageStatuses),
      ownershipTypes: ownershipTypes ?? Set.from(this.ownershipTypes),
    );
  }
}
