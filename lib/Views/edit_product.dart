import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:image_picker/image_picker.dart';

import '../Blocs/Add Product/add_product_cubit.dart';
import '../Utils/utils.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final TextEditingController productName = TextEditingController();
  final TextEditingController productDescription = TextEditingController();
  final TextEditingController productPrice = TextEditingController();
  final List<File> images = [];
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
      bottomNavigationBar: BlocConsumer<AddProductCubit, AddProductState>(
        listener: (context, state) {
          if (state.requestStatus == RequestStatus.failure) {
            SnackBarService.showSnackBar(context,
                title: "!Oh Snap",
                message: "Unable to add product",
                contentType: ContentType.failure);
          }
          if (state.requestStatus == RequestStatus.success) {
            Navigator.pop(context);
            SnackBarService.showSnackBar(context,
                title: "Success",
                message: "Product added successfully!",
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
                text: "Add",
                function: () {
                  context.read<AddProductCubit>().addProduct(
                      context.read<LoginCubit>().state.userData?["uid"] ?? "",
                      productName.text,
                      productDescription.text,
                      images,
                      productPrice.text);
                }),
          );
        },
      ),
      backgroundColor: kGrey.shade200,
      body: SingleChildScrollView(
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
                "Product description",
                "description of the product",
                controller: productDescription,
                validator: (value) {
                  if (value == null || value == "") {
                    return "Field is Mandatory";
                  }
                  return null;
                },
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
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
    );
  }
}
