import 'dart:io';
import 'package:app/custom_widgets/CustomAlertDialog.dart';
import 'package:app/custom_widgets/LoadingApp.dart';
import 'package:app/utils/language.dart';
import 'package:dio/dio.dart' as dio;
import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/controller/GeneralController.dart';
import 'package:app/custom_widgets/AppLogo.dart';
import 'package:app/custom_widgets/ButtonApp.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/custom_widgets/CustomTextField.dart';
import 'package:app/extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:app/singleton/AppStorage.dart';
import 'package:app/singleton/dio.dart';
import 'package:app/views/home/HomeScreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class JoinUsScreen extends StatefulWidget {
  const JoinUsScreen({Key? key,}) : super(key: key);

  @override
  _JoinUsScreenState createState() => _JoinUsScreenState();
}

class _JoinUsScreenState extends State<JoinUsScreen> {
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();

  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocus = FocusNode();

  TextEditingController userNameController = TextEditingController();
  FocusNode userNameFocus = FocusNode();

  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberFocus = FocusNode();

  TextEditingController educationLevelController = TextEditingController();
  FocusNode educationLevelFocus = FocusNode();

  TextEditingController specializationController = TextEditingController();
  FocusNode specializationFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  File? imageFile;

  String imageToSave = "";
  String? image;

  // PlatformFile? _cvFile;
  File? cvFile;
  String? cvUrl;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ChromeSettingsForSpecificScreen.splashChromeSetting(),
      child: GetBuilder<GeneralController>(
        init: GeneralController(),
        builder: (controller){
          return Container(
            color: white,
            child: SafeArea(
              child: Scaffold(
                appBar: null,
                backgroundColor: white,
                body: GestureDetector(
                  onTap: (){
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return false;
                    },
                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          Form(
                            key: _formKey,
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  CustomText(
                                    "joinUs",
                                    textColor: lightBlue,
                                    fontSize: 20,
                                    fontFamily: PRIMARY_FONT_BOLD,
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  userImage(),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(
                                      start: 30.w,
                                      end: 30.w,
                                    ),
                                    child: Column(
                                      children: [
                                        CustomTextField(
                                          "emailHint",
                                          emailController,
                                          emailFocus,
                                          passwordFocus,
                                          EMAIL,
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Column(
                                          children: [
                                            CustomTextField(
                                              "passwordHint",
                                              passwordController,
                                              passwordFocus,
                                              userNameFocus,
                                              PASSWORD,
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                          ],
                                        ),
                                        CustomTextField(
                                          "userName",
                                          userNameController,
                                          userNameFocus,
                                          phoneNumberFocus,
                                          FULL_NAME,
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        CustomTextField(
                                          "phoneNumber",
                                          phoneNumberController,
                                          phoneNumberFocus,
                                          AppStorage().getUserType() == STUDENT ? educationLevelFocus : specializationFocus,
                                          MOBILE,
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        if(AppStorage().getUserType() == STUDENT)
                                          CustomTextField(
                                            "educationLevel",
                                            educationLevelController,
                                            educationLevelFocus,
                                            null,
                                            FULL_NAME,
                                          )
                                        else
                                          CustomTextField(
                                            "specialization",
                                            specializationController,
                                            specializationFocus,
                                            null,
                                            FULL_NAME,
                                          ),
                                        if(AppStorage().getUserType() == TEACHER)
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                onTap: () async{
                                                  print("attachYourCV pressed");
                                                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                                                    type: FileType.custom,
                                                    allowMultiple: false,
                                                    allowedExtensions: ['pdf'],
                                                  );

                                                  if (result != null) {
                                                    int sizeInBytes = await File(result.files.single.path!).length();
                                                    double sizeInMb = sizeInBytes / (1024 * 1024);
                                                    if(sizeInMb <= 10){
                                                      setState(() {
                                                        cvFile = File(result.files.single.path!);
                                                      });
                                                    }else{
                                                      showDialog(
                                                        context: context,
                                                        useSafeArea: false,
                                                        barrierColor: barrierColor,
                                                        barrierDismissible: false,
                                                        builder: (_) => CustomAlertDialog(
                                                          GENERAL_DIALOG,
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          message: getTranslated("fileMustBeLessThan10MB"),
                                                        ),
                                                      );
                                                    }
                                                    // _cvFile = result.files.single;
                                                    setState(() {
                                                      // print("_file.bytes.toString()" + _cvFile!.bytes!.toString());
                                                    });
                                                  }
                                                },
                                                child: CustomTextField(
                                                  cvFile != null ? cvFile!.path.split("/").last :
                                                  cvUrl != null ? cvUrl!.split("/").last : "attachYourCV",
                                                  TextEditingController(),
                                                  FocusNode(),
                                                  null,
                                                  FULL_NAME,
                                                  translate: cvFile == null && cvUrl == null,
                                                  enabled: false,
                                                  hintColor: cvFile == null && cvUrl == null ? null : primaryColor,
                                                  withEndIcon:true,
                                                  icon: "attachment.svg",
                                                  iconColor: cvFile != null || cvUrl != null ? primaryColor : null,
                                                  enableValidation: false,
                                                ),
                                              ),
                                            ],
                                          ),
                                        SizedBox(
                                          height: 65.h,
                                        ),
                                        ButtonApp(
                                          height: 35,
                                          textColor: white,
                                          fontSize: 15,
                                          fontFamily: PRIMARY_FONT_BOLD,
                                          color: primaryColor,
                                          text: "confirm",
                                          function: () async{
                                            if(_formKey.currentState!.validate() && imageToSave.isNotEmpty
                                                && (AppStorage().getUserType() == STUDENT
                                                    || (AppStorage().getUserType() == TEACHER && cvFile != null))){
                                              var data = dio.FormData.fromMap({
                                                "email": emailController.text,
                                                "password": passwordController.text,
                                                "name": userNameController.text,
                                                "mobile": phoneNumberController.text,
                                                "type": AppStorage().getUserType() == STUDENT ? 0 : 1,
                                                if(imageToSave.isNotEmpty)
                                                  "image": await dio.MultipartFile.fromFile(imageToSave, filename: "img.png"),
                                                if(AppStorage().getUserType() == STUDENT)
                                                  "educational_level": educationLevelController.text,
                                                if(AppStorage().getUserType() == TEACHER)
                                                  "specialization": specializationController.text,
                                                if(AppStorage().getUserType() == TEACHER && cvFile != null)
                                                  "cv": await dio.MultipartFile.fromFile(cvFile!.path, filename: "cvFile.pdf")
                                              });
                                              controller.joinUs(data,(_user){
                                                print("Join Us done");
                                                Get.offAll(()=>HomeScreen());
                                              },(){

                                              });
                                            }else if(imageToSave.isEmpty && image == null){
                                              showDialog(
                                                context: Get.context!,
                                                useSafeArea: false,
                                                barrierColor: barrierColor,
                                                builder: (_) => CustomAlertDialog(
                                                  GENERAL_DIALOG,
                                                  onPressed: () => Get.back(),
                                                  message: getTranslated("pleaseSelectTheImage"),
                                                ),
                                              );
                                            }else if(AppStorage().getUserType() == TEACHER && cvFile == null){
                                              showDialog(
                                                context: Get.context!,
                                                useSafeArea: false,
                                                barrierColor: barrierColor,
                                                builder: (_) => CustomAlertDialog(
                                                  GENERAL_DIALOG,
                                                  onPressed: () => Get.back(),
                                                  message: getTranslated("pleaseAttachYourCV"),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          PositionedDirectional(
                            top: 10.h,
                            start: 5.w,
                            child: IconButton(
                              onPressed: (){
                                Get.back();
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_outlined,
                                color: lightBlue,
                                size: 19.w,
                              ),
                            ),
                          ),
                          if(controller.isLoading)
                            LoadingApp()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget userImage() {
    return Center(
      child: GestureDetector(
        onTap: () {
          getImageCrop().then((value) {
            setState(() {
              imageToSave = value.path;
              imageFile = value;
            });
          });
        },
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Container(
              width: 128.w,
              height: 128.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  64.w,
                ),
                child: imageToSave == ""
                    ? image != null
                    ? Image.network(
                  image!,
                  fit: BoxFit.cover,
                ) : Center(
                  child: Image.asset(
                    ASSETS_IMAGES + "user.png",
                    height: 128.w,
                    width: 128.w,
                  ),
                ) : Image.file(
                  File(imageToSave),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: 7.h,
                end: 6.w,
              ),
              child: SvgPicture.asset(
                ASSETS_ICONS + "camera.svg",
              ),
            )
          ],
        ),
      ),
    );
  }

}
