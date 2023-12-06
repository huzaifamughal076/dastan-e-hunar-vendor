

import 'package:dashtanehunar/Utils/utils.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: kWhite,
       appBar: AppBar(
        title: const Text('Privacy Policies', style: TextStyle(color: kBlack),),
        centerTitle: true,
        backgroundColor: kWhite,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left_rounded, size: 30,)),
      ),
      body:  SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12),  
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(text: 'At Daastan e Hunar we take your privacy seriously. This privacy policy explains how we collect, use, and protect your personal information.\nInformation we collect\nWhen you place an order on our website, we collect the following information:\nName\nEmail address\nShipping address\nBilling address\nPayment information\nWe also collect information automatically when you visit our website, including your IP address, browser type, and device information.\nHow we use your information\nWe use your information to process and fulfill your order, communicate with you about your order, and provide customer support. We may also use your information to send you promotional emails and marketing communications if you opt-in to receive them.\nWe do not sell or share your personal information with third parties for marketing purposes. We may share your information with our service providers and shipping partners to fulfill your order and provide you with the best possible shopping experience.\nHow we protect your information\nWe use industry-standard security measures to protect your personal information, including encryption, firewalls, and secure servers. We also restrict access to your information to employees and service providers who need it to fulfill your order and provide customer support.',
             fontsize: 14, fontWeight: FontWeight.normal,textAlign: TextAlign.left),
             customText(text: 'Your rights', fontWeight: FontWeight.bold, fontsize: 16, color: kBlack, textAlign: TextAlign.left), 
             customText(text: 'You have the right to access, correct, or delete your personal information at any time. You can do so by logging into your account or contacting us at [email address].\nYou also have the right to opt-out of receiving promotional emails and marketing communications. You can do so by clicking the "unsubscribe" link at the bottom of our emails or contacting us at [email address]. Updates to this privacy policy.\nWe may update this privacy policy from time to time to reflect changes in our practices or legal requirements. We will notify you of any material changes by email or by posting a notice on our website.\nContact us If you have any questions or concerns about our privacy policy or how we handle your personal information, please contact us at daastanehunar@gmail.com'),
      
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