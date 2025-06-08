import 'package:qualita/data/models/task_model.dart';
import 'package:qualita/data/services/base_services.dart';

class TaskServices extends BaseServices<TaskModel> {
  TaskServices() : super(fromMap: TaskModel.fromMap, table: 'tasks');
}
