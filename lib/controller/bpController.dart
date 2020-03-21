import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../entities/bloodPressure.dart';
import 'package:intl/intl.dart';
import '../pages/add_blood_pressure.dart';

class BpController{
  BloodPressure addbp(String uid, String diastolic,String systolic, String heartRate, String date, String time){
    
    /*referenceid = firestore.collection(user).doc(uid).collection(bloodpressure).doc(newbpid);
      referenceid.set({
      'Diastolic' : diastolic,
      'Systolic' : systolic,
      'HeartRate' : heartRate,
      'Date' : date,
      'Time' : time
    });
    */
  }
}