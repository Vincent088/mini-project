class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as int,
        title: json['title'] as String? ?? '',
        description: json['description'] as String? ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0,
        discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0,
        rating: (json['rating'] as num?)?.toDouble() ?? 0,
        stock: json['stock'] as int? ?? 0,
        brand: json['brand'] as String? ?? '',
        category: json['category'] as String? ?? '',
        thumbnail: json['thumbnail'] as String? ?? '',
        images: (json['images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'discountPercentage': discountPercentage,
        'rating': rating,
        'stock': stock,
        'brand': brand,
        'category': category,
        'thumbnail': thumbnail,
        'images': images,
      };

  ProductModel copyWith({
    String? title,
    String? description,
    double? price,
    int? stock,
    String? brand,
    String? category,
  }) =>
      ProductModel(
        id: id,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        discountPercentage: discountPercentage,
        rating: rating,
        stock: stock ?? this.stock,
        brand: brand ?? this.brand,
        category: category ?? this.category,
        thumbnail: thumbnail,
        images: images,
      );
}

class ProductListResponse {
  final List<ProductModel> products;
  final int total;
  final int skip;
  final int limit;

  const ProductListResponse({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductListResponse.fromJson(Map<String, dynamic> json) => ProductListResponse(
        products: (json['products'] as List<dynamic>?)
                ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        total: json['total'] as int? ?? 0,
        skip: json['skip'] as int? ?? 0,
        limit: json['limit'] as int? ?? 0,
      );
}
