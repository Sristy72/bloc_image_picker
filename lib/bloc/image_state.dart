import 'dart:io';

abstract class ImageState {

}
class ImagePickerInitial extends ImageState{

}
class ImagePickerLoading extends ImageState{

}
class ImagePickerSuccess extends ImageState{
  final File image;
  ImagePickerSuccess({ required this.image});
}
class ImagePickerError extends ImageState{
  final String errorMsg;
  ImagePickerError( this.errorMsg);
}
class ImagePickerRemoved extends ImageState{

}