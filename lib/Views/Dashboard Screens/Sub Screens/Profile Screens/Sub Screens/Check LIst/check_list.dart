import 'package:dashtanehunar/Blocs/Profile%20Cubit/cubit/profile_cubit.dart';
import 'package:dashtanehunar/Utils/utils.dart';
import 'package:flutter/material.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  List<ChecklistItem> checklistItems = [
    ChecklistItem("Craftsmanship and Aesthetics", [
      "Authenticity: Ensure traditional methods are followed.",
      "Attention to Detail: Inspect products for quality.",
      "Color Accuracy: Verify colors align with descriptions.",
    ]),
    ChecklistItem("Packaging Integrity", [
      "Secure Packaging: Use protective materials for transit.",
      "Branding Consistency: Affix clear DAASTAN E HUNAR labels.",
      "Fragile Items Handling: Take special care with delicate items.",
    ]),
    ChecklistItem("Quality Assurance Documentation", [
      "Quality Checks: Ensure items meet DAASTAN E HUNAR standards.",
      "Photographic Documentation: Document products with photos.",
      "Inclusion of Quality Notes: Provide care instructions.",
    ]),
  ];

  List<ChecklistItem> urduChecklistItems = [
    ChecklistItem("صنعت اور خوبصورتی", [
      "اصالت: یہ سنجیدہ ہے کہ روایتی تراکیب کا پیروئی کیا جا رہا ہے۔",
      "توجہ میں تفصیل: صحیحیت کے لئے مصنوعات کی تفصیلات کا جائزہ۔",
      "رنگوں کی درستگی: یہ سنجیدہ ہے کہ رنگ تفصیلات کے ساتھ میل کھاتے ہیں۔",
    ]),
    ChecklistItem("پیکیجنگ کی سلامتی", [
      "محفوظ پیکیجنگ: چلنے کے لئے حفاظتی سازات کا استعمال۔",
      "برانڈنگ کی مستقلی: صاف دستان ای ہنر لیبلز لگائیں۔",
      "نازک اشیاء کا ہینڈلنگ: مہم اشیاء کے ساتھ خصوصی خیال رکھیں۔",
    ]),
    ChecklistItem("قیمتی یعنی اسیورنس دستاویزات", [
      "کوالٹی چیکس: یہ سنجیدہ ہے کہ مصنوعات دستان ای ہنر کی معیاروں کو پورا کرتے ہیں۔",
      "فوٹو گرافک ڈاکیومنٹیشن: مصنوعات کو تصویری طور پر ڈاکیومنٹ کریں۔",
      "کوالٹی نوٹس کا شامل ہونا: دیکھ بھال کی ہدایتات فراہم کریں۔",
    ]),
  ];

  String urduP =
      'ان کی معیاریں کا پاس ہونا داستان ای ہنر کی عظیمیت کو برقرار رکھے گا، یہ یہ یقینی بناتا ہے کہ صارفین کو پاکستان کی مختلف کمیونٹیز کے اصیل اور معیاری مصنوعات فراہم ہوں۔';
  String englishP =
      'Adhering to these quality standards will uphold DAASTAN E HUNAR\'s reputation, ensuring customers receive authentic and high-quality crafts from Pakistan\'s diverse communities.';

  @override
  Widget build(BuildContext context) {
    ProfileState state = context.watch<ProfileCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Standards Checklist'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SwitchListTile(
                value: (state.isUrdu==false)?false:true, 
                title: const Text('English/اردو',style:TextStyle(color: kBlack, fontSize: 16)),
                onChanged: (value) {
                  print(value);
                  context.read<ProfileCubit>().onChangeLanguage(value);
                  Global.storageService.setLanguage(value);
                }),
            Directionality(
        textDirection: (state.isUrdu==false)?TextDirection.ltr:TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (state.isUrdu ?? false) ? urduP : englishP,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    for (var item in (state.isUrdu ?? false)
                        ? urduChecklistItems
                        : checklistItems) ...[
                      Text(
                        item.category,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      for (int subItem = 0; subItem < item.subItems.length; subItem++)
                        Text(
                                " ${subItem + 1}) ${item.subItems[subItem]}",
                                style: const TextStyle(letterSpacing: 1),
                              ),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChecklistItem {
  final String category;
  final List<String> subItems;

  ChecklistItem(this.category, this.subItems);
}
