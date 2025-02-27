# Flutter Multi-View Video Merger App - To-Do List

## 1. Project Setup and Dependencies
- [x] **Update pubspec.yaml with required dependencies**
  - `video_player`: For video playback functionality
  - `file_picker`: For selecting video files
  - `path_provider`: For file system access
  - `ffmpeg_kit_flutter`: For video processing and merging
  - `riverpod`: For state management
  - `freezed`: For immutable state classes
  - `go_router`: For navigation
  - `flutter_hooks`: For simplified state management in widgets
  - `hooks_riverpod`: For combining hooks with Riverpod
  - `uuid`: For generating unique identifiers
  - `equatable`: For equality comparisons
  - `json_annotation`: For JSON serialization
  - `flutter_ffmpeg`: Alternative FFmpeg library if needed
- [ ] **Configure build settings for different platforms**
  - Android: Update AndroidManifest.xml for storage permissions
  - iOS: Update Info.plist for photo library access
  - macOS/Windows/Linux: Configure for desktop support

## 2. Project Structure
- [x] **Create folder structure**
  - `lib/features/`: Feature-based modules
  - `lib/core/`: Core utilities and shared components
  - `lib/models/`: Data models
  - `lib/providers/`: Riverpod providers
  - `lib/services/`: Service classes for video processing
  - `lib/widgets/`: Reusable UI components

## 3. User Interface (UI)
- [x] **Design the main screen**
  - Layout for uploading/selecting video files
  - Display thumbnails or previews for up to 4 video views
  - Implement responsive design for different screen sizes
- [x] **Build a frame layout selector**
  - Options for selecting alignment (e.g., grid, custom positions)
  - Allow user to add more frames (e.g., multiple sets of front-back-left-right)
  - Create visual representation of layout options
- [x] **Implement video control widgets**
  - Play, pause, seek, and timeline controls
  - Global controls that affect all video views simultaneously
  - Volume controls and mute options
- [x] **Create a preview screen**
  - Display the merged video preview
  - Options to adjust alignment before exporting
  - Export quality settings

## 4. Video Upload and Processing
- [x] **Implement video file selection**
  - Use file picker for selecting multiple video files
  - Add drag-and-drop support for desktop platforms
  - Implement thumbnail generation for selected videos
- [x] **Develop video merging logic**
  - Create FFmpeg command generator for different layouts
  - Support different alignments: grid, split-screen, and custom
  - Handle edge cases (e.g., different video dimensions or frame rates)
- [x] **Integrate video processing library**
  - Set up FFmpeg processing via a Flutter plugin
  - Create progress indicators for processing tasks
  - Implement error handling for failed processing

## 5. State Management
- [x] **Define data models**
  - Create `VideoFile` model with metadata
  - Create `LayoutOption` model for different layouts
  - Create `ProcessingJob` model for tracking merge operations
- [x] **Implement Riverpod providers**
  - Create providers for video selection state
  - Create providers for layout selection
  - Create providers for processing state and progress
- [x] **Develop global video control logic**
  - Ensure play/pause/seek actions are applied to all views
  - Synchronize playback across multiple video views
  - Handle buffering and loading states

## 6. Adding and Managing Additional Frames
- [x] **Dynamic Frame Management**
  - Enable adding/removing sets of views
  - Create UI for organizing multiple frame groups
  - Update processing logic to handle variable numbers of inputs
- [x] **UI/UX for custom frame ordering**
  - Implement drag-and-drop for reordering frames
  - Create visual indicators for frame relationships
  - Save and load custom layouts

## 7. Video Processing Service
- [x] **Create FFmpeg service**
  - Implement methods for different merge operations
  - Create utility functions for video format conversion
  - Add support for adding timestamps or labels to videos
- [x] **Implement background processing**
  - Run video operations in background isolates
  - Create notification system for long-running tasks
  - Add cancellation support for processing jobs

## 8. Testing and Optimization
- [ ] **Write unit tests**
  - Test video processing logic
  - Test state management
  - Test UI components
- [ ] **Performance Optimization**
  - Optimize video loading and playback
  - Minimize memory usage during processing
  - Implement caching for processed videos
- [ ] **Error handling**
  - Create comprehensive error handling for video processing
  - Implement retry mechanisms for failed operations
  - Add logging for debugging

## 9. Deployment and Distribution
- [ ] **Prepare for release**
  - Configure app icons and splash screens
  - Create release builds for different platforms
  - Write user documentation

## Current Progress
- [x] Initial project setup
- [x] Dependencies configuration
- [x] Basic UI implementation
- [x] Data models implementation
- [x] State management implementation
- [x] Video processing service implementation
- [x] Navigation and routing
- [ ] Platform-specific configurations
- [ ] Testing and optimization
- [ ] Deployment preparation

## Known Issues
- Code generation needs to be run to resolve import errors
- Platform-specific configurations for file access are not yet implemented
- Video processing may be slow on lower-end devices
- UI may need adjustments for different screen sizes
- The app currently has linter errors that will be resolved after running code generation

## Next Steps
1. Run `./generate.sh` or `flutter pub run build_runner build --delete-conflicting-outputs` to generate code for Freezed, Riverpod, and JSON serialization
2. Configure platform-specific settings for file access permissions
3. Test the app on different platforms
4. Optimize performance and fix any bugs
5. Prepare for release

## Development Notes
- The models and providers have been implemented with Freezed and Riverpod annotations
- The UI screens have been created with proper navigation flow
- The FFmpeg service has been implemented for video processing
- The app structure follows a feature-based organization
- After running code generation, the linter errors related to missing generated files will be resolved