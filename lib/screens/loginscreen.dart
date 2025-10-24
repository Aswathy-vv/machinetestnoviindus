import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:machinetestnoviindus/constants/Approutes.dart';
import 'package:machinetestnoviindus/constants/color.dart';
import 'package:machinetestnoviindus/constants/customsnackbar.dart';
import 'package:machinetestnoviindus/constants/textsize.dart';
import 'package:machinetestnoviindus/main.dart';
import 'package:machinetestnoviindus/provider/loginprovider.dart';
import 'package:machinetestnoviindus/screens/homescreen.dart';
import 'package:provider/provider.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController countryCode = TextEditingController(text: '+91');
  final TextEditingController phone = TextEditingController();
  String? initialCode = "IN";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter your Mobile Number",
                style: TextStyle(
                    fontSize: AppTextsize.headingLarge,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Lorem ipsum dolor sit amet consectur.porta at id hac vitae.Et tortor at vehicula euismod mi viverra",
                style: TextStyle(
                  fontSize: AppTextsize.bodySmall,
                  fontWeight: FontWeight.normal,
                  color: AppColors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.white.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CountryCodePicker(
                        textStyle: const TextStyle(
                          color: Colors.white, // text inside picker
                          fontSize: 16,
                        ),
                        dialogTextStyle: const TextStyle(
                          color: Colors.black, // text inside dialog list
                          fontSize: 16,
                        ),
                        showOnlyCountryWhenClosed: false,
                        favorite: const ["IN"],
                        initialSelection: initialCode,
                        pickerStyle: PickerStyle.bottomSheet,
                        showCountryOnly: true,
                        showFlag: false,
                        showFlagDialog: true,
                        onChanged: (value) {
                          initialCode = value.toString();
                        },
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      maxLength: 10,
                      controller: phone,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                          fontSize: AppTextsize.bodyMedium,
                          color: AppColors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter your mobile number',
                        hintStyle: TextStyle(color: AppColors.white),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: AppColors.white.withOpacity(0.4)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: AppColors.white.withOpacity(0.4)),
                        ),
                        counterText: "",
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () async {
                 
                  final result = await context
                      .read<AuthProvider>()
                      .loginprovider(initialCode!, phone.text);

                  if (result["status"] == true) {
                    CustomSnackBar.success(
                      context,
                      "Login successful",
                    ); 
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pushReplacementNamed(context, AppRoutes.home);
                    });
                  } else {
                    CustomSnackBar.error(
                      context,
                      result["message"] ?? "Login error",
                    );
                  }
               
                },
                child: Center(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Continue",
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CircleAvatar(
                            // radius: 20,
                            backgroundColor: AppColors.redcolor,
                            child: Icon(
                              size: AppTextsize.bodySmall,
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.peach, width: 1)),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
