class ImageEntity {
final int id;
final String? url;    
final int? sortOrder;

 const ImageEntity({
    required this.id,
    required this.url,
    this.sortOrder,
  });
}