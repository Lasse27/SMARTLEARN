import 'package:flutter/material.dart';
import 'package:frontend/core/theme_provider.dart';
import 'package:frontend/screens/homescreen.dart';
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
    return MaterialApp(
      title: 'SmartLearn',
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
      home: const MainShell(),
    );
  }
}

/// Shell der Anwendung. Verwaltet alle relevanten Screenwechsel
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

/// Zustand der Shell der Anwendung.
class _MainShellState extends State<MainShell> {
  int _index = 0;

  final _pages = const [
    HomeScreen(),
    Center(child: Text('Lernen')),
    Center(child: Text('Aufgaben erstellen')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartLearnAppBar(),
      drawer: SmartLearnAppDrawer(),
      body: _pages[_index],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.star_border), label: 'Lernen'),
          NavigationDestination(
            icon: Icon(Icons.edit_outlined),
            label: 'Erstellen',
          ),
        ],
      ),
    );
  }
}
