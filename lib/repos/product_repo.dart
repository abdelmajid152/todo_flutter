import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/products_model.dart';

class ProductRepo {

  getLoadedProducts() async {
    try
    {

      var url = Uri.https('fakestoreapi.com', 'products');
      var response = await http.get(url);


      if(response.statusCode==200){
        // Parse the response

        final list= json.decode(response.body) as List<dynamic>;


        final List<ProductsModel> listOfProduct= list.map((json) => ProductsModel.fromJson(json)).toList();

        return  listOfProduct;

      } else {
        throw Exception('Failed to load products because of ${response.statusCode}');
      }




    } catch (e) {
      print(e);
      throw Exception('Failed to load products $e');
    }

  }
}
