import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teslacam/models/layout_option.dart';

part 'layout_providers.g.dart';

/// Provider for available layout options
@riverpod
List<LayoutOption> availableLayouts(AvailableLayoutsRef ref) {
  return LayoutOptions.all;
}

/// Provider for the currently selected layout
@riverpod
class SelectedLayout extends _$SelectedLayout {
  @override
  LayoutOption build() {
    // Default to front and back layout
    return LayoutOptions.frontBack;
  }
  
  /// Set the selected layout
  void setLayout(LayoutOption layout) {
    state = layout;
  }
  
  /// Get a layout by ID
  LayoutOption? getLayoutById(String layoutId) {
    return LayoutOptions.all.firstWhere(
      (layout) => layout.id == layoutId,
      orElse: () => LayoutOptions.frontBack,
    );
  }
}

/// Provider for custom layouts created by the user
@riverpod
class CustomLayouts extends _$CustomLayouts {
  @override
  List<LayoutOption> build() {
    return [];
  }
  
  /// Add a custom layout
  void addLayout(LayoutOption layout) {
    state = [...state, layout];
  }
  
  /// Remove a custom layout
  void removeLayout(String layoutId) {
    state = state.where((layout) => layout.id != layoutId).toList();
  }
  
  /// Update a custom layout
  void updateLayout(LayoutOption updatedLayout) {
    state = state.map((layout) => 
      layout.id == updatedLayout.id ? updatedLayout : layout
    ).toList();
  }
}

/// Provider for all available layouts (predefined + custom)
@riverpod
List<LayoutOption> allLayouts(AllLayoutsRef ref) {
  final predefinedLayouts = ref.watch(availableLayoutsProvider);
  final customLayouts = ref.watch(customLayoutsProvider);
  
  return [...predefinedLayouts, ...customLayouts];
} 