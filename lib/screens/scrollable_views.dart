import 'package:flutter/material.dart';

/// ScrollableViews - Demonstrate ListView and GridView Widgets
/// 
/// This widget showcases the two essential scrollable widgets in Flutter:
/// - ListView: For displaying scrollable lists of items (vertical & horizontal)
/// - GridView: For displaying items in a grid layout with support for scaling
/// 
/// Both widgets use builder constructors for memory efficiency with large datasets.
class ScrollableViews extends StatefulWidget {
  const ScrollableViews({Key? key}) : super(key: key);

  @override
  State<ScrollableViews> createState() => _ScrollableViewsState();
}

class _ScrollableViewsState extends State<ScrollableViews> {
  // Sample data for dynamic lists
  final List<String> items = List.generate(20, (index) => 'Item ${index + 1}');
  final List<Color> gridColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.blue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scrollable Views - ListView & GridView'),
        elevation: 4,
        backgroundColor: Colors.deepPurple.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ==================== SECTION 1: LISTVIEW BASICS ====================
            _buildSectionHeader(
              context,
              'ListView — Vertical Scrolling Lists',
              'Perfect for displaying feeds, messages, or notifications',
            ),

            // Basic ListView with ListTile
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Example: User Contact List',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Using ListTile widget in a list:',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "ListView(\n  children: [\n    ListTile(\n      leading: Icon(Icons.person),\n      title: Text('User 1'),\n      subtitle: Text('Online'),\n    ),\n  ],\n);",
                        style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Actual ListTile example
            SizedBox(
              height: 180,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  final statuses = ['Online', 'Offline', 'Away'];
                  final statusColors = [Colors.green, Colors.grey, Colors.orange];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple.shade700,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    title: Text('User ${index + 1}'),
                    subtitle: Text(statuses[index]),
                    trailing: CircleAvatar(
                      radius: 8,
                      backgroundColor: statusColors[index],
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tapped User ${index + 1}')),
                      );
                    },
                  );
                },
              ),
            ),

            const Divider(thickness: 2, indent: 16, endIndent: 16, height: 32),

            // ==================== SECTION 2: LISTVIEW.BUILDER ====================
            _buildSectionHeader(
              context,
              'ListView.builder — Efficient Scrolling for Large Lists',
              'Renders only visible items, improving memory efficiency',
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Code Example:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "ListView.builder(\n  itemCount: 10,\n  itemBuilder: (context, index) {\n    return ListTile(\n      leading: CircleAvatar(\n        child: Text('\${index + 1}')\n      ),\n      title: Text('Item \$index'),\n    );\n  },\n);",
                        style: TextStyle(fontSize: 10, fontFamily: 'monospace'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '✨ Why use builder?',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Only renders visible items on screen\n'
                    '• Significant memory savings with 1000+ items\n'
                    '• Smooth scrolling performance\n'
                    '• Lazy loading capability',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            // Demonstration with 10 items using builder
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      border: Border.all(color: Colors.deepPurple.shade200),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple.shade700,
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text('Item ${index + 1}'),
                      subtitle: Text('This is item number ${index + 1}'),
                      trailing: Icon(Icons.arrow_forward, color: Colors.deepPurple.shade700),
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Selected Item ${index + 1}')),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
            const Divider(thickness: 2, indent: 16, endIndent: 16, height: 32),

            // ==================== SECTION 3: HORIZONTAL LISTVIEW ====================
            _buildSectionHeader(
              context,
              'Horizontal ListView — Carousel Scrolling',
              'Swipe left/right to browse through items',
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Example: Product Cards Carousel',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade700,
                ),
              ),
            ),

            Container(
              height: 180,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Container(
                    width: 140,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: Colors.teal[100 * (index + 2)],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.card_giftcard,
                          size: 50,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Card ${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${(index + 1) * 10}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
            const Divider(thickness: 2, indent: 16, endIndent: 16, height: 32),

            // ==================== SECTION 4: GRIDVIEW BASICS ====================
            _buildSectionHeader(
              context,
              'GridView — Displaying Items in Grids',
              'Perfect for image galleries, dashboards, and product catalogs',
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GridView.count — Fixed Column Count',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "GridView.count(\n  crossAxisCount: 2,\n  spacing: 10,\n  children: [...],\n);",
                        style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Basic GridView with 2 columns
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: List.generate(
                  6,
                  (index) => Container(
                    decoration: BoxDecoration(
                      color: gridColors[index % gridColors.length],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: 48,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tile $index',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Divider(thickness: 2, indent: 16, endIndent: 16, height: 32),

            // ==================== SECTION 5: GRIDVIEW.BUILDER ====================
            _buildSectionHeader(
              context,
              'GridView.builder — Efficient Grid for Large Datasets',
              'Optimal for dynamic grids with many items',
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Code Example:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "GridView.builder(\n  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(\n    crossAxisCount: 2,\n  ),\n  itemCount: 8,\n  itemBuilder: (context, index) => Container(),\n);",
                        style: TextStyle(fontSize: 10, fontFamily: 'monospace'),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // GridView.builder with 2 columns
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected Item $index'),
                          duration: const Duration(milliseconds: 800),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: gridColors[index % gridColors.length],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.collections,
                            size: 48,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Item $index',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
            const Divider(thickness: 2, indent: 16, endIndent: 16, height: 32),

            // ==================== SECTION 6: RESPONSIVE GRIDVIEW ====================
            _buildSectionHeader(
              context,
              'Responsive GridView — Adaptive to Screen Size',
              'Dynamically adjust column count based on device width',
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Example: 3-Column Grid on Larger Screens',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade700,
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.2,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tapped Tile $index')),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: gridColors[index % gridColors.length].withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              size: 32,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Tile $index',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
            const Divider(thickness: 2, indent: 16, endIndent: 16, height: 32),

            // ==================== PERFORMANCE TIPS ====================
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.amber.shade700,
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '⚡ Performance Best Practices',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.amber.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '✅ Use .builder constructors for lists with 20+ items\n'
                      '✅ Use NeverScrollableScrollPhysics when ListView/GridView is inside a SingleChildScrollView\n'
                      '✅ Set shrinkWrap: true for widgets that need flexible sizing\n'
                      '✅ Avoid heavy widgets in itemBuilder (e.g., images without caching)\n'
                      '✅ Keep itemBuilder lightweight and stateless when possible\n'
                      '✅ Use const constructors for unchanging widgets',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.amber.shade900,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ==================== LEARNING REFLECTION ====================
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.deepPurple.shade700,
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '✨ Scrollable Views — Complete!',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.deepPurple.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Key Takeaways:',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.deepPurple.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '📱 ListView: Vertical or horizontal scrollable lists\n'
                      '📊 GridView: Multi-column layouts and galleries\n'
                      '⚡ Builder pattern: Efficient rendering of large datasets\n'
                      '📐 Responsive design: Adapt layouts to different screen sizes\n'
                      '🎨 Flutter widgets: Composable, reusable, and performant',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.deepPurple.shade700,
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  /// Helper method to build section headers
  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.deepPurple.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
