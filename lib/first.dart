import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_empolye/database.dart';
import 'package:firebase_empolye/second.dart';
import 'package:flutter/material.dart';

class Firstscreen extends StatefulWidget {
  const Firstscreen({super.key});

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen> {
  TextEditingController Namecontroller = TextEditingController();
  TextEditingController Agecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  Stream<QuerySnapshot>? EmployeeStrem;

  getontheload() async {
    EmployeeStrem = await Database.getEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getontheload();
  }

  Widget allEmployeeDetails() {
    return StreamBuilder<QuerySnapshot>(
        stream: EmployeeStrem,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error:${snapshot.error}"),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No employee data available."));
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data!.docs[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  color: Colors.lightBlue,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Name:" + (ds["Name"] ?? 'N/A'),
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: GestureDetector(
                                onTap: () async {
                                  await Database.deleteEmployeeDetails(
                                      ds['Id']);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                          )
                        ],
                      ),
                      Text(
                        "Age:" + (ds["Age"] ?? 'N/A').toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Location:" + (ds["Location"] ?? 'N/A'),
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Flutter Firebase"),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: allEmployeeDetails()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Secondscreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
