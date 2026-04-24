import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qualita/data/models/task_status.dart';
import 'package:qualita/data/repositories/task_repository.dart';

class DashboardBox extends StatelessWidget {
  final TaskStatus status;

  const DashboardBox({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: 125,
      decoration: BoxDecoration(
        color: TaskStatus.getColor(status),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(TaskStatus.getName(status)),
          ValueListenableBuilder(
            valueListenable: TaskRepository.box.listenable(),
            builder: (context, box, _) {
              final tasks = box.values
                  .where((task) => task.status == status)
                  .length;
              return Text(
                '$tasks',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
