// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'app.dart';
// import 'controllers/task_controller.dart';
// import 'controllers/theme_controller.dart';
// import 'data/local/database_helper.dart';
// import 'data/local/preferences_service.dart';
// import 'data/repositories/task_repository.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // SharedPreferences: loaded first so the saved theme is applied on frame 1.
//   final prefs = await SharedPreferences.getInstance();
//   final themeController = ThemeController(PreferencesService(prefs));

//   // Database: opened exactly once, here, at launch.
//   await DatabaseHelper.instance.init();
//   final taskController = TaskController(
//     TaskRepository(DatabaseHelper.instance.database),
//   );
//   await taskController.load(); // records ready before the first frame

//   runApp(PocketTaskApp(
//     themeController: themeController,
//     taskController: taskController,
//   ));

//   Future.delayed(const Duration(seconds: 10), () => SystemNavigator.pop(animated: true));
// }


import 'package:flutter/material.dart';

import 'app.dart';
import 'controllers/task_controller.dart';
import 'data/local/database_helper.dart';
import 'data/repositories/task_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // EXPERIMENT: SharedPreferences is NOT awaited before runApp() anymore.

  await DatabaseHelper.instance.init();
  final taskController = TaskController(
    TaskRepository(DatabaseHelper.instance.database),
  );
  await taskController.load();

  runApp(PocketTaskApp(taskController: taskController));
}