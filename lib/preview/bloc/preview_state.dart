part of 'preview_bloc.dart';

@immutable
sealed class PreviewState extends Equatable {
  final App? app;
  const PreviewState({this.app});

  @override
  // TODO: implement props
  List<Object?> get props => [app];
}

final class PreviewInitial extends PreviewState {}

class PreviewLoading extends PreviewState {}

class PreviewLoaded extends PreviewState {
  @override
  final App app;
  const PreviewLoaded({required this.app});
  @override
  // TODO: implement props
  List<Object?> get props => [app];
}

class PreviewError extends PreviewState {}

class EditingPreview extends PreviewState {
  @override
  final App app;
  const EditingPreview({required this.app});
  @override
  // TODO: implement props
  List<Object?> get props => [app];
}
