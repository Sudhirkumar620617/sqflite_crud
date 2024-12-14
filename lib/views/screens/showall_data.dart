import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sqflite_test/modles/user_modle.dart';
import 'package:sqflite_test/views/screens/show_details.dart';
import 'package:sqflite_test/views/screens/update_screens.dart';
import '../../contrller/services/datacontroller.dart';
import 'signup_screens.dart';

class ShowAllData extends StatefulWidget {
  const ShowAllData({super.key});

  @override
  State<ShowAllData> createState() => _ShowAllDataState();
}

class _ShowAllDataState extends State<ShowAllData> {
  @override
  Widget build(BuildContext context) {
    DataController dataController = Get.put(DataController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Show All Data"),
        backgroundColor: Colors.blue,
      ),
      body: Obx(() {
        return dataController.allData.isNotEmpty
            ? ListView.builder(
          itemCount: dataController.allData.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final student = dataController.allData[index];
            return Slidable(
              endActionPane: ActionPane(
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      dataController.deleteData(student[DataController.columnSrNo]);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data is Deleted Success Full")));
                    },
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      Get.to(UpdateData(userModles: UserModles(
                        username: student[DataController.columnStudentName],
                        address: student[DataController.columnStudentAddress],
                        email: student[DataController.columnStudentEmail],
                        password: student[DataController.columnStudentPassword],
                        phone: student[DataController.columnStudentPhone],
                      ),

                        index:student[DataController.columnSrNo],));
                    },
                    icon: Icons.edit,
                    backgroundColor: Colors.green,
                    label: 'Edit',
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 20,
                  shadowColor: Colors.cyan,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Name: ${student[DataController.columnStudentName]}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                             GestureDetector(
                                 onTap: () =>Get.to(ShowDataDetails(
                                   usermodle:UserModles(
                                     username: student[DataController.columnStudentName],
                                     address: student[DataController.columnStudentAddress],
                                     email: student[DataController.columnStudentEmail],
                                     password: student[DataController.columnStudentPassword],
                                     phone: student[DataController.columnStudentPhone],
                                   )
                                 )) ,
                                 child: const Icon(Icons.arrow_forward_ios))
                          ],
                        ),
                        Text("Address: ${student[DataController.columnStudentAddress]}"),
                        Text("Email: ${student[DataController.columnStudentEmail]}"),
                        Text("Phone: ${student[DataController.columnStudentPhone]}"),
                        Text("Password: ${student[DataController.columnStudentPassword]}"),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )
            : const Center(
          child: Text("No Data Found"),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignupScreens()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
