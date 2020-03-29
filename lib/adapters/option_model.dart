import 'package:flutter/material.dart';

class Option {
  Icon icon;
  String title;
  String subtitle;

  Option({this.icon, this.title, this.subtitle});
}

final options = [
  Option(
    icon: Icon(Icons.local_pharmacy, size: 40.0),
    title: 'Medication Tracker',
    subtitle: 'Manage your Medications',
  ),
  Option(
    icon: Icon(Icons.calendar_today, size: 40.0),
    title: 'Appointment Tracker',
    subtitle: 'Schedule and Manage Appointments',
  ),
  Option(
    icon: Icon(Icons.local_hospital, size: 40.0),
    title: 'Clinic Locator',
    subtitle: 'View clinics around you',
  ),
  Option(
    icon: Icon(Icons.trending_up, size: 40.0),
    title: 'Health Vitals Tracker',
    subtitle: 'Log and Track your Vitals',
  )
];
