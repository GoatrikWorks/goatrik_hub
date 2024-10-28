import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/super_admin_provider.dart';

class SuperAdminScreen extends StatelessWidget {
  const SuperAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Super Admin Panel'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Users'),
              Tab(text: 'Settings'),
              Tab(text: 'Logs'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UserManagementTab(),
            SettingsTab(),
            LogsTab(),
          ],
        ),
      ),
    );
  }
}

class UserManagementTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SuperAdminProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(child: Text('Error: ${provider.error}'));
        }

        return ListView.builder(
          itemCount: provider.users.length,
          itemBuilder: (context, index) {
            final user = provider.users[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: user.avatarUrl != null
                    ? NetworkImage(user.avatarUrl!)
                    : null,
                child: user.avatarUrl == null
                    ? Text(user.name[0].toUpperCase())
                    : null,
              ),
              title: Text(user.name),
              subtitle: Text(user.email),
              trailing: PopupMenuButton<UserRole>(
                initialValue: user.role,
                onSelected: (UserRole role) {
                  provider.updateUserRole(user.id, role);
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
          },
        );
      },
    );
  }

  void _showDeleteDialog(
      BuildContext context, SuperAdminProvider provider, User user) {
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
              child: const Text('Delete'),
              onPressed: () {
                provider.deleteUser(user.id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
