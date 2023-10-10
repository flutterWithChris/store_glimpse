import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:store_glimpse/preview/model/app.dart';
import 'package:store_glimpse/preview/repository/preview_repository.dart';

part 'preview_event.dart';
part 'preview_state.dart';

class PreviewBloc extends Bloc<PreviewEvent, PreviewState> {
  final PreviewRepository _previewRepository;
  PreviewBloc({required PreviewRepository previewRepository})
      : _previewRepository = previewRepository,
        super(PreviewInitial(app: App())) {
    on<LoadPreview>((event, emit) async {
      emit(PreviewLoading());
      await emit.forEach(
        _previewRepository.getPreviews(event.userID),
        onData: (data) => PreviewLoaded(app: data.first),
      );
    });
    on<EditPreview>((event, emit) async {
      emit(EditingPreview(app: event.app));
    });
    on<SavePreview>((event, emit) async {
      emit(PreviewLoading());
      await _previewRepository.updatePreview(event.userID, event.app);
      await Future.delayed(const Duration(seconds: 1));
      add(LoadPreview(userID: event.userID));
    });
    on<CreatePreview>((event, emit) async {
      emit(PreviewLoading());
      String appID =
          await _previewRepository.createPreview(event.userID, event.app);
      await Future.wait([
        _previewRepository.uploadAppIcon(
            event.userID, event.app.copyWith(id: appID), event.icon),
        _previewRepository.uploadAppScreenshots(
            event.userID, event.app.copyWith(id: appID), event.screenshots),
      ]);
      add(LoadPreview(userID: event.userID));
    });
    on<UpdatePreview>((event, emit) async {
      emit(PreviewLoading());
      await _previewRepository.updatePreview(event.userID, event.app);
      await Future.delayed(const Duration(seconds: 1));
      add(LoadPreview(userID: event.userID));
    });
    on<DeletePreview>((event, emit) async {
      emit(PreviewLoading());
      await _previewRepository.deletePreview(event.userID, event.app);
      await Future.delayed(const Duration(seconds: 1));
      emit(PreviewInitial(app: App()));
    });
    on<UpdateAppIcon>((event, emit) async {
      emit(PreviewLoading());
      await _previewRepository.deleteAppIcon(event.userID, event.app);
      await _previewRepository.uploadAppIcon(
          event.userID, event.app, event.icon);
      await Future.delayed(const Duration(seconds: 1));
      add(LoadPreview(userID: event.userID));
    });
  }
}
