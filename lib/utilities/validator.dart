import 'package:flutter/cupertino.dart';

class Validator {
  BuildContext context;

  Validator(this.context);

   String? validatePhoneNumber(String? value){
    if(value == null || value.isEmpty){
      return 'يجب إدخال رقم الهاتف';
    }else if(value.length < 11 || value.length > 11){
      return 'يجب أن يتكون رقم الهاتف من ١١ رقم';
    }else if(int.tryParse(value) == null){
      return 'يجب أن يكون أرقامًا فقط';
    }else if(!value.startsWith('0')){
      return 'رقم الهاتف يجب أن يبدأ ب 0';
    }else{
      return null;
    }
  }

   String? validateField(String? value){
    if(value == null || value.isEmpty){
      return 'يجب أن لا يكون هذا الحقل فارغ';
    }else{
      return null;
    }
  }

  String? validateField_(String? value){
    if(value == null || value.isEmpty){
      return 'هذا الحقل فارغ';
    }else{
      return null;
    }
  }

   String? validateNationalId(String? value){
    if(value == null || value.isEmpty){
      return 'يجب أن لا يكون هذا الحقل فارغ';
    }else if(int.tryParse(value) == null){
      return 'يجب أن يكون أرقامًا فقط';
    }else{
      return null;
    }
  }

}
