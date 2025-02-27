// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$availableLayoutsHash() => r'710a613c9e460275c25b744cfeabfd216164eb09';

/// Provider for available layout options
///
/// Copied from [availableLayouts].
@ProviderFor(availableLayouts)
final availableLayoutsProvider =
    AutoDisposeProvider<List<LayoutOption>>.internal(
  availableLayouts,
  name: r'availableLayoutsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$availableLayoutsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AvailableLayoutsRef = AutoDisposeProviderRef<List<LayoutOption>>;
String _$allLayoutsHash() => r'6b377caa5bf32971461b93c7387303b3ea42abfa';

/// Provider for all available layouts (predefined + custom)
///
/// Copied from [allLayouts].
@ProviderFor(allLayouts)
final allLayoutsProvider = AutoDisposeProvider<List<LayoutOption>>.internal(
  allLayouts,
  name: r'allLayoutsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allLayoutsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllLayoutsRef = AutoDisposeProviderRef<List<LayoutOption>>;
String _$selectedLayoutHash() => r'e0d4aef2a5b5d9896350c124a7984ee6975301e1';

/// Provider for the currently selected layout
///
/// Copied from [SelectedLayout].
@ProviderFor(SelectedLayout)
final selectedLayoutProvider =
    AutoDisposeNotifierProvider<SelectedLayout, LayoutOption>.internal(
  SelectedLayout.new,
  name: r'selectedLayoutProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedLayoutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedLayout = AutoDisposeNotifier<LayoutOption>;
String _$customLayoutsHash() => r'68789d608ead3db44ff8cb0810e2ecf505d524d6';

/// Provider for custom layouts created by the user
///
/// Copied from [CustomLayouts].
@ProviderFor(CustomLayouts)
final customLayoutsProvider =
    AutoDisposeNotifierProvider<CustomLayouts, List<LayoutOption>>.internal(
  CustomLayouts.new,
  name: r'customLayoutsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customLayoutsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CustomLayouts = AutoDisposeNotifier<List<LayoutOption>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
