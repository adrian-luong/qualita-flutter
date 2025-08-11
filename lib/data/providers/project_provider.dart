import 'package:qualita/data/models/project_model.dart';
import 'package:qualita/data/providers/base_provider.dart';
import 'package:qualita/data/repositories/project_repository.dart';

class ProjectProvider extends BaseProvider {
  final _repo = ProjectRepository();

  ProjectModel? _selectedProject;
  ProjectModel? get selectedProject => _selectedProject;
  List<ProjectModel> _projects = [];
  List<ProjectModel> get projects => _projects;

  ProjectProvider() {
    fetchProjects();
  }

  Future<void> findProject(String id) async {
    await operate(() async {
      var response = await _repo.findProject(id);
      if (response.hasError) {
        throw Exception(response.message ?? 'Unexpected error');
      } else {
        _selectedProject = response.data;
      }
    });
  }

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

  Future<void> editProject({
    required String projectId,
    required String name,
    String? description,
  }) async {
    await operate(() async {
      var response = await _repo.editProject(
        id: projectId,
        name: name,
        description: description,
      );
      if (response.hasError || response.data == null) {
        throw Exception(response.message ?? 'Unexpected error');
      } else {
        var selectedIndex = _projects.indexWhere(
          (project) => project.id == projectId,
        );
        _projects[selectedIndex] = response.data!;
      }
    });
  }
}
