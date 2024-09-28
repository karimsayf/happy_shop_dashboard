import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_circular_progress_indicator.dart';
import '../../../components/custom_text_filed.dart';
import '../../../components/custom_title.dart';
import '../../../components/custom_toast.dart';
import '../../../utilities/colors.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/validator.dart';
import '../../../view_model/edit_employee_view_model.dart';
import '../../../view_model/general_view_model.dart';



class EditEmployeeMobileView extends StatefulWidget {
  const EditEmployeeMobileView({super.key});

  @override
  State<EditEmployeeMobileView> createState() => _EditEmployeeMobileViewState();
}

class _EditEmployeeMobileViewState extends State<EditEmployeeMobileView> {
  late final provider = Provider.of<EditEmployeeViewModel>(context);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: AppColors.c555),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        child: Form(
            key: provider.formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      IconButton(onPressed: (){
                        Provider.of<GeneralViewModel>(context,listen: false).updateSelectedIndex(index: HOME_INDEX);
                      }, icon: Icon(Icons.home,color: AppColors.mainColor,size: 20,),),
                      Text('/',style: TextStyle(color: AppColors.mainColor,fontSize: 13),),
                      SizedBox(width: 10,),
                      InkWell(onTap: (){
                        Provider.of<GeneralViewModel>(context,listen: false).updateSelectedIndex(index: EMPLOYEES_INDEX);
                      },child: Text('الموظفين',style: TextStyle(color: AppColors.mainColor,fontSize: 13),)),
                      SizedBox(width: 10,),
                      Text('/',style: TextStyle(color: AppColors.mainColor,fontSize: 13),),
                      SizedBox(width: 10,),
                      Text('تعديل موظف',style: TextStyle(color: Colors.grey,fontSize: 13),),
                    ],
                  ),
                  _buildDivider(),
                  const Text(
                    'تعديل موظف',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  _buildDivider(),
                  _buildSection(
                    title: 'المعلومات الشخصية',
                    desc: 'قم برفع تفاصيلك الشخصية.',
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              CustomTextField(
                                controller: provider.name,
                                generalTextFieldValidator:
                                Validator(context).validateField,
                                hintText: 'الإسم',
                                hintTextColor: AppColors.c912,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                controller: provider.username,
                                generalTextFieldValidator:
                                Validator(context).validateField,
                                hintText: 'اسم المستخدم',
                                hintTextColor: AppColors.c912,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                controller: provider.password,
                                generalTextFieldValidator:
                                Validator(context).validateField,
                                hintText: 'كلمة المرور',
                                hintTextColor: AppColors.c912,
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      _buildDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: provider.loading? () {} : () async {
                              await Provider.of<EditEmployeeViewModel>(context,
                                    listen: false)
                                    .editEmployee(context,);
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.mainColor,
                              ),
                              height: 40,
                              width: 120,
                              child: provider.loading? const Center(
                                child: CustomCircularProgressIndicator(
                                    iosSize: 30,
                                    color: AppColors.c555),
                              ) :  const CustomTitle(
                                text: 'حفظ التغييرات',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )],
                  )])));
  }

  _buildSection(
      {required String title,
        required String desc,
        required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: AppColors.c016, fontSize: 14),
              ),
              Text(
                desc,
                style: const TextStyle(color: AppColors.c223, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: children,
        ),
      ],
    );
  }

  _buildDivider() {
    return const Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Divider(
          color: AppColors.c460,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
