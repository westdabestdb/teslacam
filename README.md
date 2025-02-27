# TeslaCam Video Merger

A Flutter application for merging multiple video views (like Tesla dashcam footage) into a single video with customizable layouts.

## Features

- Upload up to 4 views of the same video
- Merge videos with different layout options:
  - Grid layout (2x2)
  - Split screen (horizontal or vertical)
  - Picture-in-Picture
  - Custom layouts (Tesla dashcam style)
- Synchronized video controls across all views
- Support for multiple video groups
- Preview merged layout before processing
- Export merged videos in high quality

## Screenshots

(Screenshots will be added once the app is fully implemented)

## Getting Started

### Prerequisites

- Flutter SDK (3.6.0 or higher)
- Dart SDK (3.0.0 or higher)
- FFmpeg installed on your system (for development)

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/teslacam.git
   cd teslacam
   ```

2. Install dependencies:
   ```
   flutter pub get
   ```

3. Run code generation for Freezed, Riverpod, and JSON serialization:
   ```
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Run the app:
   ```
   flutter run
   ```

## Project Structure

- `lib/features/` - Feature-based modules
  - `home/` - Home screen
  - `video_selection/` - Video selection screen
  - `layout_selection/` - Layout selection screen
  - `preview/` - Preview screen
  - `processing/` - Processing screen
- `lib/models/` - Data models
  - `video_file.dart` - Video file model
  - `layout_option.dart` - Layout option model
  - `processing_job.dart` - Processing job model
- `lib/providers/` - Riverpod providers
  - `video_providers.dart` - Video selection providers
  - `layout_providers.dart` - Layout selection providers
  - `processing_providers.dart` - Processing job providers
- `lib/services/` - Service classes
  - `ffmpeg_service.dart` - FFmpeg video processing service

## Usage

1. Launch the app
2. Select up to 4 video files from your device
3. Organize videos into groups if needed
4. Choose a layout for merging the videos
5. Preview the layout with synchronized playback
6. Process the videos to create a merged output
7. Share or save the merged video

## Dependencies

- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) - State management
- [go_router](https://pub.dev/packages/go_router) - Navigation and routing
- [video_player](https://pub.dev/packages/video_player) - Video playback
- [file_picker](https://pub.dev/packages/file_picker) - File selection
- [ffmpeg_kit_flutter](https://pub.dev/packages/ffmpeg_kit_flutter) - Video processing
- [freezed](https://pub.dev/packages/freezed) - Immutable state classes
- [hooks_riverpod](https://pub.dev/packages/hooks_riverpod) - Flutter Hooks with Riverpod

## Platform Support

- iOS
- Android
- macOS
- Windows
- Linux (limited testing)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [FFmpeg](https://ffmpeg.org/) for video processing capabilities
- [Tesla](https://www.tesla.com/) for the inspiration with their dashcam system
