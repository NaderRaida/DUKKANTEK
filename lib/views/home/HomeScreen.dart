import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/controller/GeneralController.dart';
import 'package:app/controller/LanguageController.dart';
import 'package:app/custom_widgets/CustomAppBar.dart';
import 'package:app/custom_widgets/CustomNotchedRectangle.dart';
import 'package:app/extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:app/singleton/AppStorage.dart';
import 'package:app/singleton/dio.dart';
import 'package:app/views/home/taps/ExamsTap.dart';
import 'package:app/views/home/taps/HomeTap.dart';
import 'package:app/views/home/taps/NotificationsTap.dart';
import 'package:app/views/home/taps/OffersTap.dart';
import 'package:app/views/home/taps/ProfileTap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class HomeScreen extends StatefulWidget {
  int index;
  HomeScreen({this.index = 0});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  int prevIndex = 0;
  List<Widget> _children = [];
  static final List<String> iconsName = [
    ASSETS_ICONS+"home.svg",
    ASSETS_ICONS+"profile.svg",
    ASSETS_ICONS+"notifications_ic.svg",
    ASSETS_ICONS+"offer_ic.svg"
  ];

  static final List<String> teacherIconsName = [
    ASSETS_ICONS+"home.svg",
    ASSETS_ICONS+"notifications_ic.svg",
    ASSETS_ICONS+"profile.svg",
  ];

  final List<Widget> iconsTaps = [
    for (int i = 0; i < (AppStorage().getUserType() == STUDENT ? iconsName.length : teacherIconsName.length); i++)
      SvgPicture.asset(
        AppStorage().getUserType() == STUDENT ? iconsName[i] : teacherIconsName[i],
        color: unSelectedTap,
      )
  ];

  final List<Widget> activeIconsTaps = [
    for (int i = 0; i < (AppStorage().getUserType() == STUDENT ? iconsName.length : teacherIconsName.length); i++)
      SvgPicture.asset(
        AppStorage().getUserType() == STUDENT ? iconsName[i] : teacherIconsName[i],
        color: primaryColor,
      )
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = widget.index;
  }
  @override
  Widget build(BuildContext context) {
    if(AppStorage().getUserType() == STUDENT){
      _children = [
        HomeTap(),
        ProfileTap(),
        NotificationsTap(),
        OffersTap(),
      ];
    }else{
      _children = [
        HomeTap(),
        NotificationsTap(),
        ProfileTap()
      ];
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: index == 0 ? ChromeSettingsForSpecificScreen.splashChromeSetting()
          : ChromeSettingsForSpecificScreen.primaryChromeSetting(),
      child: GetBuilder<GeneralController>(
        init: GeneralController(),
        builder: (controller){
          return WillPopScope(
            onWillPop: (){
              if(this.index != 0){
                setState(() {
                  int prevPrev = index;
                  index = prevIndex;
                  prevIndex = prevPrev;
                });
              } else {
                SystemNavigator.pop();
              }
              return Future.value(false);
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    index == 0 ? white : primaryColor,
                    white
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  stops: [0.5, 0.5],
                ),
              ),
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: white,
                  appBar: (index == 1 && AppStorage().getUserType() == STUDENT)
                      || (index == 2 && AppStorage().getUserType() == TEACHER) ? null : CustomAppBar(
                    title: index == 0 ? "homeScreen" :
                    "empty",
                    isBack: false,
                    backColor: index == 0 ? white : primaryColor,
                    fromHomeTap: index == 0,
                    titleColor: index == 0 ? lightBlue : white,
                    backCallBack: (){
                    },
                  ),
                  body: _children[index],
                  bottomNavigationBar: myCustomBottomNavigation(controller),
                  floatingActionButton: FloatingActionButton(
                    onPressed: (){

                    },
                    child: Center(
                      child: AppStorage().getUserType() == STUDENT ? Icon(
                        Icons.add,
                        size: 25.w,
                        color: white,
                      ) : SvgPicture.asset(
                        ASSETS_ICONS + "home.svg",
                        color: white,
                      ),
                    ),
                    backgroundColor: AppStorage().getUserType() == STUDENT ? primaryColor :
                    index == 0 ? primaryColor : unSelectedTap,
                    elevation: 0,
                    hoverElevation: 0,
                    focusElevation: 0,
                    highlightElevation: 0,
                    disabledElevation: 0,
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget myCustomBottomNavigation(GeneralController generalController){
    return Container(
      width: 1.0.sw,
      height: 70.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(30.0.w),
          topStart: Radius.circular(30.0.w),
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.39),
            spreadRadius: 0,
            blurRadius: 15.sp,
            offset: Offset(0.0, -9.0.h), // changes position of shadow
          ),
        ],
      ),
      child:  BottomAppBar(
        shape: CustomNotchedRectangle(),
        notchMargin: 7,
        elevation: 0,
        child: Container(
          padding: EdgeInsetsDirectional.only(
            start: 19.0.w,
            end: 19.0.w,
            top: 17.0.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for(int i=(AppStorage().getUserType() == STUDENT ? 0 : 1);i<(AppStorage().getUserType() == STUDENT ? iconsName.length : teacherIconsName.length);i++)
                Transform.translate(
                  offset: Offset(i == (AppStorage().getUserType() == STUDENT ? 2 : 3) ?
                  getIt<LanguageController>().appLocal.languageCode.toLowerCase() == AR ? -20.w : 20.w
                      : i == (AppStorage().getUserType() == STUDENT ? 1 : 2) ?
                  getIt<LanguageController>().appLocal.languageCode.toLowerCase() == AR ? 10.w : -10.w
                      :0
                      ,0.0),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: (){
                      print("==>> index == $i");
                      if(i != index){
                        onTabTapped(i);
                      }
                    },
                    child: Container(
                      margin: EdgeInsetsDirectional.only(
                        end: i == (AppStorage().getUserType() == STUDENT ? 1 : 2) ? AppStorage().getUserType() == STUDENT ? 30.0.w : 50.w
                            : 0.0,
                        start: i == (AppStorage().getUserType() == STUDENT ? 2 : 3) && AppStorage().getUserType() == STUDENT ? 20.0.w
                            : i == 1 && AppStorage().getUserType() == TEACHER ? 50.w
                            : 0.0,
                      ),
                      child: bottomItem(i),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomItem(int i){
    return Container(
      height: 30.h,
      child: index == i ?
      activeIconsTaps[i] :
      iconsTaps[i],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      this.index = index;
    });
  }
}
