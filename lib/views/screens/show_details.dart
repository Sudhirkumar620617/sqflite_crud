import 'package:flutter/material.dart';
import 'package:sqflite_test/modles/user_modle.dart';

// ignore: must_be_immutable
class ShowDataDetails extends StatefulWidget {
  UserModles usermodle;
   ShowDataDetails({super.key, required  this.usermodle});

  @override
  State<ShowDataDetails> createState() => _ShowDataDetailsState();
}

class _ShowDataDetailsState extends State<ShowDataDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.usermodle.username.toString()),
      ),
      body: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),),

        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Name:---${widget.usermodle.username}"),
                  Text("Address:---${widget.usermodle.address}"),
                  Text("Email:---${widget.usermodle.email}"),
                  Text("Password:---${widget.usermodle.password}"),
                  Text("Phone:---${widget.usermodle.phone}"),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
