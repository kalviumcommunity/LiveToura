import 'package:flutter/material.dart';

class ResponsiveHomeScreen extends StatelessWidget {
  const ResponsiveHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Implement Responsiveness with MediaQuery
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    
    // Theme colors
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tournament Tracker Dashboard'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // 3. Apply Flexible and Adaptive Widgets: LayoutBuilder
          if (constraints.maxWidth > 600) {
            // Tablet Layout: Two-column grid / Split view
            return Row(
              children: [
                // Navigation / Sidebar for Tablet
                NavigationRail(
                  selectedIndex: 0,
                  onDestinationSelected: (int index) {},
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.dashboard),
                      label: Text('Dashboard'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.sports_soccer),
                      label: Text('Matches'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.people),
                      label: Text('Players'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                // Main Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeaderSection(context, isTablet: true),
                          const SizedBox(height: 24),
                          _buildTabletGridContent(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Mobile Layout: Single Column
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeaderSection(context, isTablet: false),
                  const SizedBox(height: 16),
                  _buildMobileListContent(),
                ],
              ),
            );
          }
        },
      ),
      // Footer / Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(isTablet ? 'Create Tournament' : 'Add'),
        icon: const Icon(Icons.add),
        backgroundColor: secondaryColor,
      ),
      bottomNavigationBar: isTablet ? null : BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Matches'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // Header Section
  Widget _buildHeaderSection(BuildContext context, {required bool isTablet}) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 32.0 : 16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: isTablet ? BorderRadius.circular(16) : const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back, Organizer!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Manage your live tournaments and track scores in real-time.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onPrimary.withOpacity(0.8),
                ),
          ),
        ],
      ),
    );
  }

  // Mobile Content: List View
  Widget _buildMobileListContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Live Matches',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) => _buildMatchCard(index),
          ),
        ],
      ),
    );
  }

  // Tablet Content: Grid View
  Widget _buildTabletGridContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Live Matches & Stats',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two columns for tablet
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
          ),
          itemCount: 6,
          itemBuilder: (context, index) => _buildMatchCard(index),
        ),
      ],
    );
  }

  // Adaptive Card Widget
  Widget _buildMatchCard(int index) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.sports_soccer, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'Match #${index + 1}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'LIVE',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Team A', style: TextStyle(fontSize: 14)),
                    SizedBox(height: 4),
                    Text('2', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
                Text('VS', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                Column(
                  children: [
                    Text('Team B', style: TextStyle(fontSize: 14)),
                    SizedBox(height: 4),
                    Text('1', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
