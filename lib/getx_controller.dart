import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sheet_apitest/sheet_service.dart';
import 'package:gsheets/gsheets.dart';

class SheetController extends GetxController {
  var inputRowController = TextEditingController();
  var inputColumnController = TextEditingController();
  var inputNewDataController = TextEditingController();

  final SheetService sheetService = SheetService();
  final RxList<List<dynamic>> sheetData = <List<dynamic>>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    print('start');
    initSheetService();
  }

  void initSheetService() async {
    isLoading.value = true;
    print('開始初始化 SheetService');
    await sheetService.loadEnvAndInitialize();
    print('SheetService 初始化完成');
    loadSheetData();
  }

  void loadSheetData() async {
    print('2');
    try {
      final data = await sheetService.loadData();
      sheetData.value = data;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('Error loading data: $e');
    }
  }

  void updateSheetData(dynamic newValue, int row, int column) async {
    isLoading.value = true;
    try {
      await sheetService.updateData(newValue, row, column);
      loadSheetData(); 
    } catch (e) {
      isLoading.value = false;
      print('Error updating data: $e');
    }
  }

}
