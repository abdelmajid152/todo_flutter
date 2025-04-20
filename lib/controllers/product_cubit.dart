import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todo_app/models/products_model.dart';
import 'package:meta/meta.dart';

import '../repos/product_repo.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductLoading());

  ProductRepo productRepo = ProductRepo();

  getLoadedProducts() async {
    try {
      final List<ProductsModel> products= await productRepo.getLoadedProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductErrorMessage(e.toString()));
    }
  }
}
