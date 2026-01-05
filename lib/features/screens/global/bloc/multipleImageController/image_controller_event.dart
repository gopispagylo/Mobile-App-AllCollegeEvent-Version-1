part of 'image_controller_bloc.dart';

@immutable
sealed class ImageControllerEvent {}

class ChooseImagePickerMultiple extends ImageControllerEvent{
  final ImageSource source;

  ChooseImagePickerMultiple({required this.source});
}

class RemoveImageMultiple extends ImageControllerEvent{
  final int index;

  RemoveImageMultiple({required this.index});
}