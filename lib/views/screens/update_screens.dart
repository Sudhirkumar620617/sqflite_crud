import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../contrller/services/datacontroller.dart';
import '../../modles/user_modle.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/custom_textfields.dart';


class UpdateData extends StatefulWidget {
  final UserModles userModles;
  final int index;

  const UpdateData({super.key, required this.userModles, required this.index});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;
  final DataController dataController = Get.put(DataController());

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.userModles.username);
    addressController = TextEditingController(text: widget.userModles.address);
    emailController = TextEditingController(text: widget.userModles.email);
    passwordController = TextEditingController(text: widget.userModles.password);
    phoneController = TextEditingController(text: widget.userModles.phone);
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Data"),
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
                onPress: () async {
                  bool success = await dataController.updateData(
                    userModles: UserModles(
                      username: nameController.text,
                      address: addressController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      phone: phoneController.text,
                    ),
                    index: widget.index,
                  );

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Data Updated Successfully")),
                    );
                    dataController.getAllData();
                    Navigator.pop(context); // Return to previous screen
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to Update Data")),
                    );
                  }
                },
                text: "Update Data",
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
