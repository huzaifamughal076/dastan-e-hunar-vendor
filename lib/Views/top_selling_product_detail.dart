import 'package:carousel_slider/carousel_slider.dart';
import 'package:dashtanehunar/models/Order%20Model/order_model.dart';

import '../Utils/utils.dart';

class TopSellingProdcutDetail extends StatefulWidget {
  final OrderModel? orderModel;
  const TopSellingProdcutDetail(this.orderModel, {super.key});

  @override
  State<TopSellingProdcutDetail> createState() =>
      _TopSellingProdcutDetailState();
}

class _TopSellingProdcutDetailState extends State<TopSellingProdcutDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Product Details",
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: CarouselSlider.builder(
                itemCount: widget.orderModel?.productImage?.length ?? 0,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.orderModel?.productImage?[itemIndex] ?? "",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
                options: CarouselOptions(
                    enlargeCenterPage: true, height: double.infinity),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: widget.orderModel?.productName ?? "",
                        fontsize: 25,
                      ),
                      CustomText(
                          text: "Rs. ${widget.orderModel?.productPrice ?? ""}")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: "Status",
                      ),
                      CustomText(
                        text: widget.orderModel?.productStatus ?? "",
                        color:
                            (widget.orderModel?.productStatus?.toLowerCase() ==
                                    "pending")
                                ? kOrange
                                : (widget.orderModel?.productStatus
                                            ?.toLowerCase() ==
                                        "rejected")
                                    ? kRed
                                    : (widget.orderModel?.productStatus
                                                ?.toLowerCase() ==
                                            "active")
                                        ? kGreen
                                        : kBlack,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: "Category",
                      ),
                      CustomText(
                        text: widget.orderModel?.productCategory ??
                            "Not Provided",
                      ),
                    ],
                  ),
                  (widget.orderModel?.productColor == null)
                      ? const SizedBox.shrink()
                      : const SizedBox(
                          height: 10,
                        ),
                  (widget.orderModel?.productColor == null)
                      ? const SizedBox.shrink()
                      : const CustomText(text: 'Color'),
                  Wrap(
                    children: (widget.orderModel?.productColor == null)
                        ? []
                        : [
                            (Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 30,
                              width: 30,
                              color: widget.orderModel?.productColor,
                            ))
                          ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ((widget.orderModel?.productDescription?.isEmpty ?? true) ||
                          widget.orderModel?.productDescription == " ")
                      ? const SizedBox.shrink()
                      : const CustomText(
                          text: "Description",
                        ),
                  ((widget.orderModel?.productDescription?.isEmpty ?? true) ||
                          widget.orderModel?.productDescription == " ")
                      ? const SizedBox.shrink()
                      : Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color: kGrey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CustomText(
                              text:
                                  widget.orderModel?.productDescription ?? ""),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
