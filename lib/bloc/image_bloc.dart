
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'image_event.dart';
import 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImagePicker imagePicker = ImagePicker();

  ImageBloc() : super(ImagePickerInitial()) {
    on<PickImageFromGallery>(_pickImageFromGallery);
    on<CaptureImageFromCamera>(_captureImageFromCamera);
    on<RemoveImage>(_removeImage);
  }
  Future<void> _pickImageFromGallery(
      PickImageFromGallery event,
      Emitter<ImageState> emit
      )async{
    emit(ImagePickerLoading());
    final XFile? pickedImage= await imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      emit(
        ImagePickerSuccess(image:File(pickedImage.path))
      );
    }else{
      emit(ImagePickerInitial());
    }
  }

  Future<void> _captureImageFromCamera(
      CaptureImageFromCamera event,
      Emitter<ImageState> emit
      )async{
    emit(ImagePickerLoading());
    final XFile? pickedImage= await imagePicker.pickImage(source: ImageSource.camera);
    if(pickedImage != null){
      emit(
        ImagePickerSuccess(image:File(pickedImage.path))
      );
    }else{
      emit(ImagePickerInitial());
    }
  }

  Future<void> _removeImage(
      RemoveImage event,
      Emitter<ImageState> emit
      )async{
    emit(ImagePickerRemoved());
  }
}
