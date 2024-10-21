import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:menu_dashboard/model/city_model/city_model.dart';
import 'package:menu_dashboard/view_model/add_city_view_model.dart';
import 'package:menu_dashboard/view_model/city_view_model.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_circular_progress_indicator.dart';
import '../../../components/custom_dialog.dart';
import '../../../components/custom_text_filed.dart';
import '../../../components/custom_title.dart';
import '../../../model/employee_model/employee_model.dart';
import '../../../utilities/colors.dart';
import '../../../utilities/constants.dart';
import '../../../utilities/size_utility.dart';
import '../../../view_model/add_employee_view_model.dart';
import '../../../view_model/edit_employee_view_model.dart';
import '../../../view_model/employees_view_model.dart';
import '../../../view_model/general_view_model.dart';

class CityRecord extends StatefulWidget {
  final bool flag;
  const CityRecord({super.key, required this.flag});

  @override
  State<CityRecord> createState() => _CityRecordState();
}

class _CityRecordState extends State<CityRecord> {
  late final cityViewModel = Provider.of<CityViewModel>(context);


  @override
  Widget build(BuildContext context) {



    List<DataRow> getRows() {
      List<CityModel> pageData = cityViewModel.cities;
      return pageData.mapIndexed((index, city) {
        return DataRow(cells: [

          DataCell(
            CustomTitle(
              text: city.name,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c016,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          DataCell(
            CustomTitle(
              text: city.price,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c016,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),

          DataCell(
            Row(
              children: [

                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: cityViewModel.deleting? () {} : () {
                      showCustomDialog(context, content: StatefulBuilder(
                        builder: (context, setState) {
                          return SizedBox(
                            width: 400,
                            height: 205,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.c752.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: AppColors.c555,
                                        borderRadius:
                                        BorderRadius.circular(50)),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color:
                                          AppColors.c752.withOpacity(0.11),
                                          borderRadius:
                                          BorderRadius.circular(50)),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/icons/alert-circle.webp",
                                          scale: 3.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const CustomTitle(
                                  text: "حذف المدينة",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.c016,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const CustomTitle(
                                  text:
                                  "هل أنت متأكد أنك تريد حذف هذه المدينة ؟ لا يمكن التراجع عن هذا الإجراء.",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.c912,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () => Navigator.pop(context),
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                color: AppColors.c555,
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppColors.c565)),
                                            child: const Center(
                                              child: CustomTitle(
                                                text: "إلغاء",
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.c016,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: cityViewModel.deleting
                                              ? () {}
                                              : () async {
                                            await Provider.of<
                                                CityViewModel>(
                                                context,
                                                listen: false)
                                                .deleteCity(
                                              context,
                                              city.id,
                                            );
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(12),
                                                color: AppColors.c4221,
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppColors.c4221)),
                                            child: Center(
                                              child: Provider.of<CityViewModel>(context).deleting
                                                  ? const CustomCircularProgressIndicator(
                                                  iosSize: 30,
                                                  color: AppColors.c555)
                                                  : const CustomTitle(
                                                text: "حذف",
                                                fontSize: 20,
                                                fontWeight:
                                                FontWeight.w700,
                                                color: AppColors.c555,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.c4221.withOpacity(0.1),
                      ),
                      height: 30,
                      width: 30,
                      child: Center(
                        child: Image.asset(
                          "assets/icons/trash.webp",
                          scale: 4.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]);
      }).toList();
    }

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: AppColors.c555),
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10,),
              IconButton(onPressed: (){
                Provider.of<GeneralViewModel>(context,listen: false).updateSelectedIndex(index: HOME_INDEX);
              }, icon: const Icon(Icons.home,color: AppColors.mainColor,size: 20,),),
              const Text('/',style: TextStyle(color: AppColors.mainColor,fontSize: 13),),
              const SizedBox(width: 10,),
              const Text('مدن التوصيل',style: TextStyle(color: Colors.grey,fontSize: 13),),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: widget.flag
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomTitle(
                  text: "سجل مدن التوصيل",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.c016,
                ),
                Row(
                  children: [

                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AddCityViewModel>(context,listen: false).clearData();
                          Provider.of<GeneralViewModel>(context,
                              listen: false)
                              .updateSelectedIndex(index: ADDCITY_INDEX);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.mainColor,
                          ),
                          height: 45,
                          width: 180,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 18,
                                color: AppColors.c555,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomTitle(
                                text: "إضافة مدينة توصيل",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.c555,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTitle(
                  text: "سجل مدن التوصيل",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.c016,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AddCityViewModel>(context,listen: false).clearData();
                          Provider.of<GeneralViewModel>(context,
                              listen: false)
                              .updateSelectedIndex(
                              index: ADDCITY_INDEX);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.mainColor,
                          ),
                          height: 45,
                          width: 180,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 18,
                                color: AppColors.c555,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomTitle(
                                text: "إضافة مدينة توصيل",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.c555,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (widget.flag || cityViewModel.cityEmpty)
            SizedBox(
              width: getSize(context).width,
              child: buildDataTableTheme(getRows),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: buildDataTableTheme(getRows),
            ),
          if (cityViewModel.isCityLoading)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: CustomCircularProgressIndicator(
                  iosSize: 30, color: AppColors.mainColor),
            )

          else if (cityViewModel.cityEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: CustomTitle(
                  text: "لا يوجد مدن توصيل",
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.c912,
                ),
              ),
        ],
      ),
    );
  }



  DataTableTheme buildDataTableTheme(List<DataRow> Function() getRows) {
    return DataTableTheme(
      data: DataTableThemeData(
        headingRowColor: WidgetStateProperty.all(AppColors.c790),
        dataRowColor: WidgetStateProperty.all(AppColors.c555),
        headingTextStyle: const TextStyle(
            color: AppColors.c912,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            fontFamily: stcFontStr),
        dividerThickness: 0,
      ),
      child: DataTable(
        columns: const <DataColumn>[

          DataColumn(
            label: CustomTitle(
              text: "الإسم",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "السعر",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

        ],
        columnSpacing: 20,
        dataRowHeight: 60,
        rows: getRows(),
      ),
    );
  }


}
