import 'package:frontend/core/app_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:frontend/core/theme_provider.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/widgets/shared/main_app_bar.dart';
import 'package:frontend/widgets/shared/main_app_drawer.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ThemeProvider vor App-Start laden, damit kein Flackern
  final themeProvider = ThemeProvider();
  await themeProvider.load();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: themeProvider)],
      child: const SmartLearnApp(),
    ),
  );
}

class SmartLearnApp extends StatelessWidget {
  const SmartLearnApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp.router(
      title: 'SmartLearn',
      routerConfig: router,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),

      themeMode: themeProvider.themeMode,
    );
  }
}
