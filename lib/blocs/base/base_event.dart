part of 'base_bloc.dart';

@immutable
abstract class BaseEvent extends Equatable {
  const BaseEvent();
}

class GetListEvent extends BaseEvent {
  const GetListEvent({
    required this.skipCount,
    required this.maxResultCount,
    this.isRefresh = false,
    this.isInitial = false,
  });
  final int skipCount;
  final int maxResultCount;
  final bool isRefresh;
  final bool isInitial;

  @override
  List<Object?> get props => [skipCount, maxResultCount, isRefresh, isInitial];
}

class DownloadEvent extends BaseEvent {
  const DownloadEvent({
    required this.filePath,
  });
  final String filePath;

  @override
  List<Object?> get props => [filePath];
}
