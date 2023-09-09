import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:store_glimpse/preview/model/app.dart';

part 'preview_event.dart';
part 'preview_state.dart';

class PreviewBloc extends Bloc<PreviewEvent, PreviewState> {
  PreviewBloc() : super(PreviewInitial()) {
    on<LoadPreview>((event, emit) async {
      emit(PreviewLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(PreviewLoaded(app: event.app));
    });
    on<EditPreview>((event, emit) async {
      emit(EditingPreview(app: event.app));
    });
    on<SavePreview>((event, emit) async {
      emit(PreviewLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(PreviewLoaded(app: event.app));
    });
    on<CreatePreview>((event, emit) async {
      emit(PreviewLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(PreviewLoaded(app: event.app));
    });
    on<UpdatePreview>((event, emit) async {
      emit(PreviewLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(PreviewLoaded(app: event.app));
    });
    on<DeletePreview>((event, emit) async {
      emit(PreviewLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(PreviewLoaded(app: event.app));
    });
    on<UpdateAppIcon>((event, emit) async {
      emit(PreviewLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(PreviewLoaded(app: event.app));
    });
  }
}
