import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import '../utilities/colors.dart';
import 'custom_title.dart';

   void showCustomToast(BuildContext context,String message,String iconImage,Color backgroundColor) {
     Flushbar flushBar = Flushbar();
     flushBar = Flushbar(
       messageText: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Image.asset(iconImage,scale: 4.0,color: AppColors.c555,),
           const SizedBox(width: 5,),
           Flexible(
             child: CustomTitle(
               text: message,
               fontSize: 16,
               fontWeight: FontWeight.w700,
               color: AppColors.c555,
               textAlign: TextAlign.center,
               maxLines: 2,
               overflow: TextOverflow.ellipsis,
             ),
           ),
         ],
       ),
       borderRadius: BorderRadius.circular(12),
       borderWidth: 0,
       backgroundColor: backgroundColor,
       flushbarPosition: FlushbarPosition.BOTTOM,
       textDirection: TextDirection.rtl,
       margin: const EdgeInsets.only(bottom: 20,),
       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
       duration: const Duration(seconds: 3),
       maxWidth: 350,
     );
     flushBar.show(context);
  }