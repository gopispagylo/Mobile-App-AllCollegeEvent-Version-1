part of 'image_controller_bloc.dart';

@immutable
sealed class ImageControllerState {}

final class ImageControllerInitial extends ImageControllerState {}

class ImageMultipleLoading extends ImageControllerState{}

class ImageMultipleSuccess extends ImageControllerState{
  final List<PlatformFile> getMultipleImages;

  ImageMultipleSuccess({required this.getMultipleImages});
}

class ImageMultipleFail extends ImageControllerState{
  final String errorMessage;

  ImageMultipleFail({required this.errorMessage});
}