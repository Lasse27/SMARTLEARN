import 'package:material_ui/material_ui.dart';
import 'package:frontend/widgets/shared/app_bar.dart';
import 'package:frontend/widgets/shared/app_drawer.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      endDrawer: AppDrawer(),
      body: navigationShell,

      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(index);
        },
        destinations: const [
          // Homescreen
          NavigationDestination(icon: Icon(Icons.home), label: 'Startseite'),

          // Library
          NavigationDestination(icon: Icon(Icons.book), label: 'Bibliothek'),

          // Challenges
          NavigationDestination(icon: Icon(Icons.edit), label: 'Challenges'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
