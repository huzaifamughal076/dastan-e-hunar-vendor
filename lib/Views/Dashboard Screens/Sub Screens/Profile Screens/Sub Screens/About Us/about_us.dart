import 'package:dashtanehunar/Utils/utils.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.keyboard_arrow_left_rounded,
              color: kBlack,
            )),
        title:  const Text('About Us', style: TextStyle(color: kBlack),),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 50,
      ),
      body: const Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("DAASTAN E HUNAR is a magical tale of where we celebrate the vibrant and diverse culture of Pakistan through the craftsmanship of local artisans. Our mission is to bring to you the unique heritage and traditions of Pakistan's diverse communities and showcase them to the world.We are proud to work with talented artisans from different areas of Pakistan who have inherited their skills from generations before them. Each piece of craft that you see on our website has been handcrafted with great care and attention to detail, ensuring that each piece is unique and carries with it the stories and traditions of Pakistan.We believe in promoting fair trade and empowering local communities by providing them with a platform to showcase their skills and earn a sustainable livelihood. By buying from us, you are not only supporting the artisans, but also preserving the rich cultural heritage of Pakistan for future generations.From intricately designed textiles to traditional handicrafts, we offer a wide range of products that capture the essence of Pakistan's local culture and heritage. Our products are not just items for decoration or use, but a reflection of the values, beliefs, and traditions that have been passed down for centuries.We are committed to delivering exceptional customer service, and your satisfaction is our top priority. Whether you're looking for a unique gift or adding to your personal collection, we invite you to explore our collection and experience the beauty of Pakistan's local culture and heritage through our artisan's crafts.Thank you for joining us in celebrating the richness and diversity of Pakistan's cultural heritage.", 
              style: TextStyle(fontSize: 16, )),
            ],
          ),
        ),
      ),
    );
  }
}
