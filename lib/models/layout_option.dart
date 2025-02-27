import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'layout_option.freezed.dart';
part 'layout_option.g.dart';

/// Enum representing different types of layouts
enum LayoutType {
  /// Front and back layout
  @JsonValue(0)
  frontBack,
  
  /// Front with sides layout
  @JsonValue(1)
  frontSides,
  
  /// Back with sides layout
  @JsonValue(2)
  backSides,
  
  /// All sides layout (Tesla style)
  @JsonValue(3)
  allSides,
  
  /// Picture-in-picture layout
  @JsonValue(4)
  pip,
}

/// Represents a layout configuration for video arrangement
@freezed
class LayoutOption with _$LayoutOption {
  const LayoutOption._();

  /// Creates a new [LayoutOption]
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory LayoutOption({
    /// Unique identifier for the layout
    required String id,
    
    /// Name of the layout (e.g., "Front & Back", "All Sides")
    required String name,
    
    /// Description of the layout
    required String description,
    
    /// Layout type
    required LayoutType type,
    
    /// Maximum number of videos this layout supports
    @Default(4) int videoCount,
    
    /// Minimum number of videos required for this layout
    @Default(2) int minVideoCount,
    
    /// Preview image path for this layout
    String? thumbnailPath,
    
    /// Custom configuration for the layout (JSON serializable)
    Map<String, dynamic>? customConfig,
  }) = _LayoutOption;

  /// Converts a LayoutOption to JSON
  factory LayoutOption.fromJson(Map<String, dynamic> json) => 
      _$LayoutOptionFromJson(json);
}

/// Utility class for predefined layout options
class LayoutOptions {
  /// All predefined layout options
  static List<LayoutOption> get all => [
    frontBack,
    frontSides,
    backSides,
    allSides,
    pip,
  ];
  
  /// Front and back layout
  static const LayoutOption frontBack = LayoutOption(
    id: 'front_back',
    name: 'Front & Back Only',
    description: 'Front camera on top (1280x720), back camera on bottom (1280x720)',
    type: LayoutType.frontBack,
    videoCount: 2,
    minVideoCount: 2,
    customConfig: {
      'positions': [
        {'x': 0, 'y': 0, 'width': 1.0, 'height': 0.5}, // Front
        {'x': 0, 'y': 0.5, 'width': 1.0, 'height': 0.5}, // Back
      ],
      'spacing': 2.0,
      'borderRadius': 4.0,
      'borderWidth': 1.0,
      'borderColor': 0x33FFFFFF,
    },
  );
  
  /// Front with sides layout (Tesla style with 3 cameras)
  static const LayoutOption frontSides = LayoutOption(
    id: 'front_sides',
    name: 'Front with Left & Right (Tesla Style)',
    description: 'Front camera on top (1280x720), left and right cameras on bottom (640x360 each)',
    type: LayoutType.frontSides,
    videoCount: 3,
    minVideoCount: 3,
    customConfig: {
      'positions': [
        {'x': 0, 'y': 0, 'width': 1.0, 'height': 0.7}, // Front
        {'x': 0, 'y': 0.7, 'width': 0.5, 'height': 0.3}, // Left
        {'x': 0.5, 'y': 0.7, 'width': 0.5, 'height': 0.3}, // Right
      ],
      'spacing': 2.0,
      'borderRadius': 4.0,
      'borderWidth': 1.0,
      'borderColor': 0x33FFFFFF,
    },
  );
  
  /// Back with sides layout
  static const LayoutOption backSides = LayoutOption(
    id: 'back_sides',
    name: 'Back with Left & Right',
    description: 'Back camera on top (1280x720), left and right cameras on bottom (640x360 each)',
    type: LayoutType.backSides,
    videoCount: 3,
    minVideoCount: 3,
    customConfig: {
      'positions': [
        {'x': 0, 'y': 0, 'width': 1.0, 'height': 0.7}, // Back
        {'x': 0, 'y': 0.7, 'width': 0.5, 'height': 0.3}, // Left
        {'x': 0.5, 'y': 0.7, 'width': 0.5, 'height': 0.3}, // Right
      ],
      'spacing': 2.0,
      'borderRadius': 4.0,
      'borderWidth': 1.0,
      'borderColor': 0x33FFFFFF,
    },
  );
  
  /// All sides layout (Tesla style)
  static const LayoutOption allSides = LayoutOption(
    id: 'all_sides',
    name: 'All Four Cameras (Tesla Style)',
    description: 'Front camera on top (1280x720), left, back, and right cameras on bottom (426x240 each)',
    type: LayoutType.allSides,
    videoCount: 4,
    minVideoCount: 4,
    customConfig: {
      'positions': [
        {'x': 0, 'y': 0, 'width': 1.0, 'height': 0.7}, // Front
        {'x': 0, 'y': 0.7, 'width': 0.33, 'height': 0.3}, // Left
        {'x': 0.33, 'y': 0.7, 'width': 0.34, 'height': 0.3}, // Back
        {'x': 0.67, 'y': 0.7, 'width': 0.33, 'height': 0.3}, // Right
      ],
      'spacing': 2.0,
      'borderRadius': 4.0,
      'borderWidth': 1.0,
      'borderColor': 0x33FFFFFF,
    },
  );
  
  /// Picture-in-picture layout
  static const LayoutOption pip = LayoutOption(
    id: 'pip',
    name: 'Picture-in-Picture',
    description: 'Main video (1280x720) with smaller overlay (384x216)',
    type: LayoutType.pip,
    videoCount: 2,
    minVideoCount: 2,
    customConfig: {
      'mainVideoIndex': 0,
      'pipScale': 0.3,
      'pipPosition': {'x': 0.05, 'y': 0.05, 'width': 0.3, 'height': 0.3},
      'pipBorderRadius': 8.0,
      'pipBorderWidth': 2.0,
      'pipBorderColor': 0xFFFFFFFF,
    },
  );
} 