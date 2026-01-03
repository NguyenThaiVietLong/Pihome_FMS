import 'package:flutter/material.dart';

class SearchFilterSection extends StatelessWidget {
  final Map<String, String> groupedFilters;
  final int assetCount;
  final Function(String) onRemoveFilter;
  final VoidCallback? onFilterPressed;

  const SearchFilterSection({
    super.key,
    required this.groupedFilters,
    required this.assetCount,
    required this.onRemoveFilter,
    this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search Box
          TextField(
            decoration: InputDecoration(
              hintText: 'Mã/ Tên tài sản',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF1E3A8A)),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),

          const SizedBox(height: 12),

          // Filter and Tags Row
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // Filter Button
                      GestureDetector(
                        onTap: onFilterPressed,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.filter_alt, color: Colors.grey, size: 20),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Active Filter Tags (Grouped by category)
                      ...groupedFilters.entries.map((entry) {
                        final categoryName = entry.key;
                        final optionsText = entry.value;
                        
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _buildGroupedFilterChip(
                            category: categoryName,
                            options: optionsText,
                            onRemove: () => onRemoveFilter(categoryName),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Asset Count
              Text(
                '$assetCount Tài sản',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGroupedFilterChip({
    required String category,
    required String options,
    required VoidCallback onRemove,
  }) {
    // Determine color based on category
    Color chipColor;
    Color borderColor;
    Color textColor;
    
    switch (category) {
      case 'Tình trạng':
        chipColor = Colors.teal[50]!;
        borderColor = Colors.teal[200]!;
        textColor = Colors.teal[700]!;
        break;
      case 'Trạng thái':
        chipColor = Colors.orange[50]!;
        borderColor = Colors.orange[200]!;
        textColor = Colors.orange[700]!;
        break;
      case 'Hình thức':
        chipColor = Colors.blue[50]!;
        borderColor = Colors.blue[200]!;
        textColor = Colors.blue[700]!;
        break;
      default:
        chipColor = Colors.grey[50]!;
        borderColor = Colors.grey[200]!;
        textColor = Colors.grey[700]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Category name in bold
          Text(
            category,
            style: TextStyle(
              fontSize: 14,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          // Options text
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 150),
            child: Text(
              options,
              style: TextStyle(
                fontSize: 13,
                color: textColor,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: Icon(
              Icons.close,
              size: 16,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
