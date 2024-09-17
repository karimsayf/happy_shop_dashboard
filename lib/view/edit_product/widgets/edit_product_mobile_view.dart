import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_circular_progress_indicator.dart';
import '../../../components/custom_text_filed.dart';
import '../../../components/custom_title.dart';
import '../../../components/upload_file_widget.dart';
import '../../../utilities/colors.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/validator.dart';
import '../../../view_model/edit_product_view_model.dart';
import '../../../view_model/general_view_model.dart';

class EditProductMobileView extends StatefulWidget {
  const EditProductMobileView({super.key});

  @override
  State<EditProductMobileView> createState() => _EditProductMobileViewState();
}

class _EditProductMobileViewState extends State<EditProductMobileView> {
  late final editProductViewModel = Provider.of<EditProductViewModel>(context);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColors.c555),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      child: Form(
        key: editProductViewModel.formKey,
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
                const Text('تعديل منتج',style: TextStyle(color: Colors.grey,fontSize: 13),),
              ],
            ),
            _buildDivider(),
            const Text(
              'تعديل منتج',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            _buildDivider(),
            _buildSection(
              title: 'بيانات المنتج',
              desc: 'قم بتعديل تفاصيل المنتج',
              children: [
                Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                          controller: editProductViewModel.sectionName,
                          generalTextFieldValidator:
                          Validator(context).validateField,
                          readOnly: true,
                          hintText: 'اسم القسم',
                          hintTextColor: AppColors.c912,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: CustomTextField(
                          controller: editProductViewModel.name,
                          generalTextFieldValidator:
                          Validator(context).validateField,
                          hintText: 'اسم المنتج',
                          hintTextColor: AppColors.c912,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                          controller: editProductViewModel.components,
                          generalTextFieldValidator:
                          Validator(context).validateField,
                          hintText: 'المكونات',
                          hintTextColor: AppColors.c912,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: CustomTextField(
                          generalTextFieldValidator:
                          Validator(context).validateNationalId,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          controller: editProductViewModel.price,
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              ' د . ع',
                              style: TextStyle(color: AppColors.c912),
                            ),
                          ),
                          hintText: 'السعر',
                          hintTextColor: AppColors.c912,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                UploadFileWidget(
                  title: "تحميل صورة",
                  file: editProductViewModel.file,
                  networkImage: editProductViewModel.photoNetwork,
                  setFileOnProvider: (file) {
                    setState(() {
                      editProductViewModel.file = file;
                    });
                  },
                ),
              ],
            ),
            _buildDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: editProductViewModel.loading ? (){} :  () async{
                    await Provider.of<EditProductViewModel>(context,listen: false).editProduct(context);
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
                    child: editProductViewModel.loading? const Center(
                      child: CustomCircularProgressIndicator(
                          iosSize: 30,
                          color: AppColors.c555),
                    ) : const Center(
                      child: CustomTitle(
                        text: 'تعديل البيانات',
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
          width: 60,
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