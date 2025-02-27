import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teslacam/models/processing_job.dart';

/// Home screen of the application
class HomeScreen extends ConsumerWidget {
  /// Creates a new [HomeScreen]
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final processingJobs = <ProcessingJob>[];
    final activeJobs = <ProcessingJob>[];
    final completedJobs = <ProcessingJob>[];
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('TeslaCam'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Video Merger',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Merge multiple video views into a single video with customizable layouts.',
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
          if (activeJobs.isNotEmpty) ...[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Active Jobs',
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildJobCard(
                    context,
                    activeJobs[index],
                    theme,
                  ),
                  childCount: activeJobs.length,
                ),
              ),
            ),
          ],
          if (completedJobs.isNotEmpty) ...[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Completed Jobs',
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildJobCard(
                    context,
                    completedJobs[index],
                    theme,
                  ),
                  childCount: completedJobs.length,
                ),
              ),
            ),
          ],
          if (processingJobs.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Text(
                  'No processing jobs yet.\nStart a new project!',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade500,
                  ),
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
          _buildFeatureItem(
            theme,
            Icons.videocam_rounded,
            'Multiple Views',
            'Support for up to 4 camera views',
            true,
          ),
          _buildFeatureItem(
            theme,
            Icons.grid_view_rounded,
            'Custom Layouts',
            'Grid, PiP, and Tesla dashcam layouts',
            true,
          ),
          _buildFeatureItem(
            theme,
            Icons.high_quality_rounded,
            'High Quality',
            'Export in high quality H.264',
            false,
          ),
        ],
      ),
    );
  }
  
  Widget _buildFeatureItem(
    ThemeData theme,
    IconData icon,
    String title,
    String subtitle,
    bool showDivider,
  ) {
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
  
  Widget _buildJobCard(BuildContext context, ProcessingJob job, ThemeData theme) {
    final isActive = job.status == ProcessingStatus.processing || 
                     job.status == ProcessingStatus.queued;
    final isCompleted = job.status == ProcessingStatus.completed;
    final progress = job.progress;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          if (isActive) {
            context.go('/processing');
          } else if (isCompleted && job.outputPath != null) {
            // Open video details
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isActive
                          ? theme.colorScheme.primary.withAlpha(26)
                          : Colors.grey.withAlpha(51),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      isActive ? Icons.sync_rounded : Icons.movie_rounded,
                      color: isActive
                          ? theme.colorScheme.primary
                          : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Job ${job.id.substring(0, 8)}',
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _formatDate(job.createdAt),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isActive)
                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.grey.shade400,
                    ),
                ],
              ),
              if (isActive) ...[
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress / 100,
                    backgroundColor: theme.colorScheme.primary.withAlpha(26),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.primary,
                    ),
                    minHeight: 4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$progress%',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              if (isCompleted && job.outputPath != null) ...[
                const SizedBox(height: 12),
                Text(
                  'Output: ${job.outputPath}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
} 