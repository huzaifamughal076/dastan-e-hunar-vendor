import 'package:dashtanehunar/Utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    List list = [
      {
        'image':"assets/profile.svg", 
        'title':"My Profile", 
        "onTap":AppRoutes.myProfileScreen,
      },
      {
        'image':"assets/terms.svg", 
        'title':"Terms And Conditions", 
        "onTap":AppRoutes.termsAndConditions,
      },
      {
        'image':"assets/privacy.svg", 
        'title':"Privacy Policy", 
        "onTap":AppRoutes.privacyPolicy,
      },
      {
        'image':"assets/about_us.svg", 
        'title':"About Us", 
        "onTap":AppRoutes.aboutUs,
      }, 
      {
        'image':"assets/faq.svg", 
        'title':"FAQ", 
        "onTap":AppRoutes.fAQPage,
      },
      {
        'image':"assets/logout.svg", 
        'title':"Log Out", 
        "onTap":"logout",
      },
    ];

    return  Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<LoginCubit,LoginState>(builder: (context, state) {
            return Column(
            crossAxisAlignment:  CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40,),
      
              Align( 
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1,), 
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: (state.userData?['profileUrl'].isNotEmpty??false)
                    ?Image.network(
                      '${state.userData?['profileUrl']}',fit: BoxFit.fill,scale: 0.5,cacheWidth: 150, cacheHeight: 150,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/logo.jpeg',fit: BoxFit.fill,scale: 0.5,cacheWidth: 150, cacheHeight: 150,);
                        
                      },

                      )
                    :Image.asset('assets/logo.jpeg',fit: BoxFit.fill,scale: 0.5,cacheWidth: 150, cacheHeight: 150,),
                  ),
                ),
              ),
      
              const SizedBox(height: 10,),
               CustomText(text: '${state.userData?['firstName']??""} ${state.userData?['lastName']??""}',fontWeight: FontWeight.bold, fontsize: 22, color: kBlack,),
              const SizedBox(height: 10,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), 
                  color: ((state.userData?['accountStatus']??"unActive")=="unActive")
                  ?kRed.withOpacity(0.8)
                  :(state.userData?['accountStatus'].toLowerCase()=="pending")
                  ?kOrange.withOpacity(0.9)
                  :kGreen.withOpacity(0.6)
                ),
                child:  CustomText(text:((state.userData?['accountStatus']??"unActive")=="unActive")?"Non Active":(state.userData?['accountStatus']=="pending")?"Pending":state.userData?['accountStatus'], color: kWhite, fontsize: 12,),
              ),
              const SizedBox(height: 40,),

              ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => (list[index]['onTap']=="logout")?logoutPopup(context):Navigator.pushNamed(context,list[index]['onTap']),
              titleAlignment: ListTileTitleAlignment.center,
              leading: SvgPicture.asset(list[index]['image'],height: 23,width: 23, colorFilter: const ColorFilter.mode(primaryColor, BlendMode.dstIn),),
              title:  Text(list[index]['title']),
              trailing: const Icon(Icons.keyboard_arrow_right_rounded, color: primaryColor),
              );
              
              
              }, separatorBuilder: (BuildContext context, int index) {
              return  Divider(color: primaryColor.withOpacity(0.4), thickness:0.3,height: 0.3,);
              },),

              
             
            ],
          );
          },)
          ),
      ),
    );
  }
  
 Future<dynamic> logoutPopup(BuildContext context) {
    return showDialog(context: context, builder:(context) {
                    return  AlertDialog(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12)), side: BorderSide(color: kTransparent, width: 0)),
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
                                   Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => true);
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