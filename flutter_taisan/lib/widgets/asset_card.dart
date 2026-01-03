import 'package:flutter/material.dart';
import '../models/asset.dart';

class AssetCard extends StatelessWidget {
  final Asset asset;

  const AssetCard({
    super.key,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Pink corner badge for pinned items
          if (asset.isPinned)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 96,
                height: 24,
                decoration: const BoxDecoration(
                  color: Color(0xFFFCE7F3),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
              ),
            ),

          // Card Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  asset.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),

                const SizedBox(height: 8),

                // Location
                _buildInfoRow(
                  icon: Icons.location_on,
                  text: asset.location,
                  isBold: true,
                ),

                const SizedBox(height: 8),

                // Owner
                _buildInfoRow(
                  icon: Icons.person,
                  text: asset.owner,
                ),

                const SizedBox(height: 8),

                // Category
                _buildInfoRow(
                  icon: Icons.label,
                  text: asset.category,
                ),

                const SizedBox(height: 12),

                // Status Tags
                if (asset.hasWarranty || asset.inUse)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (asset.hasWarranty)
                        _buildStatusChip(
                          label: 'CÒN BẢO HÀNH',
                          icon: Icons.verified_user,
                          backgroundColor: const Color(0xFFD1FAE5),
                          textColor: const Color(0xFF047857),
                        ),
                      if (asset.inUse)
                        _buildStatusChip(
                          label: 'ĐANG SỬ DỤNG',
                          backgroundColor: const Color(0xFFFEF3C7),
                          textColor: const Color(0xFFD97706),
                        ),
                    ],
                  )
                else
                  const Text(
                    'No warranty info',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String text,
    bool isBold = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey[400],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: isBold ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip({
    required String label,
    IconData? icon,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
