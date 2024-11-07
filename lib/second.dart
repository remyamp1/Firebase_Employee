import 'package:firebase_empolye/database.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Secondscreen extends StatefulWidget {
  const Secondscreen({super.key});

  @override
  State<Secondscreen> createState() => _SecondscreenState();
}

class _SecondscreenState extends State<Secondscreen> {
  TextEditingController Namecontroller = TextEditingController();
  TextEditingController Agecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Employe Form"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
                height: 50,
                width: 300,
                child: TextField(
                  controller: Namecontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Name")),
                )),
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: 300,
              child: TextField(
                controller: Agecontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text("Age")),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: 300,
              child: TextField(
                controller: locationcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text("Location")),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  String id = randomAlphaNumeric(10);
                  Map<String, dynamic> employeeInfoMap = {
                    "Name": Namecontroller.text,
                    "Age": Agecontroller.text,
                    "Id": id,
                    "Location": locationcontroller.text,
                  };
                  await Database.addEmpolyeeDetails(employeeInfoMap, id);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Employee Details add successfully"),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Namecontroller.clear();
                                  Agecontroller.clear();
                                  locationcontroller.clear();
                                },
                                child: Text("OK"))
                          ],
                        );
                      });
                },
                child: Text("Add"))
          ],
        ),
      ),
    );
  }
}
