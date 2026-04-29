import 'package:inventory_p_shalaev/core/core.dart';
import 'package:inventory_p_shalaev/features/features.dart';
import 'package:inventory_p_shalaev/generated/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Navigation drawer for the application.
///
/// Contains links to main sections like categories and positions,
/// and displays application version information.
class AppDrawer extends StatelessWidget {
  /// Creates an [AppDrawer].
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Center(
              child: Text(
                l10n.home_appBarTitle,
                style: const TextStyle(
                  color: AppTheme.whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: Text(l10n.home_categoriesButton),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const CategoriesPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.work),
            title: Text(l10n.home_positionsButton),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => const PositionsPage(),
                ),
              );
            },
          ),
          const Spacer(),
          const Divider(),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final packageInfo = snapshot.data!;
                // ignore: do_not_use_environment
                const gitSha = String.fromEnvironment(
                  'GIT_SHA',
                  defaultValue: '62c8128',
                );

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Version: ${packageInfo.version}+${packageInfo.buildNumber}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Git SHA: $gitSha',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
