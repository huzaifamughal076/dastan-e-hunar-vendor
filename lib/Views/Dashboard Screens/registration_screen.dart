import 'package:dashtanehunar/Utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  File? invoiceImage;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          backgroundColor: kWhite,
          // title:  Text(context.read<LoginCubit>().state.userData?["shopName"] ?? "",style: const TextStyle(color: kBlack),),
          title: const Text('Registration Page',style: TextStyle(color: kBlack),),
          centerTitle: true,
          elevation: 0, 
          toolbarHeight: 50,
        ),

        bottomNavigationBar: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.requestStatus == RequestStatus.failure) {
            SnackBarService.showSnackBar(context,
                title: "!Oh Snap",
                message: "Unable to send registration request",
                contentType: ContentType.failure);
          }
          if (state.requestStatus == RequestStatus.success) {
            Navigator.pop(context);
            SnackBarService.showSnackBar(context,
                title: "Success",
                message: "Your registration request has been sent!",
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
          return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: CustomButton(text: 'Register', function: () {
            Map<String,dynamic>? data = context.read<LoginCubit>().state.userData;
            if(invoiceImage?.path.isEmpty??true){
               SnackBarService.showSnackBar(context,
                title: "Please select invoice first",
                message: "Unable to send registration request",
                contentType: ContentType.failure);
                context.read<LoginCubit>().setUserData(data);
                
            }else{
              context.read<LoginCubit>().sendRegistrationRequest(context,data?['uid'], invoiceImage);
            }
            
            
          },),
        );
        }),

        body:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(child: Image.asset('assets/jazzcash.png')),
                  Expanded(child: Image.asset('assets/easy_paisa.png')),
                ],
              ),
        
              const CustomText(text: 'To Register your shop Please pay Rs 1000/- using Jazzcash or Easypaisa.',fontWeight: FontWeight.bold,fontsize: 18,textAlign: TextAlign.left,),
              const SizedBox(height: 40,),
              RichText(text: const TextSpan(
                text: 'JazzCash: ', 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: kBlack),
                children: [
                  TextSpan(text: '03xx-xxxxxxx',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18, color: kBlack))
                ]
              )),
              const SizedBox(height: 10,),
              RichText(text: const TextSpan(
                text: 'EasyPaisa: ', 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: kBlack),
                children: [
                  TextSpan(text: '03xx-xxxxxxx',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18, color: kBlack))
                ]
              )), 

              const SizedBox(height: 20,),

              (invoiceImage!=null)
              ?Container(
                width: double.maxFinite,
                margin: const EdgeInsets.all(10),
                height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kWhite, 
                              image: DecorationImage(image: FileImage(File(invoiceImage?.path??"")), 
                              fit: BoxFit.fitHeight
                              ), 
                                boxShadow:  [
                              BoxShadow(offset: const Offset(2, 5),
                              blurRadius: 5, 
                              spreadRadius: 2, 
                              color: kBlack.withOpacity(0.1)
                              )
                            ],
                              ),
                        )
              :InkWell(
                        onTap: () async {
                           await ImagePicker().pickImage(source: ImageSource.gallery).then((value){
                                 setState(() {
                            invoiceImage = File(value?.path??"");
                            print(invoiceImage?.path);
                          });
                                 return null;
                              });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          width: double.maxFinite,
                          height: 200,
                          decoration: BoxDecoration(
                            boxShadow:  [
                              BoxShadow(offset: const Offset(2, 5),
                              blurRadius: 5, 
                              spreadRadius: 2, 
                              color: kBlack.withOpacity(0.1)
                              ),
                            ],
                              borderRadius: BorderRadius.circular(10),
                              color: kWhite),
                          child: const Icon(Icons.add_a_photo_outlined),
                        ),
                      )

            ],
          ),
        ),
    );
  }
}