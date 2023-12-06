part of 'add_product_cubit.dart';

class AddProductState {
  final RequestStatus requestStatus;
  final String? selectedCategory; 
  const AddProductState({this.requestStatus = RequestStatus.initial,this.selectedCategory});

  AddProductState copyWith({
    final RequestStatus? requestStatus,
    final String? selectedCategory,
  }){
    return AddProductState(
      requestStatus: requestStatus ?? this.requestStatus, 
      selectedCategory:  selectedCategory ?? this.selectedCategory,
    );
  }
}
