part of 'product_cubit.dart';

@immutable
sealed class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<ProductsModel> productList;

  ProductLoaded(this.productList);

  @override
  List<Object?> get props => [productList];
}

final class ProductErrorMessage extends ProductState {
  final String errorMessage;

  ProductErrorMessage(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
