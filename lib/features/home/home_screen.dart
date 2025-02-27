import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Home screen of the application
class HomeScreen extends ConsumerWidget {
  /// Creates a new [HomeScreen]
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _HomeAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tesla Dashcam Video Merger',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Merge multiple Tesla dashcam views into a single video with customizable layouts.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildFeatureGrid(theme),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => context.go('/select-layout'),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Start New Project'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildFeatureGrid(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withAlpha(20),
        ),
      ),
      child: Column(
        children: [
          _FeatureItem(
            icon: Icons.videocam_rounded,
            title: 'Tesla Dashcam Support',
            subtitle: 'Front, Back, Left & Right views',
            showDivider: true,
          ),
          _FeatureItem(
            icon: Icons.grid_view_rounded,
            title: 'Tesla-Style Layout',
            subtitle: 'Matches Tesla dashcam viewer',
            showDivider: true,
          ),
          _FeatureItem(
            icon: Icons.high_quality_rounded,
            title: 'High Quality Export',
            subtitle: 'Hardware accelerated H.264',
            showDivider: true,
          ),
          _FeatureItem(
            icon: Icons.sync_rounded,
            title: 'Synchronized Playback',
            subtitle: 'Preview all views in sync',
            showDivider: false,
          ),
        ],
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.large(
      surfaceTintColor: Colors.transparent,
      actions: [
        IconButton(
          onPressed: () => _showHelpDialog(context),
          icon: const Icon(Icons.help_outline_rounded),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About TeslaCam Video Merger'),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This app helps you merge Tesla dashcam footage from multiple cameras into a single video file.',
              ),
              SizedBox(height: 16),
              Text(
                'Features:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Merge up to 4 camera views\n'
                  '• Tesla-style layout support\n'
                  '• Hardware accelerated processing\n'
                  '• Synchronized preview\n'
                  '• High quality export'),
              SizedBox(height: 16),
              Text(
                'Getting Started:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('1. Click "Start New Project"\n'
                  '2. Choose a layout\n'
                  '3. Select your Tesla dashcam videos\n'
                  '4. Preview the merged layout\n'
                  '5. Process and export'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.showDivider,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: showDivider ? Border(
          bottom: BorderSide(
            color: Colors.grey.withAlpha(20),
          ),
        ) : null,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(26),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: theme.colorScheme.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
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