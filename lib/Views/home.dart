import 'package:dashtanehunar/Blocs/Dashboard%20Cubit/cubit/dashboard_cubit.dart';
import 'package:dashtanehunar/Repo/product.dart';
import 'package:dashtanehunar/models/Order%20Model/order_model.dart';

import '../Blocs/Get product/get_product_cubit.dart';
import '../Utils/utils.dart';
import 'package:intl/intl.dart' as math;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardState state = context.watch<DashboardCubit>().state;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: thirdColor,
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addProduct),
        child: const Icon(
          Icons.add,
          color: kWhite,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: const TextSpan(
                    text: 'The Year ',
                    style: TextStyle(
                        color: kBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Select Year"),
                            content: SizedBox(
                              // Need to use container to add size constraint.
                              width: 300,
                              height: 300,
                              child: YearPicker(
                                firstDate:
                                    DateTime(DateTime.now().year - 100, 1),
                                lastDate: DateTime(DateTime.now().year + 1, 1),
                                initialDate: DateTime.now(),
                                // save the selected date to _selectedDate DateTime variable.
                                // It's used to set the previous selected date when
                                // re-showing the dialog.
                                selectedDate: DateTime(
                                    ((context
                                            .read<DashboardCubit>()
                                            .state
                                            .selectedYear ??
                                        DateTime.now().year)),
                                    1,
                                    1),
                                onChanged: (DateTime dateTime) {
                                  // close the dialog when year is selected.
                                  
                                   context
                                      .read<DashboardCubit>()
                                      .onChangeTopSellingProduct(null);
                                  context
                                      .read<DashboardCubit>()
                                      .onChangeSelectedYear(dateTime.year);
                                  
                                  double? totalSale = ProductService()
                                      .calculateTotalSale(
                                          context
                                              .read<DashboardCubit>()
                                              .state
                                              .orderList,
                                          dateTime.year);
                                          OrderModel? topSellingProductInfo =
                                      ProductService.findTopSellingProduct(
                                          context
                                              .read<DashboardCubit>()
                                              .state
                                              .orders,
                                          dateTime.year);
                                  
                                  context
                                      .read<DashboardCubit>()
                                      .onChangeTotalSale(totalSale);
                                      context
                                      .read<DashboardCubit>()
                                      .onChangeTopSellingProduct(
                                          topSellingProductInfo);
                                  Navigator.pop(context);

                                  // Do something with the dateTime selected.
                                  // Remember that you need to use dateTime.year to get the year
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 1),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(text: "${state.selectedYear}"),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            color: primaryColor,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: 'Top Selling',
                          fontWeight: FontWeight.bold,
                          fontsize: 20,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height/3.4,
                          width: double.maxFinite,
                          alignment: Alignment.center,
                          child: (state.topSellingProduct?.productId?.isNotEmpty??false)
                              ? Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 150,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: (state
                                                        .topSellingProduct
                                                        ?.productImage
                                                        ?.isEmpty ??
                                                    true)
                                                ? const AssetImage(
                                                        'assets/logo.jpeg')
                                                    as ImageProvider
                                                : NetworkImage(
                                                    '${state.topSellingProduct?.productImage?.first}'),
                                            fit: BoxFit
                                                .cover, // Adjusted to cover the container
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                          child: CustomText(
                                            text:
                                                "Name: ${state.topSellingProduct?.productName ?? ""}",
                                            fontsize: 14,
                                            maxLines: 1,
                                          )),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                          child: CustomText(
                                            text:
                                                "Price: ${state.topSellingProduct?.productPrice ?? ""}",
                                                maxLines: 1,
                                            fontsize: 14,
                                          )),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const CustomText(
                                                text: "Color:",
                                                fontsize: 14,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                height: 20,
                                                width: 20,
                                                color: state
                                                    .topSellingProduct
                                                    ?.productColor,
                                              ),
                                            ],
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                )
                              : const CustomText(
                                  text: 'No product found'),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          text: 'Total Sale',
                          fontWeight: FontWeight.bold,
                          fontsize: 20,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
  height: 230,
  width: double.maxFinite,
  alignment: Alignment.center,
  decoration: BoxDecoration(
    color: primaryColor, // Add your preferred color
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 2), // changes position of shadow
      ),
    ],
  ),
  padding: const EdgeInsets.all(16), // Adjust the padding as needed
  child: (state.totalSale != null && state.totalSale != 0.0)
      ? CustomText(
          text: math.NumberFormat.compactCurrency(
                  symbol: "PKR\n", locale: 'en_US')
              .format(state.totalSale),
          fontsize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Adjust the text color as needed
        )
      : const CustomText(
          text: 'No sale found',
          color: Colors.white, // Adjust the text color as needed
        ),
),

                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomText(
                text: "All Products",
                fontsize: 25,
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<GetProductCubit, GetProductState>(
                builder: (context, state) {
                  if (state.requestStatus == RequestStatus.loading) {
                    return const CustomLoader();
                  }
                  if (state.requestStatus == RequestStatus.failure) {
                    return const Center(
                      child: CustomText(text: "Error"),
                    );
                  }
                  if (state.products?.isEmpty ?? true) {
                    return Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.2),
                        child: const Center(
                            child: CustomText(text: 'No Product found')));
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 16 / 27),
                    itemCount: state.products?.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Map product = state.products?[index];
                      final List images = (product["productImage"] as List)
                        ..shuffle();
                      return InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, AppRoutes.productDetail,
                            arguments: state.products?[index]),
                        child: Column(
                          children: [
                            Expanded(
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: FadeInImage(
                                      placeholder:
                                          const AssetImage("assets/logo.jpeg"),
                                      image: NetworkImage(
                                        images.first,
                                      ),
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset('assets/logo.jpeg');
                                      },
                                      fit: BoxFit.cover,
                                      height: double.infinity,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 5,
                                    child: Opacity(
                                      opacity: 0.91,
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: kWhite),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3),
                                        child: Text(
                                            '${state.products?[index]['productStatus']}',
                                            style: TextStyle(
                                                color: (state.products?[index][
                                                                'productStatus']
                                                            .toLowerCase() ==
                                                        "pending")
                                                    ? kOrange
                                                    : (state.products?[index][
                                                                    'productStatus']
                                                                .toLowerCase() ==
                                                            "rejected")
                                                        ? kRed
                                                        : (state.products?[
                                                                        index][
                                                                        'productStatus']
                                                                    .toLowerCase() ==
                                                                "active")
                                                            ? kGreen
                                                            : kTransparent)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomText(text: product["productName"] ?? "")
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
