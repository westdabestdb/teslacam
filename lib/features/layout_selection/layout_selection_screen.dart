import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teslacam/models/layout_option.dart';
import 'package:teslacam/providers/layout_providers.dart';

/// Screen for selecting a layout for the merged video
class LayoutSelectionScreen extends ConsumerWidget {
  /// Creates a new [LayoutSelectionScreen]
  const LayoutSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final allLayouts = ref.watch(allLayoutsProvider);
    final selectedLayout = ref.watch(selectedLayoutProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Layout'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _showHelpDialog(context),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Choose a layout for your videos',
              style: theme.textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: allLayouts.length,
              itemBuilder: (context, index) {
                final layout = allLayouts[index];
                final isSelected = selectedLayout.id == layout.id;
                
                return Card(
                  clipBehavior: Clip.antiAlias,
                  color: isSelected 
                      ? theme.colorScheme.primary.withOpacity(0.05)
                      : null,
                  child: InkWell(
                    onTap: () {
                      ref.read(selectedLayoutProvider.notifier)
                          .setLayout(layout);
                      context.go('/select-videos');
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: _buildLayoutPreview(context, layout),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                layout.name,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: isSelected 
                                      ? theme.colorScheme.primary
                                      : null,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                layout.description,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.grey.shade600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _BottomActionBar(
            onBack: () => context.go('/'),
            onContinue: selectedLayout != null
                ? () => context.go('/select-videos')
                : null,
          ),
        ],
      ),
    );
  }
  
  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Layout Selection Help'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Layout Options:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Grid: Videos arranged in a grid pattern'),
              Text('• Split Screen: Videos side by side or stacked'),
              Text('• Picture-in-Picture: One main video with smaller overlay'),
              Text('• Custom: Special arrangements for specific use cases'),
              SizedBox(height: 16),
              Text(
                'Tips:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Select a layout that matches your needs'),
              Text('• You can add up to 4 videos depending on the layout'),
              Text('• Preview shows how your videos will be arranged'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  Widget _buildLayoutPreview(BuildContext context, LayoutOption layout) {
    final theme = Theme.of(context);
    final backgroundColor = theme.cardColor;
    final placeholderColor = theme.colorScheme.primary;
    final borderColor = Colors.grey.withOpacity(0.1);

    Widget buildCameraPlaceholder({
      required String label,
      double iconSize = 24,
      double? fontSize,
      EdgeInsets? margin,
      double? height,
    }) {
      return Container(
        margin: margin ?? const EdgeInsets.all(1),
        height: height,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: theme.colorScheme.primary.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.videocam_rounded,
                color: placeholderColor.withOpacity(0.5),
                size: iconSize,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: placeholderColor.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  fontSize: fontSize ?? 11,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    }

    Widget buildPreviewContent() {
      switch (layout.type) {
        case LayoutType.frontBack:
          return Column(
            children: [
              Expanded(
                flex: 1,
                child: buildCameraPlaceholder(
                  label: 'FRONT',
                  iconSize: 24,
                ),
              ),
              const SizedBox(height: 2),
              Expanded(
                flex: 1,
                child: buildCameraPlaceholder(
                  label: 'BACK',
                  iconSize: 24,
                ),
              ),
            ],
          );

        case LayoutType.frontSides:
        case LayoutType.backSides:
          final isBack = layout.type == LayoutType.backSides;
          return Column(
            children: [
              Expanded(
                flex: 7,
                child: buildCameraPlaceholder(
                  label: isBack ? 'BACK' : 'FRONT',
                  iconSize: 28,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: buildCameraPlaceholder(
                        label: 'LEFT',
                        iconSize: 16,
                        fontSize: 9,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: buildCameraPlaceholder(
                        label: 'RIGHT',
                        iconSize: 16,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

        case LayoutType.allSides:
          return Column(
            children: [
              Expanded(
                flex: 7,
                child: buildCameraPlaceholder(
                  label: 'FRONT',
                  iconSize: 28,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: buildCameraPlaceholder(
                        label: 'LEFT',
                        iconSize: 14,
                        fontSize: 9,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: buildCameraPlaceholder(
                        label: 'BACK',
                        iconSize: 14,
                        fontSize: 9,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: buildCameraPlaceholder(
                        label: 'RIGHT',
                        iconSize: 14,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

        case LayoutType.pip:
          return Stack(
            children: [
              Positioned.fill(
                child: buildCameraPlaceholder(
                  label: 'MAIN',
                  iconSize: 28,
                  fontSize: 12,
                  margin: EdgeInsets.zero,
                ),
              ),
              Positioned(
                right: 8,
                bottom: 8,
                width: 60,
                height: 36,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.videocam_rounded,
                          color: placeholderColor.withOpacity(0.5),
                          size: 12,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'PIP',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: placeholderColor.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: AspectRatio(
        aspectRatio: layout.type == LayoutType.pip ? 16/9 : 1,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: buildPreviewContent(),
        ),
      ),
    );
  }
}

/// Widget displaying information about the number of videos
class _VideoCountInfo extends StatelessWidget {
  /// The number of videos
  final int videoCount;

  /// Creates a new [_VideoCountInfo]
  const _VideoCountInfo({required this.videoCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.movie,
            color: Colors.grey.shade700,
          ),
          const SizedBox(width: 8),
          Text(
            '$videoCount videos selected',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget displaying a grid of layout options
class _LayoutGrid extends ConsumerWidget {
  /// The available layouts
  final List<LayoutOption> layouts;
  
  /// The currently selected layout
  final LayoutOption selectedLayout;

  /// Creates a new [_LayoutGrid]
  const _LayoutGrid({
    required this.layouts,
    required this.selectedLayout,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: layouts.length,
      itemBuilder: (context, index) {
        final layout = layouts[index];
        final isSelected = layout.id == selectedLayout.id;
        
        return _LayoutCard(
          layout: layout,
          isSelected: isSelected,
          onTap: () {
            ref.read(selectedLayoutProvider.notifier).setLayout(layout);
          },
        );
      },
    );
  }
}

/// Widget displaying a layout option card
class _LayoutCard extends StatelessWidget {
  final LayoutOption layout;
  final bool isSelected;
  final VoidCallback onTap;

  const _LayoutCard({
    required this.layout,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: isSelected
            ? const BorderSide(color: Colors.red, width: 2)
            : BorderSide.none,
      ),
      elevation: isSelected ? 4 : 1,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Layout preview image
            Expanded(
              child: _buildLayoutPreview(context, layout),
            ),
            
            // Layout info
            Container(
              padding: const EdgeInsets.all(12),
              color: isSelected ? Colors.red.shade50 : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    layout.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.red : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    layout.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLayoutPreview(BuildContext context, LayoutOption layout) {
    final theme = Theme.of(context);
    final backgroundColor = theme.cardColor;
    final placeholderColor = theme.colorScheme.primary;
    final borderColor = Colors.grey.withOpacity(0.1);

    Widget buildCameraPlaceholder({
      required String label,
      double iconSize = 24,
      double? fontSize,
      EdgeInsets? margin,
      double? height,
    }) {
      return Container(
        margin: margin ?? const EdgeInsets.all(1),
        height: height,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: theme.colorScheme.primary.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.videocam_rounded,
                color: placeholderColor.withOpacity(0.5),
                size: iconSize,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: placeholderColor.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  fontSize: fontSize ?? 11,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    }

    Widget buildPreviewContent() {
      switch (layout.type) {
        case LayoutType.frontBack:
          return Column(
            children: [
              Expanded(
                flex: 1,
                child: buildCameraPlaceholder(
                  label: 'FRONT',
                  iconSize: 24,
                ),
              ),
              const SizedBox(height: 2),
              Expanded(
                flex: 1,
                child: buildCameraPlaceholder(
                  label: 'BACK',
                  iconSize: 24,
                ),
              ),
            ],
          );

        case LayoutType.frontSides:
        case LayoutType.backSides:
          final isBack = layout.type == LayoutType.backSides;
          return Column(
            children: [
              Expanded(
                flex: 7,
                child: buildCameraPlaceholder(
                  label: isBack ? 'BACK' : 'FRONT',
                  iconSize: 28,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: buildCameraPlaceholder(
                        label: 'LEFT',
                        iconSize: 16,
                        fontSize: 9,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: buildCameraPlaceholder(
                        label: 'RIGHT',
                        iconSize: 16,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

        case LayoutType.allSides:
          return Column(
            children: [
              Expanded(
                flex: 7,
                child: buildCameraPlaceholder(
                  label: 'FRONT',
                  iconSize: 28,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: buildCameraPlaceholder(
                        label: 'LEFT',
                        iconSize: 14,
                        fontSize: 9,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: buildCameraPlaceholder(
                        label: 'BACK',
                        iconSize: 14,
                        fontSize: 9,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: buildCameraPlaceholder(
                        label: 'RIGHT',
                        iconSize: 14,
                        fontSize: 9,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

        case LayoutType.pip:
          return Stack(
            children: [
              Positioned.fill(
                child: buildCameraPlaceholder(
                  label: 'MAIN',
                  iconSize: 28,
                  fontSize: 12,
                  margin: EdgeInsets.zero,
                ),
              ),
              Positioned(
                right: 8,
                bottom: 8,
                width: 60,
                height: 36,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.videocam_rounded,
                          color: placeholderColor.withOpacity(0.5),
                          size: 12,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'PIP',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: placeholderColor.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth;
        return Container(
          width: size,
          height: size * (layout.type == LayoutType.pip ? 9/16 : 1),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor),
          ),
          padding: const EdgeInsets.all(4),
          child: buildPreviewContent(),
        );
      },
    );
  }
}

/// Widget for displaying an empty state
class _EmptyState extends StatelessWidget {
  /// Creates a new [_EmptyState]
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.grid_view,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No layouts available',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select more videos to see available layouts',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Widget for displaying the bottom action bar
class _BottomActionBar extends StatelessWidget {
  /// Callback for going back
  final VoidCallback onBack;
  
  /// Callback for continuing to the next screen
  final VoidCallback? onContinue;

  /// Creates a new [_BottomActionBar]
  const _BottomActionBar({
    required this.onBack,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button
          OutlinedButton.icon(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back'),
          ),
          const Spacer(),
          // Continue button
          if (onContinue != null)
            ElevatedButton(
              onPressed: onContinue,
              child: const Text('Continue'),
            ),
        ],
      ),
    );
  }
} 