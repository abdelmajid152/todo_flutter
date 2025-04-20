import 'package:equatable/equatable.dart';
import 'package:flutter_todo_app/models/rating_model.dart';

class ProductsModel extends Equatable {
// {"id":1,
// "title":"Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
// "price":109.95,
// "description":"Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
// "category":"men's clothing",
// "image":"https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
// "rating":{"rate":3.9,"count":120}}

  final int id;
  final String title;
  final num price;
  final String description;
  final String category;
  final String image;
  final RatingModel rating;

  const ProductsModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: RatingModel.fromJson(json['rating']),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        price,
        description,
        category,
        image,
        rating,
      ];
}


