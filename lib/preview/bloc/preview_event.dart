part of 'preview_bloc.dart';

@immutable
sealed class PreviewEvent {}

class LoadPreview extends PreviewEvent {
  final String userID;
  LoadPreview({required this.userID});
}

class EditPreview extends PreviewEvent {
  final String userID;
  final App app;
  EditPreview({required this.userID, required this.app});
}

class SavePreview extends PreviewEvent {
  final String userID;
  final App app;
  SavePreview({required this.userID, required this.app});
}

class CreatePreview extends PreviewEvent {
  final String userID;
  final App app;
  final List<XFile> screenshots;
  final XFile icon;

  CreatePreview(
      {required this.userID,
      required this.app,
      required this.screenshots,
      required this.icon});
}

class UpdatePreview extends PreviewEvent {
  final String userID;
  final App app;
  UpdatePreview({required this.userID, required this.app});
}

class DeletePreview extends PreviewEvent {
  final String userID;
  final App app;
  DeletePreview({required this.userID, required this.app});
}

class UpdateAppIcon extends PreviewEvent {
  final String userID;
  final App app;
  final XFile icon;
  UpdateAppIcon({required this.userID, required this.app, required this.icon});
}

class AddScreenshots extends PreviewEvent {
  final String userID;
  final App app;
  final List<XFile> screenshots;
  AddScreenshots(
      {required this.userID, required this.app, required this.screenshots});
}

class RemoveScreenshots extends PreviewEvent {
  final String userID;
  final App app;
  final List<XFile> screenshots;
  RemoveScreenshots(
      {required this.userID, required this.app, required this.screenshots});
}
