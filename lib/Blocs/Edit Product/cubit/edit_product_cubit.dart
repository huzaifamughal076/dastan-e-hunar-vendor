import 'package:dashtanehunar/Repo/product.dart';
import 'package:dashtanehunar/Utils/utils.dart';

part 'edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  EditProductCubit() : super(const EditProductState());


  onChangeSelectedCategory(String? value)async{
    emit(state.copyWith(selectedCategory: value));
  }


   Future editProduct(
      List<Color>? productColorList,
      String uid,
      String productName,
      String productDescription,
      List<File>? productImages,
      String productId,
      String productPrice,
      List<dynamic>? currentImages, 
      String category
  ) async {
    emit(const EditProductState(requestStatus: RequestStatus.loading));
     List<String>? images = [];
    if(productImages?.isNotEmpty??false){
     images  =  await ProductService.uploadImages(uid, productImages??[]);
    }else{
      images = currentImages?.cast<String>();
    }
    await ProductService.editProduct(
           productColorList, uid, productName, productDescription, images,productId, productPrice,category)
        .then((value) {
      if (value == null) {
        return emit(
          const EditProductState(
            requestStatus: RequestStatus.success,
          ),
        );
      }
      emit(
        const EditProductState(
          requestStatus: RequestStatus.failure,
        ),
      );
    });
  }
}
