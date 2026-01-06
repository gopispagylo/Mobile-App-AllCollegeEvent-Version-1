part of 'single_image_controller_bloc.dart';

@immutable
sealed class SingleImageControllerEvent {}

class ChooseImagePickerSingle extends SingleImageControllerEvent{
  final ImageSource source;

  ChooseImagePickerSingle({required this.source});
}

class RemoveSingleImage extends SingleImageControllerEvent{}
