
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../utilities/colors.dart';
import '../utilities/constants.dart';
import '../utilities/size_utility.dart';
import 'custom_form_field.dart';
import 'image_source_dialog.dart';

class UploadFileWidget extends StatefulWidget {
  final String title;
  String? networkImage;
   PlatformFile? file;
   Function(PlatformFile file) setFileOnProvider;
   UploadFileWidget({super.key,required this.title,required this.file,required this.setFileOnProvider, this.networkImage});

  @override
  State<UploadFileWidget> createState() => _UploadFileWidgetState();
}

class _UploadFileWidgetState extends State<UploadFileWidget> {

  @override
  Widget build(BuildContext context) {
    return widget.file != null ? Container(
      width: getSize(context).width,
      height: 130,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.contain,
          image: MemoryImage(widget.file!.bytes!)
        )
      ),
      child: IconButton(onPressed: (){
        setState(() {
          widget.file = null;
        });
      },icon: Icon(Icons.delete_outline,color: Colors.red.shade700,),),
    ) : widget.networkImage != null ? Container(
      width: getSize(context).width,
      height: 130,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage('$baseUrl/uploads/${widget.networkImage}')
          )
      ),
      child: IconButton(onPressed: (){
        setState(() {
          widget.networkImage = null;
        });
      },icon: Icon(Icons.delete_outline,color: Colors.red.shade700,),),
    ) : CustomContainerFormField(
     initialValue: widget.file?.path??"",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'لا يمكن ترك الصورة بشكل فارغ';
        }
        return null;
      },
      builder: (field) => GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => ImageSourceDialog(
              callBack: (pickedImg) async{
                setState(() {
                  widget.file = pickedImg;
                });
                widget.setFileOnProvider(pickedImg);
              },
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: field.hasError ? Colors.red : AppColors.c460),
          ),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Image.asset('assets/icons/upload.webp',width: 40,height: 40,),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.title,style: const TextStyle(fontSize: 12,color: AppColors.c074),),
                  const SizedBox(width: 4,),
                  const Text('أو قم بالسحب والإفلات',style: TextStyle(fontSize: 12,color: AppColors.c223),)
                ],
              ),
              const SizedBox(height: 5,),
              const Text('SVG, PNG, JPG or GIF (max. 800x400px)',style: TextStyle(fontSize: 10,color: AppColors.c223),)
              ,if(field.hasError)
                Text(field.errorText??"",style: TextStyle(color: Colors.red.shade700,fontSize: 12),)
            ],
          ),),
      ),
    );
  }
}
