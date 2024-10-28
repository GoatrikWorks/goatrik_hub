import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/models/user.dart';
import '../../auth/widgets/role_guard.dart';
import '../../home/enums/user_role.dart';
import '../providers/super_admin_provider.dart' as provider;
import '../models/admin_settings.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoleGuard(
      minimumRole: UserRole.admin,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Admin Dashboard'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Users'),
                Tab(text: 'Settings'),
                Tab(text: 'Logs'),
                Tab(text: 'Analytics'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              UserManagementTab(),
              SettingsTab(), // Removed const
              AdminLogsTab(), // Removed const
              AnalyticsTab(), // Removed const
            ],
          ),
        ),
      ),
    );
  }
}

class UserManagementTab extends StatelessWidget {
  const UserManagementTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<provider.SuperAdminProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${provider.error}'),
                ElevatedButton(
                  onPressed: provider.fetchUsers,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: provider.fetchUsers,
          child: ListView.builder(
            itemCount: provider.users.length,
            itemBuilder: (context, index) {
              final user = provider.users[index];
              return UserListItem(user: user);
            },
          ),
        );
      },
    );
  }
}

class UserListItem extends StatelessWidget {
  final User user;

  const UserListItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<provider.SuperAdminProvider>();

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
        child: user.avatarUrl == null ? Text(user.name[0].toUpperCase()) : null,
      ),
      title: Text(user.name),
      subtitle: Text('${user.email} - ${user.role.displayName}'),
      trailing: PopupMenuButton<UserRole>(
        initialValue: user.role,
        onSelected: (UserRole? role) async {
          if (role == null) return;
          try {
            await provider.updateUserRole(user.id, role);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Updated ${user.name}\'s role to ${role.displayName}'),
                ),
              );
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: $e'),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            }
          }
        },
        itemBuilder: (BuildContext context) {
          return UserRole.values.map((UserRole role) {
            return PopupMenuItem<UserRole>(
              value: role,
              child: Text(role.displayName),
            );
          }).toList();
        },
      ),
      onLongPress: () => _showDeleteDialog(context, provider, user),
    );
  }

  void _showDeleteDialog(
      BuildContext context,
      provider.SuperAdminProvider provider,
      User user,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: Text('Are you sure you want to delete ${user.name}?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                try {
                  await provider.deleteUser(user.id);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Deleted user ${user.name}'),
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: $e'),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<provider.SuperAdminProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final settings = provider.settings ?? AdminSettings.defaults();

        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSettingSwitch(
              context,
              title: 'Enable User Registration',
              value: settings.enableUserRegistration,
              onChanged: (value) {
                provider.updateSettings(settings.copyWith(enableUserRegistration: value));
              },
            ),
            _buildSettingSwitch(
              context,
              title: 'Require Email Verification',
              value: settings.requireEmailVerification,
              onChanged: (value) {
                provider.updateSettings(settings.copyWith(requireEmailVerification: value));
              },
            ),
            _buildSettingSwitch(
              context,
              title: 'Maintenance Mode',
              value: settings.maintenanceMode,
              onChanged: (value) {
                provider.updateSettings(settings.copyWith(maintenanceMode: value));
              },
            ),
            if (settings.maintenanceMode) ...[
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Maintenance Message',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                controller: TextEditingController(text: settings.maintenanceMessage),
                onChanged: (value) {
                  provider.updateSettings(settings.copyWith(maintenanceMessage: value));
                },
              ),
            ],
            const SizedBox(height: 16),
            _buildNumberSetting(
              context,
              title: 'Max Login Attempts',
              value: settings.maxLoginAttempts,
              onChanged: (value) {
                if (value != null) {
                  provider.updateSettings(settings.copyWith(maxLoginAttempts: value));
                }
              },
            ),
            const SizedBox(height: 16),
            _buildDurationSetting(
              context,
              title: 'Session Timeout',
              value: settings.sessionTimeout,
              onChanged: (value) {
                provider.updateSettings(settings.copyWith(sessionTimeout: value));
              },
            ),
            const SizedBox(height: 16),
            _buildDomainList(
              context,
              settings.allowedDomains,
              onChanged: (domains) {
                provider.updateSettings(settings.copyWith(allowedDomains: domains));
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSettingSwitch(
      BuildContext context, {
        required String title,
        required bool value,
        required ValueChanged<bool> onChanged,
      }) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildNumberSetting(
      BuildContext context, {
        required String title,
        required int value,
        required ValueChanged<int?> onChanged,
      }) {
    return Row(
      children: [
        Expanded(child: Text(title)),
        SizedBox(
          width: 100,
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            controller: TextEditingController(text: value.toString()),
            onChanged: (value) => onChanged(int.tryParse(value)),
          ),
        ),
      ],
    );
  }

  Widget _buildDurationSetting(
      BuildContext context, {
        required String title,
        required Duration value,
        required ValueChanged<Duration> onChanged,
      }) {
    return Row(
      children: [
        Expanded(child: Text(title)),
        SizedBox(
          width: 100,
          child: DropdownButton<int>(
            value: value.inHours,
            items: [1, 2, 4, 8, 12, 24, 48, 72]
                .map((hours) => DropdownMenuItem(
              value: hours,
              child: Text('$hours h'),
            ))
                .toList(),
            onChanged: (hours) {
              if (hours != null) {
                onChanged(Duration(hours: hours));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDomainList(
      BuildContext context,
      List<String> domains,
      {required ValueChanged<List<String>> onChanged},
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Allowed Domains'),
        const SizedBox(height: 8),
        ...domains.map((domain) => Chip(
          label: Text(domain),
          onDeleted: () {
            onChanged(domains.where((d) => d != domain).toList());
          },
        )),
        TextButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Add Domain'),
          onPressed: () => _showAddDomainDialog(context, domains, onChanged),
        ),
      ],
    );
  }

  void _showAddDomainDialog(
      BuildContext context,
      List<String> currentDomains,
      ValueChanged<List<String>> onChanged,
      ) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Domain'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Domain',
            hintText: 'example.com',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final domain = controller.text.trim();
              if (domain.isNotEmpty) {
                onChanged([...currentDomains, domain]);
              }
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class AdminLogsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<provider.SuperAdminProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        // Implementera sökfunktion
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {
                      // Visa filteralternativ
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 0, // Använd provider.logs.length
                itemBuilder: (context, index) {
                  return const ListTile(); // Implementera loggvisning
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class AnalyticsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Analytics kommer snart...'),
    );
  }
}
