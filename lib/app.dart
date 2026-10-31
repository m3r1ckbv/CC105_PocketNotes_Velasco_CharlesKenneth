// import 'package:flutter/material.dart';

// import 'controllers/task_controller.dart';
// import 'controllers/theme_controller.dart';
// import 'core/theme/app_theme.dart';
// import 'ui/pages/home_page.dart';

// class PocketTaskApp extends StatelessWidget {
//   const PocketTaskApp({
//     super.key,
//     required this.themeController,
//     required this.taskController,
//   });

//   final ThemeController themeController;
//   final TaskController taskController;

//   @override
//   Widget build(BuildContext context) {
//     return ListenableBuilder(
//       listenable: themeController,
//       builder: (_, __) => MaterialApp(
//         title: 'Pocket Task',
//         debugShowCheckedModeBanner: false,
//         theme: AppTheme.light,
//         darkTheme: AppTheme.dark,
//         themeMode: themeController.mode,
//         home: HomePage(
//           taskController: taskController,
//           themeController: themeController,
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/task_controller.dart';
import 'controllers/theme_controller.dart';
import 'core/theme/app_theme.dart';
import 'data/local/preferences_service.dart';
import 'ui/pages/home_page.dart';

class PocketTaskApp extends StatefulWidget {
  const PocketTaskApp({super.key, required this.taskController});

  final TaskController taskController;

  @override
  State<PocketTaskApp> createState() => _PocketTaskAppState();
}

class _PocketTaskAppState extends State<PocketTaskApp> {
  // Null until the saved theme has been read.
  ThemeController? _themeController;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await Future.delayed(
      const Duration(seconds: 2), // EXPERIMENT ONLY: stretches the wrong-theme frame
      () => SharedPreferences.getInstance(),
    );
    if (!mounted) return;
    setState(() {
      _themeController = ThemeController(PreferencesService(prefs));
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeController = _themeController;

    // Frame 1: saved theme not read yet, so the app draws in the default light theme.
    if (themeController == null) {
      return MaterialApp(
        title: 'Pocket Task',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: Scaffold(
          appBar: AppBar(title: const Text('Pocket Task')),
        ),
      );
    }

    // Saved theme arrived: same app as before.
    return ListenableBuilder(
      listenable: themeController,
      builder: (_, __) => MaterialApp(
        title: 'Pocket Task',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeController.mode,
        home: HomePage(
          taskController: widget.taskController,
          themeController: themeController,
        ),
      ),
    );
  }
}