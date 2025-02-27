// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'processing_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cancelJobHash() => r'6cba1beab2772f2c267f01356ebf59d4f567d5b8';

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

/// Provider for cancelling a processing job
///
/// Copied from [cancelJob].
@ProviderFor(cancelJob)
const cancelJobProvider = CancelJobFamily();

/// Provider for cancelling a processing job
///
/// Copied from [cancelJob].
class CancelJobFamily extends Family<AsyncValue<bool>> {
  /// Provider for cancelling a processing job
  ///
  /// Copied from [cancelJob].
  const CancelJobFamily();

  /// Provider for cancelling a processing job
  ///
  /// Copied from [cancelJob].
  CancelJobProvider call(
    String jobId,
  ) {
    return CancelJobProvider(
      jobId,
    );
  }

  @override
  CancelJobProvider getProviderOverride(
    covariant CancelJobProvider provider,
  ) {
    return call(
      provider.jobId,
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
  String? get name => r'cancelJobProvider';
}

/// Provider for cancelling a processing job
///
/// Copied from [cancelJob].
class CancelJobProvider extends AutoDisposeFutureProvider<bool> {
  /// Provider for cancelling a processing job
  ///
  /// Copied from [cancelJob].
  CancelJobProvider(
    String jobId,
  ) : this._internal(
          (ref) => cancelJob(
            ref as CancelJobRef,
            jobId,
          ),
          from: cancelJobProvider,
          name: r'cancelJobProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cancelJobHash,
          dependencies: CancelJobFamily._dependencies,
          allTransitiveDependencies: CancelJobFamily._allTransitiveDependencies,
          jobId: jobId,
        );

  CancelJobProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.jobId,
  }) : super.internal();

  final String jobId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(CancelJobRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CancelJobProvider._internal(
        (ref) => create(ref as CancelJobRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        jobId: jobId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _CancelJobProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CancelJobProvider && other.jobId == jobId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, jobId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CancelJobRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `jobId` of this provider.
  String get jobId;
}

class _CancelJobProviderElement extends AutoDisposeFutureProviderElement<bool>
    with CancelJobRef {
  _CancelJobProviderElement(super.provider);

  @override
  String get jobId => (origin as CancelJobProvider).jobId;
}

String _$processingJobsHash() => r'21dc634ca30668259650d068413c579b2aa9343c';

/// Provider for all processing jobs
///
/// Copied from [ProcessingJobs].
@ProviderFor(ProcessingJobs)
final processingJobsProvider =
    AutoDisposeNotifierProvider<ProcessingJobs, List<ProcessingJob>>.internal(
  ProcessingJobs.new,
  name: r'processingJobsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$processingJobsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProcessingJobs = AutoDisposeNotifier<List<ProcessingJob>>;
String _$activeJobHash() => r'a34562001ce822f00303321c916f48f5e7e17408';

/// Provider for the currently active processing job
///
/// Copied from [ActiveJob].
@ProviderFor(ActiveJob)
final activeJobProvider =
    AutoDisposeNotifierProvider<ActiveJob, ProcessingJob?>.internal(
  ActiveJob.new,
  name: r'activeJobProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$activeJobHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ActiveJob = AutoDisposeNotifier<ProcessingJob?>;
String _$processingStateHash() => r'07a310e4b91f3af81a986566b3c966c0c5d19a94';

/// Provider for managing the processing state
///
/// Copied from [ProcessingState].
@ProviderFor(ProcessingState)
final processingStateProvider =
    AutoDisposeAsyncNotifierProvider<ProcessingState, ProcessingJob?>.internal(
  ProcessingState.new,
  name: r'processingStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$processingStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProcessingState = AutoDisposeAsyncNotifier<ProcessingJob?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
