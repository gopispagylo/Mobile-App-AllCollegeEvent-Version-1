import 'dart:io';

import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'single_image_controller_event.dart';

part 'single_image_controller_state.dart';

class SingleImageControllerBloc
    extends Bloc<SingleImageControllerEvent, SingleImageControllerState> {

  // -------- max size for image (5MB) --------
  final maxSize = 5 * 1024 * 1024;

  PlatformFile? singleImage;

  SingleImageControllerBloc() : super(SingleImageControllerInitial()) {
    on<ChooseImagePickerSingle>((event, emit) async{
      emit(SingleImageLoading());
      try {

        final result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png'],
        );

        if(result == null){
          emit(SingleImageFail(errorMessage: "No image selected"));
          return;
        }

        File imageFile = File(result.files.first.path!);

        final imageSize = await imageFile.length();

        // ----------- image compressor -----------
        if(imageSize > maxSize){

          // -------- decode image bytes -------
          final decodeImage = img.decodeImage(await imageFile.readAsBytes());
          final reSized = img.copyResize(decodeImage!,width: 1080);
          final compressedByte = img.encodeJpg(reSized,quality: 90);
          final compressedPath = imageFile.path.replaceFirst('.jpg', 'compressed.jpg');
          imageFile = await File(compressedPath).writeAsBytes(compressedByte);
        }

        final singleImage = PlatformFile(name: result.files.first.name, size: await imageFile.length(), path: imageFile.path);

        emit(SingleImageSuccess(imagePath: singleImage));

      } on DioException catch (e) {
        final error = HandleErrorConfig().handleDioError(e);
        emit(SingleImageFail(errorMessage: error));

      } catch (e) {
        emit(SingleImageFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });

    // --------- remove image --------
    on<RemoveSingleImage>((event,emit){
      singleImage = null;
      emit(SingleImageControllerInitial());
    });
  }
}
