class Asset {
  final String title;
  final String location;
  final String owner;
  final String category;
  final bool hasWarranty;
  final bool inUse;
  final bool isPinned;

  Asset({
    required this.title,
    required this.location,
    required this.owner,
    required this.category,
    this.hasWarranty = false,
    this.inUse = false,
    this.isPinned = false,
  });
}
