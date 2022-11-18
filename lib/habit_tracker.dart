import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit_tracker_db.dart';
import 'package:habit_tracker/monthly_summary.dart';
import 'package:habit_tracker/utils/alert_box.dart';
import 'package:habit_tracker/utils/habit_tile.dart';
import 'package:habit_tracker/utils/my_fab.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabitTracker extends StatefulWidget {
  const HabitTracker({super.key});

  @override
  State<HabitTracker> createState() => _HabitTrackerState();
}

class _HabitTrackerState extends State<HabitTracker> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Track_Db");

  bool isAlreadyDefault = false;

  @override
  void initState() {
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  bool habitCompleted = false;

  void checkboxChecked(bool? value, index) {
    setState(() {
      db.todaysHabitList[index][1] = value;
    });
    db.updateDatabase();
  }

  void defaultHabit(index) {
    setState(() {
      if (db.todaysHabitList[index][2] != 1) {
        db.todaysHabitList[index][2] = 1;
        isAlreadyDefault = false;
      } else {
        isAlreadyDefault = true;
      }
    });
    db.addDefaultHabit();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: Icon(
              Icons.check,
              color: Colors.green,
            ),
            title: Text(
              isAlreadyDefault
                  ? "Habit is already default"
                  : "Habit added as default",
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            content: MaterialButton(
              color: Colors.green,
              onPressed: clickCancel,
              child: Text(
                "OK!",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        });
    // print("lessgooo");
    // db.updateDatabase();
  }

  final _newHabitController = TextEditingController();

  void clickSave() {
    setState(() {
      if (_newHabitController.text != "") {
        db.todaysHabitList.add([_newHabitController.text, false, 0]);
        _newHabitController.clear();
        Navigator.of(context).pop();
        db.updateDatabase();
      }
    });
  }

  void clickCancel() {
    _newHabitController.clear();
    Navigator.of(context).pop();
  }

  void addHabit() {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertBox(
            controller: _newHabitController,
            onSave: clickSave,
            onCancel: clickCancel,
            hintText: "Enter a new habit ...",
          );
        });
    db.updateDatabase();
  }

  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitController.text;
    });
    _newHabitController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void openHabitSettings(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertBox(
              controller: _newHabitController,
              onSave: () => saveExistingHabit(index),
              onCancel: clickCancel,
              hintText: "Rename habit ...");
        });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: MyFloatingActionButton(
          onPressed: addHabit,
        ),
        body: ListView(
          children: [
            //monthly summary heatmap
            MonthlySummary(
                datasets: db.heatMapDataSet,
                startDate: _myBox.get("START_DATE")),
            //list of habits builder
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: db.todaysHabitList.length,
              itemBuilder: (context, index) {
                return HabitTile(
                  habitCompleted: db.todaysHabitList[index][1],
                  habitName: db.todaysHabitList[index][0],
                  onChanged: (value) => checkboxChecked(value, index),
                  settingsTapped: (context) => openHabitSettings(index),
                  deleteTapped: (context) => deleteHabit(index),
                  defaultTapped: (context) => defaultHabit(index),
                );
              },
            ),
          ],
        ));
  }
}
