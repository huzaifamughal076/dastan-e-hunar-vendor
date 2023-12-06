part of 'edit_product_cubit.dart';

class EditProductState {
  final RequestStatus requestStatus;
  final String? selectedCategory; 
  const EditProductState({this.requestStatus = RequestStatus.initial,this.selectedCategory});

  
    EditProductState copyWith({
    final RequestStatus? requestStatus,
    final String? selectedCategory,
  }){
    return EditProductState(
      requestStatus: requestStatus ?? this.requestStatus, 
      selectedCategory:  selectedCategory ?? this.selectedCategory,
    );
  }
}

