import 'package:dashtanehunar/Utils/utils.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: kWhite,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10))),

      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // Important: Remove any padding from the ListView.
                children: [
            
                  const SizedBox(height: 50,),
            
                  Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(text: "Welcome to ${context.read<LoginCubit>().state.userData?['shopName']??""}",fontsize: 18, fontWeight: FontWeight.bold,)),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  // border: Border.all(color: primaryColor, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                  // image: const DecorationImage(image: AssetImage('assets/profile_image.webp') ,fit: BoxFit.fill),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/logo.jpeg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                // mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: context.read<LoginCubit>().state.userData?['firstName']??"",
                                    // text: Get.find<AuthController>()
                                    //         .userModel
                                    //         ?.firstName ??
                                        // "",
                                    fontWeight: FontWeight.bold,
                                    fontsize: 18,
                                  ),
                                  const SizedBox(height: 5,),
                                  CustomText(
                                    text:context.read<LoginCubit>().state.userData?['email']??
                                        "",
                                    fontWeight: FontWeight.normal,
                                    fontsize: 14,
                                  ),
            
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 25,),
                      Divider(color: kGrey.withOpacity(0.6), thickness: 0.5, height: 0.5),
          
              
                ],
              ),
            ),
          ),
        
          Positioned(
                bottom: 10,
                // left: 10, 
                right: 10,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    logoutPopup(context);
                    
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), 
                      border: Border.all(color: primaryColor, width: 1),
                      color: primaryColor
                    ),
                    width: 130,
                    height: 50, 
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(text: 'Logout',fontsize: 18,color: kWhite,), 
                        Icon(Icons.exit_to_app_rounded, color: kWhite,)
                      ],
                    ),
                  ),
                )),
        ],
      ),
    );
  }

  Future<dynamic> logoutPopup(BuildContext context) {
    return showDialog(context: context, builder:(context) {
                    return  AlertDialog(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)), side: BorderSide(color: primaryColor, width: 2)),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 5,),
                          const CustomText(text: 'Are you sure', fontWeight: FontWeight.bold, fontsize: 22, color: kBlack,),
                          const SizedBox(height: 10,),
                          const CustomText(text: 'You want to logout?', fontWeight: FontWeight.normal, fontsize: 16, color: kBlack,),
                          const SizedBox(height: 15,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: InkWell( 
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: primaryColor
                                    ),
                                    child: const CustomText(text: 'Cancel', color: kWhite,),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20,),
                              Expanded(
                                child: InkWell( 
                                  onTap: ()async{
                                   Navigator.popUntil(context, (route) => false);
                                   Navigator.pushNamedAndRemoveUntil(context, 'loginScreen', (route) => true);
                                    // await SharedPref.removeUser();

                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: kWhite, 
                                      border: Border.all(color: primaryColor,width: 1)
                                    ),
                                    child: const CustomText(text: 'Sure', color: primaryColor,),
                                  ),
                                ),
                              ),

                            ],)
                          ],
                      
                      ),
                    );
                  }, );
  }

}
