// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ffmpegServiceHash() => r'a83899f79c40aae4e85d6ebe31a86fe24c643e3c';

/// Provider for the FFmpeg service
///
/// Copied from [ffmpegService].
@ProviderFor(ffmpegService)
final ffmpegServiceProvider = AutoDisposeProvider<FFmpegService>.internal(
  ffmpegService,
  name: r'ffmpegServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ffmpegServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FfmpegServiceRef = AutoDisposeProviderRef<FFmpegService>;
String _$videoMetadataHash() => r'f8077815b37f1f56221dc05b115c4ba936077709';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for video metadata loading
///
/// Copied from [videoMetadata].
@ProviderFor(videoMetadata)
const videoMetadataProvider = VideoMetadataFamily();

/// Provider for video metadata loading
///
/// Copied from [videoMetadata].
class VideoMetadataFamily extends Family<AsyncValue<VideoFile>> {
  /// Provider for video metadata loading
  ///
  /// Copied from [videoMetadata].
  const VideoMetadataFamily();

  /// Provider for video metadata loading
  ///
  /// Copied from [videoMetadata].
  VideoMetadataProvider call(
    VideoFile video,
  ) {
    return VideoMetadataProvider(
      video,
    );
  }

  @override
  VideoMetadataProvider getProviderOverride(
    covariant VideoMetadataProvider provider,
  ) {
    return call(
      provider.video,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'videoMetadataProvider';
}

/// Provider for video metadata loading
///
/// Copied from [videoMetadata].
class VideoMetadataProvider extends AutoDisposeFutureProvider<VideoFile> {
  /// Provider for video metadata loading
  ///
  /// Copied from [videoMetadata].
  VideoMetadataProvider(
    VideoFile video,
  ) : this._internal(
          (ref) => videoMetadata(
            ref as VideoMetadataRef,
            video,
          ),
          from: videoMetadataProvider,
          name: r'videoMetadataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$videoMetadataHash,
          dependencies: VideoMetadataFamily._dependencies,
          allTransitiveDependencies:
              VideoMetadataFamily._allTransitiveDependencies,
          video: video,
        );

  VideoMetadataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.video,
  }) : super.internal();

  final VideoFile video;

  @override
  Override overrideWith(
    FutureOr<VideoFile> Function(VideoMetadataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: VideoMetadataProvider._internal(
        (ref) => create(ref as VideoMetadataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        video: video,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<VideoFile> createElement() {
    return _VideoMetadataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VideoMetadataProvider && other.video == video;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, video.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin VideoMetadataRef on AutoDisposeFutureProviderRef<VideoFile> {
  /// The parameter `video` of this provider.
  VideoFile get video;
}

class _VideoMetadataProviderElement
    extends AutoDisposeFutureProviderElement<VideoFile> with VideoMetadataRef {
  _VideoMetadataProviderElement(super.provider);

  @override
  VideoFile get video => (origin as VideoMetadataProvider).video;
}

String _$selectedVideosHash() => r'194ee19f4a4b401a92a44906477114b6b252d577';

/// Provider for selected videos
///
/// Copied from [SelectedVideos].
@ProviderFor(SelectedVideos)
final selectedVideosProvider =
    AutoDisposeNotifierProvider<SelectedVideos, List<VideoFile>>.internal(
  SelectedVideos.new,
  name: r'selectedVideosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedVideosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedVideos = AutoDisposeNotifier<List<VideoFile>>;
String _$videoGroupsHash() => r'd7d8b5aa97aef0b8e8e37b74d48c922a7ee41c4e';

/// Provider for video groups
///
/// Copied from [VideoGroups].
@ProviderFor(VideoGroups)
final videoGroupsProvider =
    AutoDisposeNotifierProvider<VideoGroups, List<String>>.internal(
  VideoGroups.new,
  name: r'videoGroupsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$videoGroupsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$VideoGroups = AutoDisposeNotifier<List<String>>;
String _$selectedGroupHash() => r'd52866a63403ebe00bebfeb09cec7bedeb83d2ee';

/// Provider for the currently selected group
///
/// Copied from [SelectedGroup].
@ProviderFor(SelectedGroup)
final selectedGroupProvider =
    AutoDisposeNotifierProvider<SelectedGroup, String>.internal(
  SelectedGroup.new,
  name: r'selectedGroupProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedGroupHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedGroup = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
