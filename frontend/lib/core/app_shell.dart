import 'package:material_ui/material_ui.dart';
import 'package:frontend/widgets/shared/main_app_bar.dart';
import 'package:frontend/widgets/shared/main_app_drawer.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SmartLearnAppBar(),
      endDrawer: SmartLearnAppDrawer(),
      body: navigationShell,

      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.star_border),
            label: 'Dokumente',
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_outlined),
            label: 'Herausforderungen',
          ),
        ],
      ),
    );
  }
}
