

import 'package:dashtanehunar/Utils/utils.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
       appBar: AppBar(
        title: const Text('Terms And Conditions', style: TextStyle(color: kBlack),),
        centerTitle: true,
        backgroundColor: kWhite,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left_rounded, size: 30,)),
      ),
      body:   SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(text: '1) Payment and Billing:',color: kBlack, fontsize: 18, fontWeight: FontWeight.bold,),
               customText(text: 'At Daastan-e-Hunar, we want to make the payment and billing process as simple and transparent as possible. Please read the following policy carefully to understand how payments and billing work on our website.\nAccepted Payment Methods We accept the following payment methods on our website:\n1.Credit or debit cards (Visa, Mastercard, American Express, Discover).\n2.EasyPaisa\n3.JaazCash\nWe do not accept payment by check, money order, or any other payment method not listed above.',
              fontsize: 14,textAlign: TextAlign.left,),
               customText(text: 'Payment Processing',color: kBlack,fontsize: 16,fontWeight: FontWeight.bold,), 
               customText(text: 'Payment for your order will be processed at the time of checkout. We use a secure payment gateway to process payments, and we do not store your payment information on our servers. If your payment is declined, we will not process your order, and we will notify you by email. You may need to contact your bank or payment provider to resolve the issue.',
              fontsize: 14,textAlign: TextAlign.left), 
               customText(text: 'Sales Tax',color: kBlack,fontsize: 16,fontWeight: FontWeight.bold,), 
               customText(text: 'Sales tax will be added to your order if required by law. The amount of sales tax will be calculated based on your shipping address and the current tax rate in your location.Billing Information\nWe will collect your billing information at the time of checkout, including your name, billing address, and payment information. We may also collect your phone number or email address to contact you about your order.\nIf you need to update your billing information, you can do so by logging into your account or contacting us at [email address]. Please note that we cannot change the billing information for an order once it has been placed.',
              fontsize: 14,textAlign: TextAlign.left),
               customText(text: 'Refunds',color: kBlack,fontsize: 16, fontWeight: FontWeight.bold,),
               customText(textAlign: TextAlign.left,text: 'If you are eligible for a refund, we will process it to the original payment method used for the purchase. Refunds may take up to 7 business days to appear in your account, depending on your bank or payment provider.\nIf you have any questions or concerns about payment and billing, please contact us at daastanehunar@gmail.com'),
               customText(text: '2) Shipping and Delivery: ',fontWeight: FontWeight.bold, fontsize: 18, color: kBlack,),
               customText(text: 'At Daastan-e-Hunar, we want to ensure that you receive your order in a timely and hassle-free manner. Please read the following policy carefully to understand how shipping and delivery work on our website.\nShipping Methods \nWe offer the following shipping methods for domestic and international orders:\nStandard shipping: 5-10 business days\nExpedited shipping: 2-5 business days\nInternational shipping: 7-14 business days\nPlease note that shipping times may vary depending on your location and the shipping carrier.',
              fontsize: 14, textAlign: TextAlign.left,),
              customText(text: "Shipping Costs", textAlign: TextAlign.left, fontWeight: FontWeight.bold, fontsize: 16,),
              customText(text: "Shipping costs will be calculated at the time of checkout based on your order total, shipping address, and shipping method. We offer free standard shipping on orders over a certain amount (see website for details).", textAlign: TextAlign.left, fontWeight: FontWeight.normal, fontsize: 14,),
              customText(text: "Order Processing", color: kBlack, fontWeight: FontWeight.bold, fontsize: 16, textAlign: TextAlign.left), 
              customText(text: "We strive to process and ship all orders within 1-2 business days of receiving them. If there is a delay in processing your order, we will notify you by email. Once your order has shipped, you will receive a shipping confirmation email with a tracking number. You can use this tracking number to track your order online.",
              fontWeight: FontWeight.normal, fontsize: 14, textAlign: TextAlign.left), 
              customText(text: "Delivery", fontWeight: FontWeight.bold, color: kBlack, textAlign: TextAlign.left,fontsize: 16),
              customText(text: "Delivery times may vary depending on your location and the shipping carrier. We are not responsible for any delays or issues caused by the shipping carrier. If your order is lost or damaged in transit, please contact us at [email address] within 7 days of receiving your shipping confirmation email. We will work with you to resolve the issue and ensure that you receive your order."), 
              customText(text: "International Orders", color: kBlack, fontWeight: FontWeight.bold, fontsize: 16, textAlign: TextAlign.left), 
              customText(text: "For international orders, please note that you may be responsible for paying customs duties and taxes. We are not responsible for any customs fees or delays caused by customs processing. If you have any questions or concerns about shipping and delivery, please contact us at daastanehunar@gmail.com.", fontWeight: FontWeight.normal, fontsize: 14, textAlign: TextAlign.left),
              


            ],
          ),
        ),
      ),
    );
  }

  customText({String? text, Color? color, FontWeight? fontWeight,double? fontsize,TextAlign? textAlign}){
    return Text('$text', style: TextStyle(color: color, fontWeight: fontWeight,fontSize: fontsize),textAlign: textAlign,);
  }
}