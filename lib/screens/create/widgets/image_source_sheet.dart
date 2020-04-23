import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {

  final Function(File) onImageSelected;

  ImageSourceSheet(this.onImageSelected);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {}, 
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FlatButton(
            onPressed: () => _pickImage(ImageSource.camera), 
            child: Text("Camera")
          ),
          FlatButton(
            onPressed: () => _pickImage(ImageSource.gallery), 
            child: Text("Galeria")
          ),
        ],
      ),
    );
  }

  void _pickImage(ImageSource source) async {
    final File image = await ImagePicker.pickImage(source: source);
    this.onImageSelected(image);
  }

}