import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            buildFAQItem(
              '1.	How can I place an order?',
              "To place an order, simply browse our website and add the products you want to your cart. Once you're ready to check out, follow the prompts to enter your shipping and billing information and complete your purchase.",
            ),
            buildFAQItem(
              '2.	What payment methods do you accept?',
              'We accept a variety of payment methods, including credit/debit cards, PayPal, Apple Pay, and Google Pay. You can select your preferred payment method at checkout.',
            ),
            buildFAQItem(
              '3.	How long does shipping take?',
              'Shipping times vary depending on your location and the shipping method you select. Typically, standard shipping takes 5-10 business days, expedited shipping takes 2-5 business days, and international shipping takes 7-14 business days. You can track your order using the tracking number provided in your shipping confirmation email.',
            ),
            buildFAQItem(
              '4.	What is your return and refund policy?',
              "We offer a 30-day return policy for most products. If you're not satisfied with your purchase, you can return it for a refund or exchange. For more information, please see our Returns & Refunds page",
            ),
            buildFAQItem(
              '5.	How can I track my order?',
              "You can track your order using the tracking number provided in your shipping confirmation email. If you have any issues with tracking your order, please contact us at [email address] for assistance.",
            ),
            buildFAQItem(
              '6.	Do you offer international shipping?',
              "Yes, we offer international shipping to many countries. Shipping times and costs vary depending on your location and the shipping method you select.",
            ),
            buildFAQItem(
              '7.	What if my product arrives damaged?',
              "If your product arrives damaged, please contact us at [email address] within 7 days of receiving your order. We will work with you to resolve the issue and ensure that you receive a replacement or refund.",
            ),
            buildFAQItem(
              '8.	How can I contact customer support?',
              "You can contact us at [email address] for assistance with any questions or issues you may have. Our customer support team is available to help you Monday through Friday, 9am to 5pm EST.",
            ), 
            buildFAQItem(
              '9.	Can I cancel my order?',
              "If you need to cancel your order, please contact us at [email address] as soon as possible. We will do our best to accommodate your request, but please note that if your order has already shipped, we may not be able to cancel it.",
            ), 
            buildFAQItem(
              '10. How do I know if a product is in stock?',
              "If a product is out of stock, it will be marked as such on the product page. If a product is in stock, you can add it to your cart and complete your purchase. If you have any questions about product availability, please contact us at [email address] for assistance.",
            ), 
          ],
        ),
      ),
    );
  }

  Widget buildFAQItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(answer),
        ),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: FAQPage(),
  ));
}
