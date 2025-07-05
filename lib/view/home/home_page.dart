import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualita/data/providers/home_provider.dart';
import 'package:qualita/data/providers/project_provider.dart';
import 'package:qualita/view/common/custom_consumer.dart';
import 'package:qualita/utils/display_dialog.dart';
import 'package:qualita/view/common/common_layout.dart';
import 'package:qualita/view/home/projects/add_project_form.dart';
import 'package:qualita/view/home/steps/step_area.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _TabState();
}

class _TabState extends State<HomePage> with TickerProviderStateMixin {
  TabController? _controller;

  void onTabChange() {
    if (mounted && _controller != null && !_controller!.indexIsChanging) {
      // The indexIsChanging property is important.
      // It's true when the tab animation is in progress (e.g., swiping or clicking a tab).
      // We usually want to react after the animation settles, so we check !indexIsChanging.
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      final projectProvider = Provider.of<ProjectProvider>(
        context,
        listen: false,
      );
      final currentTabIndex = _controller!.index;
      final currentProject = projectProvider.projects[currentTabIndex];
      _controller!.index = currentTabIndex;
      homeProvider.selectProject(currentProject.id);
    }
  }

  void remakeController(int otherLength) {
    // Ensure the controller and listener are initialized
    _controller = TabController(length: otherLength, vsync: this);
    _controller!.addListener(onTabChange);
  }

  void disposeController() {
    // Dispose old controller and listener if the amount of projects changes
    _controller?.removeListener(onTabChange);
    _controller?.dispose();
    _controller = null;
  }

  @override
  void initState() {
    super.initState();
    // Initially fetch projects, which would be made into tabs
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProjectProvider>(context, listen: false).fetchProjects();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // This is a good place to re-initialize or update the TabController if the data it depends on changes.
    // Ensure we don't re-initialize unnecessarily.
    final projectProvider = Provider.of<ProjectProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final int newLength = projectProvider.projects.length;

    if (_controller != null &&
        (_controller!.length != newLength || newLength == 0)) {
      // Dispose old controller and listener if length changes or controller becomes null
      disposeController();
    }

    if (newLength > 0 && _controller == null) {
      remakeController(newLength);
      // Optional: If you want to select the first tab when data changes
      _controller!.index = 0;
      final firstTab = projectProvider.projects.first;
      homeProvider.selectProject(firstTab.id);
    }
  }

  @override
  void dispose() {
    disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return customConsume<ProjectProvider>(
      build: (context, provider, child) {
        if (mounted && provider.projects.isEmpty) {
          return const Center(child: Text('No project available to select'));
        }

        // Ensure _tabController is initialized before using it
        if (_controller == null ||
            _controller!.length != provider.projects.length) {
          // This case should ideally be handled by didChangeDependencies,
          // but a fallback here ensures robustness.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              // Re-initialize logic similar to didChangeDependencies to be safe
              disposeController();
              remakeController(provider.projects.length);
            });
          });
          return const PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: Center(
              child: CircularProgressIndicator(),
            ), // Show loading while re-initializing
          );
        }

        var tabs =
            provider.projects
                .map((project) => Tab(text: project.name))
                .toList();
        var views = provider.projects.map((project) => StepArea()).toList();

        return CommonLayout(
          tabBar: TabBar(controller: _controller, tabs: tabs),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: TabBarView(controller: _controller, children: views),
          ),
          floatCTA: FloatingActionButton(
            onPressed: () => displayDialog(context, [AddProjectForm()]),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
