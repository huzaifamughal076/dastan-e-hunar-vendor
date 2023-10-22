part of 'get_product_cubit.dart';

class GetProductState {
  final List? products;
  final RequestStatus requestStatus;
  const GetProductState(
      {this.requestStatus = RequestStatus.initial, this.products});
}
