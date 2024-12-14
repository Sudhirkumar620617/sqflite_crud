import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_test/views/widgets/custom_buttons.dart';
import 'package:sqflite_test/views/widgets/custom_textfields.dart';
import '../../contrller/services/datacontroller.dart';
import '../../modles/user_modle.dart';

class SignupScreens extends StatefulWidget {
  const SignupScreens({super.key});
  @override
  State<SignupScreens> createState() => _SignupScreensState();
}

class _SignupScreensState extends State<SignupScreens> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  DataController dataController = Get.put(DataController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp Screens"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomTextFieldWidget(
                hintText: "Enter Your Name",
                iconData: Icons.person,
                keyboardType: TextInputType.text,
                controller: nameController,
              ),
              const SizedBox(height: 10),
              CustomTextFieldWidget(
                hintText: "Enter Your Address",
                iconData: Icons.home,
                keyboardType: TextInputType.text,
                controller: addressController,
              ),
              const SizedBox(height: 10),
              CustomTextFieldWidget(
                hintText: "Enter Your Email",
                iconData: Icons.email,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
              const SizedBox(height: 10),
              CustomTextFieldWidget(
                hintText: "Enter Your Password",
                iconData: Icons.lock,
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
              ),
              const SizedBox(height: 10),
              CustomTextFieldWidget(
                hintText: "Enter Your Phone",
                iconData: Icons.phone,
                keyboardType: TextInputType.phone,
                controller: phoneController,
              ),
              const SizedBox(height: 10),
              CustomButtons(
                onPress: ()async {
                  try {
                    UserModles userData = UserModles(
                      username: nameController.text.toString(),
                      address: addressController.text.toString(),
                      email: emailController.text.toString(),
                      password: passwordController.text.toString(),
                      phone: phoneController.text.toString()
                    );
                      await dataController.insertData(userData);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          "Sign Up Successful",
                          style: TextStyle(color: Colors.white),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 3),
                      ),
                    );
                    dataController.getAllData();
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));

                  }

                },

                text: "Sign Up",
                color: Colors.blue,
                radius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

