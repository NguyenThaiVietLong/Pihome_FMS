import 'package:flutter/material.dart';
import '../models/filter_options.dart';

class FilterBottomSheet extends StatefulWidget {
  final FilterOptions initialFilters;
  final Function(FilterOptions) onApply;

  const FilterBottomSheet({
    super.key,
    required this.initialFilters,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late FilterOptions _filters;

  @override
  void initState() {
    super.initState();
    _filters = widget.initialFilters.copyWith();
  }

  void _toggleWarrantyStatus(WarrantyStatus status) {
    setState(() {
      if (_filters.warrantyStatuses.contains(status)) {
        _filters.warrantyStatuses.remove(status);
      } else {
        _filters.warrantyStatuses.add(status);
      }
    });
  }

  void _toggleUsageStatus(UsageStatus status) {
    setState(() {
      if (_filters.usageStatuses.contains(status)) {
        _filters.usageStatuses.remove(status);
      } else {
        _filters.usageStatuses.add(status);
      }
    });
  }

  void _toggleOwnershipType(OwnershipType type) {
    setState(() {
      if (_filters.ownershipTypes.contains(type)) {
        _filters.ownershipTypes.remove(type);
      } else {
        _filters.ownershipTypes.add(type);
      }
    });
  }

  void _toggleAllInCategory<T>(bool? value, List<T> allValues, Set<T> currentSelection) {
    setState(() {
      if (value == true) {
        currentSelection.addAll(allValues);
      } else {
        currentSelection.clear();
      }
    });
  }

  void _reset() {
    setState(() {
      _filters.reset();
    });
  }

  void _apply() {
    widget.onApply(_filters);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF18181B) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle & Header
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[600] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Bộ lọc',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, color: isDark ? const Color(0xFF3F3F46) : const Color(0xFFE5E7EB)),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tình trạng Section
                  _buildSection(
                    title: 'TÌNH TRẠNG',
                    allSelected: _filters.warrantyStatuses.length == WarrantyStatus.values.length,
                    onSelectAll: (value) => _toggleAllInCategory(
                      value,
                      WarrantyStatus.values,
                      _filters.warrantyStatuses,
                    ),
                    children: WarrantyStatus.values.map((status) {
                      return _buildCheckboxItem(
                        label: status.displayName,
                        value: _filters.warrantyStatuses.contains(status),
                        onChanged: (value) => _toggleWarrantyStatus(status),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),
                  Divider(height: 1, color: isDark ? const Color(0xFF3F3F46) : const Color(0xFFE5E7EB)),
                  const SizedBox(height: 24),

                  // Trạng thái Section
                  _buildSection(
                    title: 'TRẠNG THÁI',
                    allSelected: _filters.usageStatuses.length == UsageStatus.values.length,
                    onSelectAll: (value) => _toggleAllInCategory(
                      value,
                      UsageStatus.values,
                      _filters.usageStatuses,
                    ),
                    children: UsageStatus.values.map((status) {
                      return _buildCheckboxItem(
                        label: status.displayName,
                        value: _filters.usageStatuses.contains(status),
                        onChanged: (value) => _toggleUsageStatus(status),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),
                  Divider(height: 1, color: isDark ? const Color(0xFF3F3F46) : const Color(0xFFE5E7EB)),
                  const SizedBox(height: 24),

                  // Hình thức Section
                  _buildSection(
                    title: 'HÌNH THỨC',
                    allSelected: _filters.ownershipTypes.length == OwnershipType.values.length,
                    onSelectAll: (value) => _toggleAllInCategory(
                      value,
                      OwnershipType.values,
                      _filters.ownershipTypes,
                    ),
                    children: OwnershipType.values.map((type) {
                      return _buildCheckboxItem(
                        label: type.displayName,
                        value: _filters.ownershipTypes.contains(type),
                        onChanged: (value) => _toggleOwnershipType(type),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 100), // Space for bottom buttons
                ],
              ),
            ),
          ),

          // Bottom Action Buttons
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF18181B) : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark ? const Color(0xFF3F3F46) : const Color(0xFFE5E7EB),
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _reset,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Color(0xFFF59E0B)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Thiết lập lại',
                        style: TextStyle(
                          color: Color(0xFFF59E0B),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _apply,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: const Color(0xFFF59E0B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Áp dụng',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required bool allSelected,
    required Function(bool?) onSelectAll,
    required List<Widget> children,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            _CustomCheckbox(
              value: allSelected,
              onChanged: onSelectAll,
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildCheckboxItem({
    required String label,
    required bool value,
    required Function(bool?) onChanged,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          _CustomCheckbox(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

// Custom Checkbox Widget matching HTML design
class _CustomCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;

  const _CustomCheckbox({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: value ? const Color(0xFF1F2937) : Colors.transparent,
          border: Border.all(
            color: value
                ? const Color(0xFF1F2937)
                : (isDark ? const Color(0xFF6B7280) : const Color(0xFFD1D5DB)),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: value
            ? const Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
