import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../auth/providers/auth_provider.dart';
import '../widgets/activity_chart.dart';
import '../widgets/new_activity_sheet.dart';
import '../widgets/recent_activities.dart';
import '../widgets/stat_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${user?.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: AnimationLimiter(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 24),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    StatCard(
                      title: 'Total Users',
                      value: '1,234',
                      icon: Icons.people,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    StatCard(
                      title: 'Active Now',
                      value: '891',
                      icon: Icons.trending_up,
                      color: Colors.green,
                    ),
                    StatCard(
                      title: 'Revenue',
                      value: '\$12.4K',
                      icon: Icons.attach_money,
                      color: Colors.amber,
                    ),
                    StatCard(
                      title: 'Growth',
                      value: '+22.3%',
                      icon: Icons.show_chart,
                      color: Colors.purple,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Activity Overview',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        const ActivityChart(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const RecentActivities(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const NewActivitySheet(),
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
