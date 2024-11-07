import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Database {
  static Future addEmpolyeeDetails(Map<String,dynamic>employeeInfoMap,String id)async{
    return await FirebaseFirestore.instance.collection("Employee").doc(id).set(employeeInfoMap);
  }
}