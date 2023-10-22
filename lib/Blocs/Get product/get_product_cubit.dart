import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Utils/utils.dart';

part 'get_product_state.dart';

class GetProductCubit extends Cubit<GetProductState> {
  GetProductCubit() : super(const GetProductState());
  Future<void> getProducts(String uid) async {
    emit(const GetProductState(requestStatus: RequestStatus.loading));
    try {
      FirebaseFirestore.instance
          .collection("shops")
          .doc(uid)
          .collection("products")
          .snapshots()
          .listen((querySnapshot) {
        List products = querySnapshot.docs.map((e) => e.data()).toList();
        emit(GetProductState(
            requestStatus: RequestStatus.success, products: products));
      });
    } on FirebaseException {
      emit(const GetProductState(requestStatus: RequestStatus.failure));
    }
  }

  void dispose() {}
}
