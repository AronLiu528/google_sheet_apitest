import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sheet_apitest/getx_controller.dart';
//import 'package:gsheets/gsheets.dart';

SheetController sheetController = Get.put(SheetController());

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: sheetController.loadSheetData,
                      child: const Text('更新數據'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        final newValue =
                            sheetController.inputNewDataController.text;
                        final row = int.tryParse(
                            sheetController.inputRowController.text)!;
                        final column = int.tryParse(
                            sheetController.inputColumnController.text)!;
                        sheetController.updateSheetData(newValue, row, column);
                        print('newValue = $newValue');
                        print('row = $row');
                        print('column = $column');
                      },
                      child: const Text('保存數據'),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: sheetController.inputRowController,
                        decoration: const InputDecoration(
                          labelText: '列',
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: sheetController.inputColumnController,
                        decoration: const InputDecoration(
                          labelText: '行',
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: sheetController.inputNewDataController,
                  decoration: const InputDecoration(
                    labelText: '修改內容',
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() => Expanded(
                      child: sheetController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: sheetController.sheetData.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      sheetController.sheetData[index]
                                          .join("   |   "),
                                    ),
                                  ),
                                );
                              },
                            ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
