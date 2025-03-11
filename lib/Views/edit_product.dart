import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dashtanehunar/Widgets/custom_list_of_productType.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import '../Utils/utils.dart';

class EditProductPage extends StatefulWidget {
  final Map? finalMap;
  const EditProductPage({this.finalMap, super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  Color? selectedColor;
   final List<File> images = [];
   final _formKey = GlobalKey<FormState>();
 
   TextEditingController? productName;
   TextEditingController? productDescription;
   TextEditingController? productPrice;
   List<Color>? productColorList = [];



  @override
  void initState() {
    super.initState();
productName = TextEditingController(text: widget.finalMap?['productName']);
productDescription = TextEditingController(text: widget.finalMap?['productDescription']);
productPrice = TextEditingController(text: widget.finalMap?['productPrice']);
print("${widget.finalMap?['productColors'].toString()}");
List<Color>? colorStrings = (widget.finalMap?['productColors'] as List<dynamic>?)?.map((e){
  return parseColorFromString(e);

}).toList()??[];

productColorList = colorStrings.toList();
// productColorList = colorStrings.map(( colorString) {
//   final startIndex = colorString.indexOf('Color(0x') + 'Color(0x'.length;
//   final endIndex = colorString.indexOf(')', startIndex);
//   final colorValue = colorString.substring(startIndex, endIndex);

//   // return Color(int.parse(colorValue, radix: 16));
//   return Color(int.parse(colorValue, radix: 16));
// }).toList();


  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: BaseAppBar(
        title: "Edit Product",
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      bottomNavigationBar: BlocConsumer<EditProductCubit, EditProductState>(
        listener: (context, state) {
          if (state.requestStatus == RequestStatus.failure) {
            SnackBarService.showSnackBar(context,
                title: "!Oh Snap",
                message: "Unable to edit product",
                contentType: ContentType.failure);
          }
          if (state.requestStatus == RequestStatus.success) {
            Navigator.popAndPushNamed(context, AppRoutes.home);
            SnackBarService.showSnackBar(context,
                title: "Success",
                message: "Product updated successfully!",
                contentType: ContentType.success);

          }
        },
        builder: (context, state) {
          if (state.requestStatus == RequestStatus.loading) {
            return const SizedBox(
              height: 70,
              width: double.infinity,
              child: CustomLoader(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: CustomButton(
                text: "Update",
                function: () {
               if (_formKey.currentState!.validate()) {
                    if (productColorList?.isNotEmpty ?? false) {
                      if (context
                              .read<EditProductCubit>()
                              .state
                              .selectedCategory !=
                          "None") {
                    context.read<EditProductCubit>().editProduct(
                      productColorList,
                      context.read<LoginCubit>().state.userData?["uid"] ?? "",
                      productName?.text??'',
                      productDescription?.text??'',
                      images,
                      widget.finalMap?['ProductId'],
                      productPrice?.text??'',
                      widget.finalMap?['productImage'],
                      context.read<EditProductCubit>().state.selectedCategory??"None"
                      );
                      } else {
                        SnackBarService.showSnackBar(context,
                            title: "!Oh Snap",
                            message: "Please select category to add product",
                            contentType: ContentType.failure);
                      }
                    } else {
                      SnackBarService.showSnackBar(context,
                          title: "!Oh Snap",
                          message: "Please select product color to add product",
                          contentType: ContentType.failure);
                    }
                  }
                }),
          );
        },
      ),
      backgroundColor: kGrey.shade200,
      body: SingleChildScrollView(
        child: Form( 
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginPageState().infoFields("Product name", "Name of the product",
                    controller: productName, validator: (value) {
                  if (value == null || value == "") {
                    return "Field is Mandatory";
                  }
                  return null;
                }),
                const SizedBox(
                  height: 10,
                ),
                LoginPageState().infoFields(
                    "Product price", "price of the product",
                    keyboardType: TextInputType.number,
                    controller: productPrice, validator: (value) {
                  if (value == null || value == "") {
                    return "Field is Mandatory";
                  }
                  return null;
                }),
                const SizedBox(
                  height: 10,
                ),
                 const CustomText(text: 'Product Category', fontsize: 16,),
                const SizedBox(height: 5,),
        
                BlocBuilder<EditProductCubit,EditProductState>(builder: (context, state) {
                  return DropdownMenu<String>(
                    width: MediaQuery.of(context).size.width*0.9,
                    menuHeight: 300,
                    menuStyle: MenuStyle(
                      shape:WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                    ),
                        inputDecorationTheme: InputDecorationTheme(
                          fillColor: kWhite,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: kTransparent,width: 0.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: kTransparent,width: 0.0),
                          ), 
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: kTransparent,width: 0.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10)
                        ),
                        initialSelection: state.selectedCategory??categoriesList.first,
                        controller: TextEditingController(),
                        enableSearch: true,
                        trailingIcon: const Icon(Icons.keyboard_arrow_down,color: primaryColor,),
                        selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up,color: primaryColor,),
                        dropdownMenuEntries: dropdownItems,
                        onSelected: (String? value) {
                          context.read<EditProductCubit>().onChangeSelectedCategory(value);
                         
                        },
                      );
                },),
        
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: 'Product Color\'s'),
                    InkWell(
                        onTap: () {
                          showColorPicker(context);
                        },
                        child: const Icon(Icons.add)),
                  
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: (productColorList?.isEmpty ?? true)
                            ? const CustomText(text: 'No Color selected')
                            : selectedColorsWidget(),
                      ),
                    ],
                  ),
                
                const SizedBox(
                  height: 20,
                ),
        
                const CustomText(text: "Add Photos"),
                const SizedBox(
                  height: 10,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: images.isEmpty ? 1 : images.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return InkWell(
                        onTap: () async {
                          final List<XFile> image =
                              await ImagePicker().pickMultiImage();
                          setState(() {
                            images
                                .addAll(image.map((e) => File(e.path)).toList());
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kWhite),
                          child: const Icon(Icons.add_a_photo_outlined),
                        ),
                      );
                    }
                    index--;
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        images[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Wrap selectedColorsWidget() {
    return Wrap(
                            runSpacing: 10,
                            spacing: 15,
                            children: productColorList
                                    ?.map((e) => Column(
                                          children: [
                                            Stack(
                                              alignment: Alignment.center,
                                              clipBehavior: Clip.none,
                                              children: [
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  color: e,
                                                ),
                                                Positioned(
                                                  right: -10,
                                                  top: -10,
                                                  child: InkWell(
                                                    onTap: () {
                                                      int? index =
                                                          productColorList
                                                              ?.indexWhere(
                                                                  (element) =>
                                                                      element ==
                                                                      e);
                                                      if (index != -1) {
                                                        setState(() {
                                                          productColorList
                                                              ?.removeAt(
                                                                  index ?? 0);
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: 25,
                                                      height: 25,
                                                      decoration:
                                                          BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                              offset:
                                                                  const Offset(
                                                                      2, 5),
                                                              blurRadius: 5,
                                                              color: Colors
                                                                  .black87
                                                                  .withOpacity(
                                                                      0.3),
                                                              spreadRadius: 2)
                                                        ],
                                                        shape:
                                                            BoxShape.circle,
                                                        color: Colors.white,
                                                      ),
                                                      child: const Icon(
                                                          Icons.close,
                                                          color: kBlack),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ))
                                    .toList() ??
                                [],
                          );
  }

  Future<dynamic> showColorPicker(BuildContext context) {
    return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              contentPadding: const EdgeInsets.all(15),
                              content: SizedBox(
                                width: 400,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const CustomText(
                                        text: 'Pick Product Color'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    MaterialPicker(
                                      pickerColor: Colors.red,
                                      onColorChanged: (Color? colors) {
                                        if (colors != null) {
                                          setState(() {
                                            selectedColor = colors;
                                          });
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomButton(
                                      text: "Done",
                                      function: () {
                                        if (selectedColor != null) {
                                          setState(() {
                                            if (!(productColorList?.any(
                                                    (element) =>
                                                        element ==
                                                        selectedColor) ??
                                                false)) {
                                              productColorList?.add(
                                                  selectedColor ??
                                                      Colors.red);
                                            } else {
                                              // Navigator.pop(context);
                                              SnackBarService.showSnackBar(
                                                  context,
                                                  title: "Color Exists",
                                                  message:
                                                      "Color already exists.\n You cannot add same color again.",
                                                  contentType:
                                                      ContentType.failure);
                                            }

                                            selectedColor = null;
                                          });
                                        }
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
  }
}
