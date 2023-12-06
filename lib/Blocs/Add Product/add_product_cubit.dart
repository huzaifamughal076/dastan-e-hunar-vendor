import 'package:dashtanehunar/Repo/product.dart';

import '../../Utils/utils.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(const AddProductState());

  onChangeSelectedCategory(String? value)async{
    emit(state.copyWith(selectedCategory: value,requestStatus: RequestStatus.initial));
  }

  Future addProduct(
    List<Color>? productColorList,
    String uid,
    String productName,
    String productDescription,
    List<File> productImages,
    String productPrice,
    String category
  ) async {
    emit(const AddProductState(requestStatus: RequestStatus.loading));
    final List<String> images =
        await ProductService.uploadImages(uid, productImages);
    await ProductService.addProduct(
           productColorList, uid, productName, productDescription, images, productPrice,category)
        .then((value) {
      if (value == null) {
        return emit(
          const AddProductState(
            requestStatus: RequestStatus.success,
          ),
        );
      }
      emit(
        const AddProductState(
          requestStatus: RequestStatus.failure,
        ),
      );
    });
  }
}
