import 'package:qualita/data/models/project_model.dart';
import 'package:qualita/data/models/step_model.dart';
import 'package:qualita/data/repositories/base_repository.dart';
import 'package:qualita/global_keys.dart';
import 'package:qualita/data/query_responses.dart';

class ProjectRepository extends BaseRepository {
  Future<MultipleDataResponse<ProjectModel>> fetchProjects() async {
    return await returnMany(() async {
      var user = getCurrentUser();
      if (user == null) {
        throw Exception('No user has logged in');
      }
      return await projectServices.fetchForUser(user.id);
    });
  }

  Future<SingleDataResponse<ProjectModel>> findProject(String id) async {
    return await returnOne(() async => projectServices.getById(id));
  }

  Future<SingleDataResponse<ProjectModel>> addProject({
    required String name,
    String? description,
  }) async {
    return await returnOne(() async {
      var user = getCurrentUser();
      if (user == null) {
        throw Exception('No user has logged in');
      }
      var model = ProjectModel(
        name: name,
        fkUserId: user.id,
        description: description,
      );
      var newProject = await projectServices.insert(model);
      if (newProject.id == null) {
        throw Exception('Project ID cannot be set');
      }

      // Create 3 new default task panels for every new project created
      await stepServices.insert(
        StepModel(name: 'To-Do', fkProjectId: newProject.id!),
      );
      await stepServices.insert(
        StepModel(name: 'Doing', fkProjectId: newProject.id!),
      );
      await stepServices.insert(
        StepModel(name: 'Done', fkProjectId: newProject.id!),
      );

      return newProject;
    });
  }

  Future<SingleDataResponse<ProjectModel>> editProject({
    required String id,
    required String name,
    String? description,
  }) async {
    return await returnOne(() async {
      var user = getCurrentUser();
      if (user == null) {
        throw Exception('No user has logged in');
      }
      var model = ProjectModel(
        id: id,
        name: name,
        fkUserId: user.id,
        description: description,
      );
      await projectServices.update(model);
      return model;
    });
  }
}
