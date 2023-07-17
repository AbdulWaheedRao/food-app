// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  String imageName;
  String discription;
  num price;
  String imageURL;
  String id;
  Product({
    required this.imageName,
    required this.discription,
    required this.price,
    required this.imageURL,
    required this.id,
  });

  Product copyWith({
    String? imageName,
    String? discription,
    num? price,
    String? imageURL,
    String? id,
  }) {
    return Product(
      imageName: imageName ?? this.imageName,
      discription: discription ?? this.discription,
      price: price ?? this.price,
      imageURL: imageURL ?? this.imageURL,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageName': imageName,
      'discription': discription,
      'price': price,
      'imageURL': imageURL,
      'id': id,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      imageName: map['imageName'] as String,
      discription: map['discription'] as String,
      price: map['price'] as num,
      imageURL: map['imageURL'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(imageName: $imageName, discription: $discription, price: $price, imageURL: $imageURL, id: $id)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.imageName == imageName &&
        other.discription == discription &&
        other.price == price &&
        other.imageURL == imageURL &&
        other.id == id;
  }

  @override
  int get hashCode {
    return imageName.hashCode ^
        discription.hashCode ^
        price.hashCode ^
        imageURL.hashCode ^
        id.hashCode;
  }
}
