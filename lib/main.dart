import 'package:flutter/material.dart';
import 'package:habit_tracker/habit_tracker.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("Habit_Track_Db");
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter Habit Tracker",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const SafeArea(child: HabitTracker())),
  );
}
