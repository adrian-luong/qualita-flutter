import 'package:qualita/data/models/project_model.dart';
import 'package:qualita/data/providers/base_provider.dart';
import 'package:qualita/data/repositories/project_repository.dart';

class ProjectProvider extends BaseProvider {
  final _repo = ProjectRepository();
  List<ProjectModel> _projects = [];
  List<ProjectModel> get projects => _projects;

  Future<void> fetchProjects() async {
    await operate(() async {
      var response = await _repo.fetchProjects();
      if (response.hasError) {
        throw Exception(response.message ?? 'Unexpected error');
      } else {
        _projects = response.data;
      }
    });
  }

  Future<void> addProject({required String name, String? description}) async {
    await operate(() async {
      var response = await _repo.addProject(
        name: name,
        description: description,
      );
      if (response.hasError || response.data == null) {
        throw Exception(response.message ?? 'Unexpected error');
      } else {
        _projects.add(response.data!); // Add the new todo to the local list
      }
    });
  }
}
