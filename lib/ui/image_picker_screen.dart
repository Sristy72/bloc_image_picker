import 'dart:io';

import 'package:bloc_image_picker/bloc/image_bloc.dart';
import 'package:bloc_image_picker/bloc/image_event.dart';
import 'package:bloc_image_picker/bloc/image_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker'),
      ),
      body: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          if(state is ImagePickerLoading){
            return Center(child: CircularProgressIndicator());
          }

          if(state is ImagePickerSuccess){
            return imageView(context, state.image);
          }

          if(state is ImagePickerError){
            return Text(state.errorMsg,);
          }

             return ElevatedButton(onPressed: (){
                showImagePickerOptions(context);
              }, child: Row(
                children: [
                  Icon(Icons.add_a_photo),
                  Text('Select image'),
                ],
              ));
        },
      ),
    );
  }

  void showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take photo'),
                onTap: () {
                  Navigator.pop(context);
                  context.read<ImageBloc>().add(
                    CaptureImageFromCamera()
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Pick from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  context.read<ImageBloc>().add(
                    PickImageFromGallery()
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.close),
                title: Text('cancel'),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ));
        }
    );
  }

  Widget imageView (BuildContext context, File image){
    return Center(
      child: Column(
        children: [
          ClipRRect(
            child: Image.file(image, width: double.infinity, height: 400,),
          ),
          SizedBox(height: 20,),
          Center(
            child: ElevatedButton(onPressed: (){
              showImagePickerOptions(context);
            }, child: Row(
              children: [
                Icon(Icons.edit),
                Text('Change Image'),
              ],
            )),
          ),

          TextButton(onPressed: (){
            context.read().add(RemoveImage());
          }, child: Text('Remove Image'))
        ],
      ),
    );
  }
}
