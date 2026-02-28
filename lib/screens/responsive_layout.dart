import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;

    debugPrint('📱 Screen Size: ${screenWidth.toStringAsFixed(0)} x ${screenHeight.toStringAsFixed(0)}');
    debugPrint('Device Type: ${isMobile ? "Mobile" : isTablet ? "Tablet" : "Desktop"}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Layout Design'),
        elevation: 4,
        backgroundColor: Colors.deepBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(isMobile ? 12 : isTablet ? 16 : 20),
          child: Column(
            children: [
              // ==================== Header Section ====================
              Container(
                width: double.infinity,
                height: isMobile ? 120 : 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepBlue, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.dashboard,
                      size: isMobile ? 40 : 50,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Responsive Dashboard',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Adapts to ${isMobile ? "Mobile" : isTablet ? "Tablet" : "Desktop"}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: isMobile ? 12 : 16),

              // ==================== Screen Info Row ====================
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.cyan, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoChip(
                      context,
                      label: 'Width',
                      value: '${screenWidth.toStringAsFixed(0)}px',
                      icon: Icons.width_normal,
                    ),
                    _buildInfoChip(
                      context,
                      label: 'Height',
                      value: '${screenHeight.toStringAsFixed(0)}px',
                      icon: Icons.height,
                    ),
                    _buildInfoChip(
                      context,
                      label: 'Type',
                      value: isMobile ? 'Mobile' : isTablet ? 'Tablet' : 'Desktop',
                      icon: isMobile ? Icons.smartphone : isTablet ? Icons.tablet : Icons.monitor,
                    ),
                  ],
                ),
              ),
              SizedBox(height: isMobile ? 12 : 16),

              // ==================== Main Content Area ====================
              if (isMobile) ...[
                // Mobile Layout: Stack Vertically
                _buildMobileLayout(context),
              ] else if (isTablet) ...[
                // Tablet Layout: Two-Column with wrap
                _buildTabletLayout(context),
              ] else ...[
                // Desktop Layout: Three-Column
                _buildDesktopLayout(context),
              ],

              SizedBox(height: isMobile ? 12 : 16),

              // ==================== Feature Showcase ====================
              _buildFeatureShowcase(context, isMobile, isTablet),

              SizedBox(height: isMobile ? 12 : 16),

              // ==================== Footer ====================
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(isMobile ? 12 : 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      'Layout Information',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isMobile
                          ? '📱 Mobile: Single-column layout, stacked vertically'
                          : isTablet
                              ? '📱 Tablet: Two-column adaptive layout'
                              : '🖥️ Desktop: Three-column layout for optimal space usage',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== Mobile Layout ====================
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        // Card 1
        _buildResponseCard(
          context,
          title: 'Feature 1: Responsive',
          description: 'This layout adapts to your screen size automatically.',
          color: Colors.blue,
          icon: Icons.responsive_layout,
        ),
        const SizedBox(height: 12),

        // Card 2
        _buildResponseCard(
          context,
          title: 'Feature 2: Flexible',
          description: 'Uses Expanded and Flexible widgets for smart sizing.',
          color: Colors.green,
          icon: Icons.auto_awesome,
        ),
        const SizedBox(height: 12),

        // Card 3
        _buildResponseCard(
          context,
          title: 'Feature 3: Scalable',
          description: 'Works on phones, tablets, and desktops seamlessly.',
          color: Colors.orange,
          icon: Icons.scale,
        ),
      ],
    );
  }

  // ==================== Tablet Layout ====================
  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildResponseCard(
                context,
                title: 'Feature 1',
                description: 'Responsive Design',
                color: Colors.blue,
                icon: Icons.responsive_layout,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildResponseCard(
                context,
                title: 'Feature 2',
                description: 'Flexible Widgets',
                color: Colors.green,
                icon: Icons.auto_awesome,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildResponseCard(
          context,
          title: 'Feature 3: Scalable Architecture',
          description: 'This layout adapts perfectly between mobile and desktop experiences.',
          color: Colors.orange,
          icon: Icons.scale,
        ),
      ],
    );
  }

  // ==================== Desktop Layout ====================
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildResponseCard(
            context,
            title: 'Feature 1',
            description: 'Responsive\nDesign',
            color: Colors.blue,
            icon: Icons.responsive_layout,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildResponseCard(
            context,
            title: 'Feature 2',
            description: 'Flexible\nWidgets',
            color: Colors.green,
            icon: Icons.auto_awesome,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildResponseCard(
            context,
            title: 'Feature 3',
            description: 'Scalable\nArchitecture',
            color: Colors.orange,
            icon: Icons.scale,
          ),
        ),
      ],
    );
  }

  // ==================== Card Builder ====================
  Widget _buildResponseCard(
    BuildContext context, {
    required String title,
    required String description,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: color,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ==================== Info Chip Builder ====================
  Widget _buildInfoChip(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24, color: Colors.cyan),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade900,
              ),
        ),
      ],
    );
  }

  // ==================== Feature Showcase ====================
  Widget _buildFeatureShowcase(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.withOpacity(0.5), width: 1),
      ),
      child: Column(
        children: [
          Text(
            '✨ Layout Techniques Used',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade700,
                ),
          ),
          const SizedBox(height: 12),
          _buildTechniqueTile(
            context,
            '📊 MediaQuery',
            'Detects screen dimensions and device type',
          ),
          const SizedBox(height: 8),
          _buildTechniqueTile(
            context,
            '📦 Container',
            'Groups content with padding, color, and decoration',
          ),
          const SizedBox(height: 8),
          _buildTechniqueTile(
            context,
            '➡️ Row',
            'Arranges widgets horizontally with spacing',
          ),
          const SizedBox(height: 8),
          _buildTechniqueTile(
            context,
            '⬇️ Column',
            'Stacks widgets vertically with alignment',
          ),
          const SizedBox(height: 8),
          _buildTechniqueTile(
            context,
            '🔄 Expanded',
            'Makes children fill available space proportionally',
          ),
        ],
      ),
    );
  }

  Widget _buildTechniqueTile(
    BuildContext context,
    String title,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
