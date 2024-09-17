import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu_dashboard/view_model/add_main_size_view_model.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_circular_progress_indicator.dart';
import '../../../components/custom_text_filed.dart';
import '../../../components/custom_title.dart';
import '../../../components/upload_file_widget.dart';
import '../../../utilities/colors.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/validator.dart';
import '../../../view_model/add_product_view_model.dart';
import '../../../view_model/general_view_model.dart';

class AddMainSizeDesktopView extends StatefulWidget {
  const AddMainSizeDesktopView({super.key});

  @override
  State<AddMainSizeDesktopView> createState() => _AddMainSizeDesktopViewState();
}

class _AddMainSizeDesktopViewState extends State<AddMainSizeDesktopView> {
  late final addMainSizeViewModel = Provider.of<AddMainSizeViewModel>(context);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColors.c555),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      child: Form(
        key: addMainSizeViewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 10,),
                IconButton(onPressed: (){
                  Provider.of<GeneralViewModel>(context,listen: false).updateSelectedIndex(index: HOME_INDEX);
                }, icon: const Icon(Icons.home,color: AppColors.mainColor,size: 20,),),
                const Text('/',style: TextStyle(color: AppColors.mainColor,fontSize: 13),),
                const SizedBox(width: 10,),
                InkWell(onTap: (){
                  Provider.of<GeneralViewModel>(context,listen: false).updateSelectedIndex(index: PRODUCTS_INDEX);
                },child: const Text('المنتجات',style: TextStyle(color: AppColors.mainColor,fontSize: 13),)),
                const SizedBox(width: 10,),
                const Text('/',style: TextStyle(color: AppColors.mainColor,fontSize: 13),),
                const SizedBox(width: 10,),
                const Text('إضافة حجم',style: TextStyle(color: Colors.grey,fontSize: 13),),
              ],
            ),
            _buildDivider(),
            const Text(
              'إضافة حجم',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            _buildDivider(),
            _buildSection(
              title: 'بيانات الحجم',
              desc: 'قم برفع تفاصيل الحجم',
              children: [
                Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                          controller: addMainSizeViewModel.name,
                          generalTextFieldValidator:
                          Validator(context).validateField,
                          hintText: 'الحجم',
                          hintTextColor: AppColors.c912,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ],
            ),
            _buildDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: addMainSizeViewModel.loading ? (){} :  () async{
                    await Provider.of<AddMainSizeViewModel>(context,listen: false).addMainSize(context);
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
                    child: addMainSizeViewModel.loading? const Center(
                      child: CustomCircularProgressIndicator(
                          iosSize: 30,
                          color: AppColors.c555),
                    ) : const Center(
                      child: CustomTitle(
                        text: 'حفظ البيانات',
                        fontSize: 16,
                        color: AppColors.c555,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _buildSection(
      {required String title,
        required String desc,
        required List<Widget> children}) {
    return Row(
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
          width: 60,
        ),
        Expanded(
          child: Column(
            children: children,
          ),
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
