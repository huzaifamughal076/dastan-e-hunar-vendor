import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashtanehunar/Blocs/Shop%20Cubit/cubit/shop_cubit.dart';
import 'package:dashtanehunar/Utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


class ShopDetailScreen extends StatefulWidget {

  const ShopDetailScreen({super.key});

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  late String? shopName, shopDescription;
  int maxLines = 1;


  TextEditingController? shopType;

  @override
  void initState() {
    super.initState();
    shopType = TextEditingController(
        text: context.read<ShopCubit>().state.shopModel?.shopType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGrey.shade100,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Shop Info",
          style: TextStyle(color: primaryColor),
        ),
        actions: [
          IconButton(
              onPressed: () async{
                showDialog(context: context, 
                builder: (context) {
                  return   Dialog(
                    backgroundColor: kWhite,
                    alignment: Alignment.center,
                        insetPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                    child: BlocBuilder<ShopCubit,ShopState>(builder: (context,state) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), 
                        color: kWhite
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(onPressed: (){
                                // Get.back();
                                Navigator.pop(context);
                        
                              }, icon:  const Icon(Icons.close, color: primaryColor,)),
                            ), 
                             const Align(
                              alignment: Alignment.center,
                               child: CustomText(text: 'Edit Shop', color: primaryColor, fontWeight: FontWeight.bold,fontsize: 22,)), 
                            const SizedBox(
                                              height: 20,
                                            ),
                                             const CustomText(
                                                text: "Shop Name",
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontsize: 16),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            customTextField(
                                              hintText: 'Shop Name',
                                              title: state.shopModel?.shopName ??
                                                  "",
                                              onChanged: (p0) =>
                                                  BlocProvider.of<ShopCubit>(context).onChangeShopName(p0),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                             const CustomText(
                                                text: "Shop Description",
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontsize: 16),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            customTextField(
                                              hintText: 'Shop Description',
                                              title: state.shopModel?.shopDescription ??
                                                  "",
                                              onChanged: (p0) =>
                                                  BlocProvider.of<ShopCubit>(context).onChangeShopDescription(p0),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            
                                            const CustomText(
                                                text: "Shop Location",
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontsize: 16),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            customTextField(
                                              hintText: 'Shop Location',
                                              title: state.shopModel?.shopLocation??
                                                  "",
                                              onChanged: (p0) =>
                                                  BlocProvider.of<ShopCubit>(context).onChangeShopLocation(p0),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            AnimatedCrossFade(
                                                firstChild: InkWell(
                                                  onTap: () {
                                                    print("HEELO");
                        
                                                    BlocProvider.of<ShopCubit>(context).updateShopData(context, state.shopModel?.id);
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    alignment: Alignment.center,
                                                    width: double.maxFinite,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(10),
                                                      color: primaryColor,
                                                    ),
                                                    child: const CustomText(
                                                      text: 'Save',
                                                      color: kWhite,
                                                      fontWeight: FontWeight.bold,
                                                      fontsize: 16,
                                                    ),
                                                  ),
                                                ),
                                                secondChild: Container(
                                                  height: 50,
                                                  alignment: Alignment.center,
                                                  width: double.maxFinite,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    // color: primaryColor,
                                                  ),
                                                  child:
                                                      const CircularProgressIndicator(
                                                          color: primaryColor),
                                                ),
                                                crossFadeState:                                                 
                                                state.shopDataUpdating
                                                        ? CrossFadeState.showSecond
                                                        : CrossFadeState.showFirst,
                                                duration: const Duration(
                                                    milliseconds: 800))
                        
                        
                            
                          ],),
                      ),
                      ),
                    ),)
                  );
                },);
              },
              icon: const Icon(
                Icons.edit,
                color: primaryColor,
              ))
        ],
        backgroundColor: kWhite,
        iconTheme: const IconThemeData(
          color: primaryColor,
        ),
      ),
      body: vendorShopDetailTab(context)   
       );
  }

  Widget vendorShopDetailTab(BuildContext context) {
    return BlocBuilder<ShopCubit,ShopState>(
      builder: (context,state) {
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: kWhite),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Stack( 
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            color: kGrey,
                            shape: BoxShape.circle,
                          ),
                          child: (state.loading)
                              ?const CircularProgressIndicator(color: primaryColor,strokeWidth: 1,)
                              :(state.shopModel?.shopProfileUrl?.isNotEmpty??false)
                              ?ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                 child: FadeInImage(placeholder: const AssetImage('assets/logo.jpeg'), 
                                 image: NetworkImage(state.shopModel?.shopProfileUrl??"")))
                              :ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: const Icon(
                                Icons.card_travel_outlined,
                                size: 50,
                                color: Colors.grey,
                              )),
                        ),

                        Positioned(
                          bottom: - 0, 
                          right: 10,
                          child: InkWell( 
                            onTap: ()async{
                              await ImagePicker().pickImage(source: ImageSource.gallery).then((value) async {
                                if(value!=null){
                                  context.read<ShopCubit>().setLoading(true);
                                  File? file = File(value.path);
                                  List name = file.path.split('/');
                                 var storageRef = FirebaseStorage.instance.ref().child('${state.shopModel?.id}/${name.last}');
    UploadTask uploadTask = storageRef.putFile(file);

    await uploadTask.whenComplete(() => null);

    String imageUrl = await storageRef.getDownloadURL();
    print(imageUrl);
    print(state.shopModel?.id);
    await FirebaseFirestore.instance.collection('shops').doc(state.shopModel?.id).update({"shopProfileUrl":imageUrl}).then((value)async{
      await FirebaseFirestore.instance.collection('users').doc(state.shopModel?.id).update({"shopProfileUrl":imageUrl}).then((value){
      state.shopModel?.shopProfileUrl = imageUrl;
      // Get.appUpdate();
      context.read<ShopCubit>().setLoading(false);
      });
      
    });
                                }
                                
                              });
                            },
                            child: Material( 
                            elevation: 4, 
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration:  const BoxDecoration(
                                color: kWhite, 
                                shape: BoxShape.circle
                              ),
                              child: const Icon(Icons.camera_alt_outlined, color: kBlack, size: 24),
                            ),
                                                  ),
                          ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                           Container(
                            margin: const EdgeInsets.only(top: 8,bottom: 10),
                            child: Divider(thickness: 2, color: kGrey.withOpacity(0.3))),
                          shopField(title: "Shop Name", value: state.shopModel?.shopName),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8,bottom: 10),
                            child: Divider(thickness: 2, color: kGrey.withOpacity(0.3))),
                          shopField(title: "Shop Description", value: state.shopModel?.shopDescription),
                          const SizedBox(
                            height: 10,
                          ),
                           Container(
                            margin: const EdgeInsets.only(top: 8,bottom: 10),
                            child: Divider(thickness: 2, color: kGrey.withOpacity(0.3))),
                          shopField(title: "Shop Type", value: state.shopModel?.shopType),
                          const SizedBox(
                            height: 10,
                          ),
                           Container(
                            margin: const EdgeInsets.only(top: 8,bottom: 10),
                            child: Divider(thickness: 2, color: kGrey.withOpacity(0.3))),
                          shopField(title: "Shop Location", value: state.shopModel?.shopLocation??""),
                          const SizedBox(
                            height: 10,
                          ),
                           Container(
                            margin: const EdgeInsets.only(top: 8,bottom: 10),
                            child: Divider(thickness: 2, color: kGrey.withOpacity(0.3))),


                          const SizedBox(height: 20,), 

                          InkWell( 
                            onTap: (){
                              // Get.find<VendorsController>().getVendorsProducts(shopId: controller.selectedShopModel?.id);
                              // Get.find<VendorsController>().onChangeSearched(false);
                              // Get.to(()=>const VendorProductPage(),transition: Transition.fadeIn);
                            },
                            child: Container(
                              alignment: Alignment.center, 
                              height: 50, 
                              width: double.maxFinite, 
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), 
                                color: primaryColor
                              ),
                              child: const CustomText(text: 'Visit Shop', color: kWhite, fontWeight: FontWeight.bold, fontsize: 16,),
                            ),
                          )

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

    List<DropdownMenuEntry<String>> get dropdownList {
    return [
      const DropdownMenuEntry(
          value: "Home Decoration", label: 'Home Decoration'),
      const DropdownMenuEntry(
          value: "Fashion and Accessories", label: 'Fashion and Accessories'),
      const DropdownMenuEntry(
          value: "Textile and Fiber Arts", label: 'Textile and Fiber Arts'),
      const DropdownMenuEntry(
          value: "Woodwork and stone work", label: 'Woodwork and stone work'),
      const DropdownMenuEntry(
          value: "Candles and Soaps", label: 'Candles and Soaps'),
      const DropdownMenuEntry(value: "Jewelry", label: 'Jewelry'),
    ];
  }

    TextFormField customTextField(
      {String? title, String? hintText, void Function(String)? onChanged}) {
    return TextFormField(
      initialValue: title,
      decoration: InputDecoration(
        hintText: hintText ?? "",
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryColor, width: 1)),
      ),
      onChanged: onChanged,
    );
  }

    Row shopField({String? title, String? value}) {
    return  Row(
      children: [
        CustomText(
          text: '${title??""}: ',
          color: primaryColor,
          fontWeight: FontWeight.bold,
          fontsize: 17,
        ),
        CustomText(
          text: value??'',
          color: kBlack,
          fontWeight: FontWeight.normal,
          fontsize: 17,
        ),
      ],
    );
  }


}
// class ProductTile extends StatefulWidget {
//   final ProductModel? _productModel;
//   final String ownerId;
//   const ProductTile(this._productModel,this.ownerId,{super.key});

//   @override
//   State<ProductTile> createState() => _ProductTileState();
// }

// class _ProductTileState extends State<ProductTile> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Get.to(ProductDetailPage(widget._productModel,widget.ownerId));
//       },
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(25),
//             border: Border.all(color: hint)),
//         child: Row(
//           children: [
//             Container(
//               width: 34,
//               height: 34,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: NetworkImage(widget._productModel?.productImage?[0]??"", )
//                 ),
//               ),
//             ).marginOnly(left: 8),
//             Text(widget._productModel?.productName??"")
//                 .marginOnly(left: 5, right: 15, top: 3, bottom: 3)
//           ],
//         ),
//       ).marginOnly(left: 25),
//     );
//   }
// }

