import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;
  final Function(BuildContext)? defaultTapped;
  var tileColor = Colors.grey[100];
  HabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.settingsTapped,
    required this.deleteTapped,
    required this.defaultTapped,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: settingsTapped,
            backgroundColor: Colors.grey.shade800,
            icon: Icons.settings,
            borderRadius: BorderRadius.circular(12),
          ),
          SlidableAction(
            onPressed: defaultTapped,
            backgroundColor: Colors.blue.shade400,
            icon: Icons.add_circle_outline_outlined,
            borderRadius: BorderRadius.circular(12),
          ),
          SlidableAction(
            onPressed: deleteTapped,
            backgroundColor: Colors.red.shade400,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(12),
          ),
        ]),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color:
                habitCompleted ? tileColor = Colors.green.shade300 : tileColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: habitCompleted,
                    onChanged: onChanged,
                  ),
                  Text(
                    habitName,
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
