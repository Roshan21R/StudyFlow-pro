import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:badges/badges.dart' as badges;

import '../../../core/constants/app_constants.dart';
import '../../routes/app_router.dart';

class MainScreen extends ConsumerStatefulWidget {
  final Widget child;

  const MainScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  int _selectedIndex = 0;
  late AnimationController _fabAnimationController;
  late Animation<double> _fabAnimation;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.easeInOut,
    ));
    _fabAnimationController.forward();
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    final routes = AppRoutesConfig.getRoutesForBottomNav();
    if (index < routes.length) {
      context.go(routes[index].path);
    }
  }

  int _getCurrentIndex(String location) {
    final routes = AppRoutesConfig.getRoutesForBottomNav();
    for (int i = 0; i < routes.length; i++) {
      if (location.startsWith(routes[i].path)) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _getCurrentIndex(location);
    
    if (currentIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = currentIndex;
      });
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context, theme),
      drawer: _buildDrawer(context, theme),
      body: widget.child,
      bottomNavigationBar: _buildBottomNavigationBar(theme),
      floatingActionButton: _buildFloatingActionButton(theme),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, ThemeData theme) {
    final location = GoRouterState.of(context).matchedLocation;
    final routeInfo = AppRoutesConfig.getRouteInfo(location);
    
    return AppBar(
      title: Text(
        routeInfo?.label ?? AppConstants.appName,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 4,
      actions: [
        // Search button
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Implement search functionality
            _showSearchDialog(context);
          },
          tooltip: 'Search',
        ),
        
        // Notifications button with badge
        badges.Badge(
          badgeContent: const Text(
            '3',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          badgeStyle: badges.BadgeStyle(
            badgeColor: theme.colorScheme.error,
            padding: const EdgeInsets.all(6),
          ),
          child: IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              context.go(AppRoutes.notifications);
            },
            tooltip: 'Notifications',
          ),
        ),
        
        // Profile button
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () => context.go(AppRoutes.profile),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Text(
                'R',
                style: TextStyle(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context, ThemeData theme) {
    return NavigationDrawer(
      children: [
        // Header
        DrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.primaryContainer,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.school,
                  size: 30,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                AppConstants.appName,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Study Smart, Achieve More',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ],
          ),
        ),
        
        // Navigation items
        ...AppRoutesConfig.getRoutesForDrawer().map((route) {
          final isSelected = GoRouterState.of(context).matchedLocation == route.path;
          
          return NavigationDrawerDestination(
            icon: Badge(
              isLabelVisible: route.requiredPermissions.isNotEmpty,
              label: const Icon(Icons.lock, size: 12),
              child: Icon(route.icon),
            ),
            selectedIcon: Icon(route.icon),
            label: Text(route.label),
          );
        }),
        
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
        
        // Additional options
        NavigationDrawerDestination(
          icon: const Icon(Icons.backup),
          label: const Text('Backup & Sync'),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.palette),
          label: const Text('Themes'),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.help_outline),
          label: const Text('Help & Support'),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.info_outline),
          label: const Text('About'),
        ),
      ],
      onDestinationSelected: (index) {
        Navigator.of(context).pop();
        
        final allRoutes = [
          ...AppRoutesConfig.getRoutesForDrawer(),
          RouteInfo(
            path: AppRoutes.backup,
            name: 'backup',
            icon: Icons.backup,
            label: 'Backup & Sync',
          ),
          RouteInfo(
            path: AppRoutes.themes,
            name: 'themes',
            icon: Icons.palette,
            label: 'Themes',
          ),
          RouteInfo(
            path: AppRoutes.help,
            name: 'help',
            icon: Icons.help_outline,
            label: 'Help & Support',
          ),
          RouteInfo(
            path: AppRoutes.about,
            name: 'about',
            icon: Icons.info_outline,
            label: 'About',
          ),
        ];
        
        if (index < allRoutes.length) {
          context.go(allRoutes[index].path);
        }
      },
    );
  }

  Widget _buildBottomNavigationBar(ThemeData theme) {
    final routes = AppRoutesConfig.getRoutesForBottomNav();
    
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: _onBottomNavTapped,
      elevation: 8,
      height: 80,
      destinations: routes.map((route) {
        return NavigationDestination(
          icon: Badge(
            isLabelVisible: route.name == 'tasks' && true, // Show badge for tasks
            label: const Text('5'),
            child: Icon(route.icon),
          ),
          selectedIcon: Icon(route.icon),
          label: route.label,
        );
      }).toList(),
    );
  }

  Widget _buildFloatingActionButton(ThemeData theme) {
    return AnimatedBuilder(
      animation: _fabAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _fabAnimation.value,
          child: FloatingActionButton(
            onPressed: () => _showQuickActionSheet(context),
            tooltip: 'Quick Actions',
            elevation: 8,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _showQuickActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _QuickActionSheet(),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showSearch(
      context: context,
      delegate: StudyFlowSearchDelegate(),
    );
  }
}

class _QuickActionSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Actions',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _QuickActionTile(
                      icon: Icons.note_add,
                      label: 'New Note',
                      onTap: () {
                        Navigator.pop(context);
                        context.go(AppRoutes.noteEditor);
                      },
                    ),
                    _QuickActionTile(
                      icon: Icons.task_alt,
                      label: 'Add Task',
                      onTap: () {
                        Navigator.pop(context);
                        context.go(AppRoutes.tasks);
                      },
                    ),
                    _QuickActionTile(
                      icon: Icons.quiz,
                      label: 'Create Quiz',
                      onTap: () {
                        Navigator.pop(context);
                        context.go(AppRoutes.flashcards);
                      },
                    ),
                    _QuickActionTile(
                      icon: Icons.schedule,
                      label: 'Study Timer',
                      onTap: () {
                        Navigator.pop(context);
                        context.go(AppRoutes.studyPlanner);
                      },
                    ),
                    _QuickActionTile(
                      icon: Icons.document_scanner,
                      label: 'Scan PDF',
                      onTap: () {
                        Navigator.pop(context);
                        context.go(AppRoutes.pdfScanner);
                      },
                    ),
                    _QuickActionTile(
                      icon: Icons.mic,
                      label: 'Voice Note',
                      onTap: () {
                        Navigator.pop(context);
                        context.go(AppRoutes.voiceNotes);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class StudyFlowSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'Search results for "$query"',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Search functionality will be implemented here',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = [
      'My Notes',
      'Today\'s Tasks',
      'Study Schedule',
      'Flashcards',
      'Progress Report',
      'Calendar Events',
    ];

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          leading: const Icon(Icons.history),
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}