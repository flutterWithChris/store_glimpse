part of 'preview_bloc.dart';

@immutable
sealed class PreviewEvent {}

class LoadPreview extends PreviewEvent {
  final App app;
  LoadPreview({required this.app});
}

class EditPreview extends PreviewEvent {
  final App app;
  EditPreview({required this.app});
}

class SavePreview extends PreviewEvent {
  final App app;
  SavePreview({required this.app});
}

class CreatePreview extends PreviewEvent {
  final App app;
  CreatePreview({required this.app});
}

class UpdatePreview extends PreviewEvent {
  final App app;
  UpdatePreview({required this.app});
}

class DeletePreview extends PreviewEvent {
  final App app;
  DeletePreview({required this.app});
}

class UpdateAppIcon extends PreviewEvent {
  final App app;
  final XFile icon;
  UpdateAppIcon({required this.app, required this.icon});
}

class AddScreenshots extends PreviewEvent {
  final App app;
  final List<XFile> screenshots;
  AddScreenshots({required this.app, required this.screenshots});
}

class RemoveScreenshots extends PreviewEvent {
  final App app;
  final List<XFile> screenshots;
  RemoveScreenshots({required this.app, required this.screenshots});
}
