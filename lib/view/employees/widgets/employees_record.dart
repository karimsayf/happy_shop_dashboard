import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
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

class EmployeesRecord extends StatefulWidget {
  final bool flag;
  const EmployeesRecord({super.key, required this.flag});

  @override
  State<EmployeesRecord> createState() => _EmployeesRecordState();
}

class _EmployeesRecordState extends State<EmployeesRecord> {
  late final employeesViewModel = Provider.of<EmployeesViewModel>(context);


  @override
  Widget build(BuildContext context) {
    int totalRows = employeesViewModel.totalEmployees;
    int totalPages = (totalRows / employeesViewModel.rowsPerPage).ceil();

    void handlePrevious() {
      setState(() {
        employeesViewModel.currentPage--;
        employeesViewModel.firstNum = employeesViewModel.firstNum - 10;
        employeesViewModel.lastNum = employeesViewModel.lastNum - 10;
      });
      if (employeesViewModel.searchQuery.isNotEmpty) {
        Provider.of<EmployeesViewModel>(context, listen: false).searchEmployees(
            context,
            employeesViewModel.searchQuery,
            employeesViewModel.currentPage.toString(),false);
      } else {
        Provider.of<EmployeesViewModel>(context, listen: false)
            .getEmployees(context, employeesViewModel.currentPage.toString(),false);
      }
    }

    void handleNext() {
      setState(() {
        employeesViewModel.currentPage++;
        employeesViewModel.firstNum = employeesViewModel.firstNum + 10;
        employeesViewModel.lastNum = employeesViewModel.lastNum + 10;
      });
      if (employeesViewModel.searchQuery.isNotEmpty) {
        Provider.of<EmployeesViewModel>(context, listen: false).searchEmployees(
            context,
            employeesViewModel.searchQuery,
            employeesViewModel.currentPage.toString(),false);
      } else {
        Provider.of<EmployeesViewModel>(context, listen: false)
            .getEmployees(context, employeesViewModel.currentPage.toString(),false);
      }
    }

    List<DataRow> getRows() {
      List<EmployeeModel> pageData = employeesViewModel.employees;
      return pageData.mapIndexed((index, employee) {
        return DataRow(cells: [
          DataCell(CustomTitle(
            text: (employeesViewModel.firstNum + index).toString(),
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.c016,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
          DataCell(
            CustomTitle(
              text: employee.name,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c016,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          DataCell(
            CustomTitle(
              text: employee.username,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c016,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const DataCell(
            CustomTitle(
              text: "******",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c016,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          DataCell(
            Container(
             height: 30,
             width: 60,
             decoration: BoxDecoration(
               color: employee.status == "ACTIVE" ? AppColors.c368.withOpacity(0.1) : AppColors.c869.withOpacity(0.1),
               borderRadius: BorderRadius.circular(50),
               border: Border.all(width: 1,color: employee.status == "ACTIVE" ? AppColors.c368 : AppColors.c869)
             ),
             child: Center(
               child: CustomTitle(
                 text: employee.status == "ACTIVE" ? "نشط" : "معلق",
                 fontSize: 14,
                 fontWeight: FontWeight.w400,
                 color: employee.status == "ACTIVE" ? AppColors.c368 : AppColors.c869,
                 maxLines: 2,
                 overflow: TextOverflow.ellipsis,
               ),
             ),
            )
          ),
          DataCell(
            Row(
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<EditEmployeeViewModel>(context,listen: false).clearData();
                      Provider.of<EditEmployeeViewModel>(context,listen: false).assignData(employee);
                      Provider.of<GeneralViewModel>(context,listen: false).updateSelectedIndex(index: EDITEMPLOYEE_INDEX);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.c074.withOpacity(0.1),
                      ),
                      height: 30,
                      width: 30,
                      child: Center(
                        child: Image.asset(
                          "assets/icons/edit-2.webp",
                          scale: 4.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Tooltip(
                    message: employee.status == "ACTIVE" ? "تعليق الموظف" : "إلغاء تعليق الموظيف",
                    enableTapToDismiss: true,
                    textAlign: TextAlign.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.c555,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.c016.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    preferBelow: false,
                    textStyle: const TextStyle(
                        fontFamily: stcFontStr,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.c244),
                    child: GestureDetector(
                      onTap: employeesViewModel.updatingStatus? () {} : employee.status == "ACTIVE" ? (){
                        showCustomDialog(context, content: StatefulBuilder(
                          builder: (context, setState) {
                            return SizedBox(
                              width: 400,
                              height: 185,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.c599.withOpacity(0.1),
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
                                            AppColors.c599.withOpacity(0.11),
                                            borderRadius:
                                            BorderRadius.circular(50)),
                                        child: Center(
                                          child: Image.asset(
                                            "assets/icons/profile-delete.webp",
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
                                    text: "تعليق الموظف",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.c016,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const CustomTitle(
                                    text:
                                    "هل أنت متأكد أنك تريد تعليق هذا الموظف ؟",
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
                                            onTap: employeesViewModel.updatingStatus
                                                ? () {}
                                                : () async {
                                              await Provider.of<
                                                  EmployeesViewModel>(
                                                  context,
                                                  listen: false)
                                                  .updateEmployeeStatus(
                                                context,
                                                employee.id,
                                                  "INACTIVE"
                                              );
                                            },
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                  color: AppColors.mainColor,
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppColors.mainColor)),
                                              child: Center(
                                                child: Provider.of<EmployeesViewModel>(context).updatingStatus
                                                    ? const CustomCircularProgressIndicator(
                                                    iosSize: 30,
                                                    color: AppColors.c555)
                                                    : const CustomTitle(
                                                  text: "تعليق",
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
                      } : () {
                        showCustomDialog(context, content: StatefulBuilder(
                          builder: (context, setState) {
                            return SizedBox(
                              width: 400,
                              height: 185,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.c368.withOpacity(0.1),
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
                                            AppColors.c368.withOpacity(0.11),
                                            borderRadius:
                                            BorderRadius.circular(50)),
                                        child: Center(
                                          child: Image.asset(
                                            "assets/icons/profile-tick.webp",
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
                                    text: "إلغاء تعليق الموظيف",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.c016,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const CustomTitle(
                                    text:
                                    "هل أنت متأكد أنك تريد إلغاء تعليق هذا الموظف ؟",
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
                                            onTap: employeesViewModel.updatingStatus
                                                ? () {}
                                                : () async {
                                              await Provider.of<
                                                  EmployeesViewModel>(
                                                  context,
                                                  listen: false)
                                                  .updateEmployeeStatus(
                                                  context,
                                                  employee.id,
                                                  "ACTIVE"
                                              );
                                            },
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                  color: AppColors.mainColor,
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppColors.mainColor)),
                                              child: Center(
                                                child: Provider.of<EmployeesViewModel>(context).updatingStatus
                                                    ? const CustomCircularProgressIndicator(
                                                    iosSize: 30,
                                                    color: AppColors.c555)
                                                    : const CustomTitle(
                                                  text: "تنشيط",
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
                          color: employee.status == "ACTIVE" ? AppColors.c599.withOpacity(0.1) : AppColors.c368.withOpacity(0.1),
                        ),
                        height: 30,
                        width: 30,
                        child: Center(
                          child:  Image.asset(
                            employee.status == "ACTIVE" ? "assets/icons/profile-delete.webp" : "assets/icons/profile-tick.webp",
                            scale: 4.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: employeesViewModel.deleting? () {} : () {
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
                                  text: "حذف الموظف",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.c016,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const CustomTitle(
                                  text:
                                  "هل أنت متأكد أنك تريد حذف هذا الموظف ؟ لا يمكن التراجع عن هذا الإجراء.",
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
                                          onTap: employeesViewModel.deleting
                                              ? () {}
                                              : () async {
                                            await Provider.of<
                                                EmployeesViewModel>(
                                                context,
                                                listen: false)
                                                .deleteEmployee(
                                              context,
                                              employee.id,
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
                                              child: Provider.of<EmployeesViewModel>(context).deleting
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
              const Text('الموظفين',style: TextStyle(color: Colors.grey,fontSize: 13),),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: widget.flag
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomTitle(
                  text: "سجل الموظفين",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.c016,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: getSize(context).width * 0.3,
                      child: CustomTextField(
                        controller: employeesViewModel.searchController,
                        hintText: 'بحث',
                        hintTextColor: AppColors.c912,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 14),
                        fillColor: AppColors.c991,
                        keyboardType: TextInputType.number,
                        focusBorderColor: Colors.transparent,
                        borderColor: Colors.transparent,
                        suffixIcon: employeesViewModel
                            .searchQuery.isNotEmpty
                            ? Padding(
                          padding: const EdgeInsetsDirectional.only(
                              end: 5),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  employeesViewModel
                                      .searchController
                                      .clear();
                                  employeesViewModel.searchQuery =
                                  "";
                                });
                                Provider.of<EmployeesViewModel>(
                                    context,
                                    listen: false)
                                    .getEmployees(context, "0",true);
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 25,
                                color: AppColors.c912,
                              )),
                        )
                            : null,
                        prefixIcon: SizedBox(
                          width: 40,
                          child: Container(
                            margin: const EdgeInsetsDirectional.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.mainColor,
                            ),
                            child: Center(
                              child: Image.asset(
                                "assets/icons/search-normal.webp",
                                scale: 3.5,
                              ),
                            ),
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            employeesViewModel.searchQuery = val;
                          });
                          if (employeesViewModel.searchQuery.isNotEmpty) {
                            Provider.of<EmployeesViewModel>(context,
                                listen: false)
                                .searchEmployees(context,
                                employeesViewModel.searchQuery, "0",false);
                          } else {
                            Provider.of<EmployeesViewModel>(context,
                                listen: false)
                                .getEmployees(context, "0",true);
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AddEmployeeViewModel>(context,listen: false).clearData();
                          Provider.of<GeneralViewModel>(context,
                              listen: false)
                              .updateSelectedIndex(index: ADDEMPLOYEE_INDEX);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.mainColor,
                          ),
                          height: 45,
                          width: 120,
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
                                text: "إضافة موظف",
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
                  text: "سجل الموظفين",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.c016,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: employeesViewModel.searchController,
                        hintText: 'بحث',
                        hintTextColor: AppColors.c912,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 14),
                        fillColor: AppColors.c991,
                        keyboardType: TextInputType.number,
                        focusBorderColor: Colors.transparent,
                        borderColor: Colors.transparent,
                        suffixIcon: employeesViewModel
                            .searchQuery.isNotEmpty
                            ? Padding(
                          padding: const EdgeInsetsDirectional.only(
                              end: 5),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  employeesViewModel
                                      .searchController
                                      .clear();
                                  employeesViewModel.searchQuery =
                                  "";
                                });
                                Provider.of<EmployeesViewModel>(
                                    context,
                                    listen: false)
                                    .getEmployees(context, "0",true);
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 25,
                                color: AppColors.c912,
                              )),
                        )
                            : null,
                        prefixIcon: SizedBox(
                          width: 40,
                          child: Container(
                            margin: const EdgeInsetsDirectional.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.mainColor,
                            ),
                            child: Center(
                              child: Image.asset(
                                "assets/icons/search-normal.webp",
                                scale: 3.5,
                              ),
                            ),
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            employeesViewModel.searchQuery = val;
                          });
                          if (employeesViewModel.searchQuery.isNotEmpty) {
                            Provider.of<EmployeesViewModel>(context,
                                listen: false)
                                .searchEmployees(context,
                                employeesViewModel.searchQuery, "0",false);
                          } else {
                            Provider.of<EmployeesViewModel>(context,
                                listen: false)
                                .getEmployees(context, "0",true);
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AddEmployeeViewModel>(context,listen: false).clearData();
                          Provider.of<GeneralViewModel>(context,
                              listen: false)
                              .updateSelectedIndex(
                              index: ADDEMPLOYEE_INDEX);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.mainColor,
                          ),
                          height: 45,
                          width: 120,
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
                                text: "إضافة موظف",
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
          if (widget.flag || employeesViewModel.employeesEmpty)
            SizedBox(
              width: getSize(context).width,
              child: buildDataTableTheme(getRows),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: buildDataTableTheme(getRows),
            ),
          if (employeesViewModel.isEmployeesLoading)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: CustomCircularProgressIndicator(
                  iosSize: 30, color: AppColors.mainColor),
            )
          else if (!employeesViewModel.employeesEmpty)
            Padding(
              padding:
              const EdgeInsetsDirectional.only(start: 20, end: 15, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "عرض ",
                      style: const TextStyle(
                          fontFamily: stcFontStr,
                          color: AppColors.c912,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                          text: "${employeesViewModel.firstNum}",
                          style: const TextStyle(
                              fontFamily: stcFontStr,
                              fontWeight: FontWeight.w500,
                              color: AppColors.c016,
                              fontSize: 14),
                        ),
                        const TextSpan(
                          text: " - ",
                          style: TextStyle(
                              fontFamily: stcFontStr,
                              fontWeight: FontWeight.w500,
                              color: AppColors.c016,
                              fontSize: 14),
                        ),
                        TextSpan(
                          text: "${employeesViewModel.lastNum}",
                          style: const TextStyle(
                              fontFamily: stcFontStr,
                              fontWeight: FontWeight.w500,
                              color: AppColors.c016,
                              fontSize: 14),
                        ),
                        const TextSpan(
                          text: " من ",
                          style: TextStyle(
                              fontFamily: stcFontStr,
                              fontWeight: FontWeight.w500,
                              color: AppColors.c912,
                              fontSize: 14),
                        ),
                        TextSpan(
                          text: "$totalRows",
                          style: const TextStyle(
                              fontFamily: stcFontStr,
                              fontWeight: FontWeight.w500,
                              color: AppColors.c016,
                              fontSize: 14),
                        ),
                        const TextSpan(
                          text: " نتيجة",
                          style: TextStyle(
                              fontFamily: stcFontStr,
                              fontWeight: FontWeight.w500,
                              color: AppColors.c912,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: employeesViewModel.currentPage > 0
                              ? handlePrevious
                              : null,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 25,
                              color: AppColors.c912,
                            ),
                          ),
                        ),
                      ),
                      if (totalPages <=
                          3) // If total pages are less than or equal to 3, display all page numbers
                        for (int i = 0; i < totalPages; i++)
                          buildPaginationButton(i, (value) {
                            if (value) {
                              setState(() {
                                employeesViewModel.firstNum =
                                    employeesViewModel.currentPage * 10 + 1;
                                employeesViewModel.lastNum =
                                    (employeesViewModel.currentPage + 1) * 10;
                              });
                            }
                          }),
                      if (totalPages > 3)
                        ...buildPaginationButtons(totalPages, (value) {
                          if (value) {
                            setState(() {
                              employeesViewModel.firstNum =
                                  employeesViewModel.currentPage * 10 + 1;
                              employeesViewModel.lastNum =
                                  (employeesViewModel.currentPage + 1) * 10;
                            });
                          }
                        }),
                      const SizedBox(
                        width: 10,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: employeesViewModel.currentPage < totalPages - 1
                              ? handleNext
                              : null,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(12)),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 25,
                              color: AppColors.c912,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          else if (employeesViewModel.employeesEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: CustomTitle(
                  text: "لا يوجد موظفين",
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
              text: "#",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
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
              text: "إسم المستخدم",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "كلمة المرور",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: "الحالة",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.c912,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          DataColumn(
            label: CustomTitle(
              text: " ",
              fontSize: 14,
              fontWeight: FontWeight.w500,
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

  List<Widget> buildPaginationButtons(
      int totalPages, Function(bool) callBackFunction) {
    List<Widget> buttons = [];
    int start = (employeesViewModel.currentPage ~/ 3) * 3;
    int end = (start + 3).clamp(0, totalPages);
    for (int i = start; i < end; i++) {
      buttons.add(buildPaginationButton(i, (value) {
        if (value) {
          setState(() {
            callBackFunction(value);
          });
        }
      }));
    }

    return buttons;
  }

  Widget buildPaginationButton(
      int pageNumber, Function(bool) callBackFunction) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (employeesViewModel.currentPage != pageNumber) {
            Provider.of<EmployeesViewModel>(context, listen: false)
                .setPage(pageNumber);
            callBackFunction(true);
            if (employeesViewModel.searchQuery.isNotEmpty) {
              Provider.of<EmployeesViewModel>(context, listen: false)
                  .searchEmployees(context, employeesViewModel.searchQuery,
                  employeesViewModel.currentPage.toString(),false);
            } else {
              Provider.of<EmployeesViewModel>(context, listen: false)
                  .getEmployees(
                  context, employeesViewModel.currentPage.toString(),false);
            }
          }
        },
        child: Container(
          width: 40,
          height: 40,
          margin: const EdgeInsetsDirectional.only(start: 10),
          padding: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              color: employeesViewModel.currentPage == pageNumber
                  ? AppColors.mainColor.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: CustomTitle(
              text: (pageNumber + 1).toString(),
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: employeesViewModel.currentPage == pageNumber
                  ? AppColors.mainColor
                  : AppColors.c912,
            ),
          ),
        ),
      ),
    );
  }


}
