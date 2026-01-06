part of 'single_image_controller_bloc.dart';

@immutable
sealed class SingleImageControllerState {}

final class SingleImageControllerInitial extends SingleImageControllerState {}

class SingleImageLoading extends SingleImageControllerState{}

class SingleImageSuccess extends SingleImageControllerState{
  final PlatformFile imagePath;

  SingleImageSuccess({required this.imagePath});
}

class SingleImageFail extends SingleImageControllerState{
  final String errorMessage;

  SingleImageFail({required this.errorMessage});
}

