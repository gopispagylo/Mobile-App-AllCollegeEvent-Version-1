import 'dart:io';

import 'package:all_college_event_app/data/handleErrorConfig/HandleErrorConfig.dart';
import 'package:all_college_event_app/utlis/configMessage/ConfigMessage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:image/image.dart' as img;


part 'image_controller_event.dart';
part 'image_controller_state.dart';

class ImageControllerBloc extends Bloc<ImageControllerEvent, ImageControllerState> {

  // ---------- initial save a multiple images -------
  final List<PlatformFile> getMultipleImages = [];

  // -------- max size for image (5MB) --------
  final maxSize = 5 * 1024 * 1024;

  // ------------ only 4 images allow the list -------------
  final maxImages = 4;

  ImageControllerBloc() : super(ImageControllerInitial()) {
    on<ChooseImagePickerMultiple>((event, emit) async{
      emit(ImageMultipleLoading());
      try{

        final remainingSlots = maxImages - getMultipleImages.length;


        // ---------- suppose you add a 5 images then show a error like below ------------
        if (remainingSlots <= 0) {
          emit(ImageMultipleFail(errorMessage: "You can only select up to 4 images"));
          return;
        }

        // -------- file picker conditions ----------
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png'],
          allowMultiple: true,
        );

        // ------ when the images is null --------
        if(result == null){
          emit(ImageMultipleSuccess(getMultipleImages: getMultipleImages));
          return;
        }

        final selectedFiles = result.files.take(remainingSlots);

        for(final file in selectedFiles){

          var imageFile = File(file.path!);

          final imageSize = await imageFile.length();

          // ------- image compressor in less then 5 mb -------
          if(imageSize > maxSize){

            final decodeImage = img.decodeImage(await imageFile.readAsBytes());

            if(decodeImage != null){

              final resized = img.copyResize(decodeImage,width: 1080);

              // ------- compressor file change the image size ------
              final compressorByte = img.encodeJpg(
                resized,
                quality: 90
              );

              // ------- compressor file name changed ------
              final compressedPath = imageFile.path.replaceFirst('.jpg', 'compressed.jpg');

              imageFile = await File(compressedPath).writeAsBytes(compressorByte);

            }
          }

          // ------- add a compressor image into a list ------
          getMultipleImages.add(
            PlatformFile(name: file.name, size: await imageFile.length(), path: imageFile.path)
          );
        }
        
        emit(ImageMultipleSuccess(getMultipleImages: getMultipleImages));

      }on DioException catch(e){
        final error = HandleErrorConfig().handleDioError(e);
        emit(ImageMultipleFail(errorMessage: error));
      }
      catch(e){
        emit(ImageMultipleFail(errorMessage: ConfigMessage().unexpectedErrorMsg));
      }
    });

    on<RemoveImageMultiple>((event,emit) async{
      if(event.index >= 0 && event.index < getMultipleImages.length){
        getMultipleImages.removeAt(event.index);
      }
      emit(ImageMultipleSuccess(getMultipleImages: getMultipleImages));
    });
  }
}
