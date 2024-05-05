import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sheet_apitest/getx_controller.dart';
import 'package:gsheets/gsheets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _credentials = r'''
  {
   "type": "service_account",
   "project_id": "peak-monument-421811",
   "private_key_id": "3e45271c52df14d4e6207537e978e82dae7837e7",
   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCpnobm7kvlHRq1\nOZipDIQi7Qg6aSRFIqUw/Ne0v6CaDN1BkUI9r06sDuau8G5Z0WucqGa2rIYvW+Sk\nyASF7iAvkF0a1Z1XkCO38whXB52jiYA+7sn0AdJiLgStWX/CHP+1sRIRZY63JQqE\nRtK1/gEnXbspQmibcv8n9SwJpBH/40aNo9XCIEoJh5YaEYrtDZoeHrse5d6KxYWT\ngavK6cWZFsiv4zWvwKXs3l9XwWzTGfAp6oEGxmgKKFJd6zBeYhdGy4HPujHbBMNF\n/b0kPq2q67Nv6PZpYhNv6hcd8EXQeH3TK+fZd/fnOakxzyb0cep/THuAHTv9lF7S\nXv5pWJMHAgMBAAECggEARCNZv/UkaeKaMwjzKZ3Mixc7QfOwzVEQmTBJGuQMCTZ3\nv3ox6QO+j+Hgi5AsVEqLd0AzGtkNgoLgw81R+9df+Jt+u2PqtB1ELAYmaIe3rNV0\nvlNAr5P3xtcDq/uTFhB+LKf4QSLSBQKNSfwFc3SZVA4UPIvf5+p3U77qtOjDDk6/\nEuHonF0jMYu0dx+DvqC8RHmfz3F3IEzvCiFBO7Uu/yy3X/KX2Bi5n3iaAmuTuCu0\nqZ5SGbSKJJu6UvSQzEPj1/mGNUIrLozRn9mr/NbsADt+WInPp08z1TRBdidVe7kU\npV7MLQ4qAGEfqh+BhVb7Z0W91KPWLrv8nNZPAz8KCQKBgQDqsXIScSZZfQdjF39M\nazwcUrjbWgFpdTpduggNocng1UmRXfOdr+N1mqvKl6rfj+Gm26DB4z1JCBmoFiFf\nGVEhEynVPRnuVe5rf4295r3oXz50NoZ2+qGqntp+i/bJNZpJAsmHeTyJr9PcmIyv\nbrApWRk+i7lyuO4po2234JlXEwKBgQC5BK9Ij0ePTbl7fkw+T61tNprCZwP++v8y\nZjcfXyL1odvB9NSNwOf+o9Y/lDBbiYdpN2N4DqIBhhvIhlLUOjymY7tc3lAYkoQT\nLTJDB66ttrjNkkdbTC9HjCCsoGWjllxAyhawvDxpfrsMP6cSyOomX0IiUToIn45S\nlI68Q+bOvQKBgDn0x+618np23bQiwVTlxlpYMz4349FfGaK7pfF32pqjER/My7RN\nEyafo3zMJ2494cOKyRAYRbIbRfq0PFl3rwkz6ki2ZgjtP4tcXGxg5tTTcGDSdjI7\ngmDYCazmc3MMwaT2Az5pOgHmYbNAGL3Z37bWQd2oM4uZD3dI3HdkB3nxAoGASvqi\nCla+Wk3WUDyjq1Dg6HSLjSLwVKHlT8hqqFUGtuKsS1Lr3LKDkgdVaRil7EK01Kf0\nsI/FibaOhdohsQ4UzB14ra8OaJbf3WGgj9eKK630AKM6Nb6PHoCkMTEjX4Msybjc\nLy1pkhsgtFsLWyp+8aQDCiM+0IXQyJiZq6Qc4kUCgYBFhCBRNVAj3hn5WlTzXLo2\nyb3C6XrmnL9RdHWW3gopN/t6mEcawYYFQv+W0+5QaRw3WkFi4ryYXOo7GUG+sOuR\n6KzXO08c4EGYBtMdXd1EGgDQ5P7UssAHJO9B05ezE8htAVyNYLa84ul7uzfgJS4p\nOGNkubfgqmQt6o1d0rDIbg==\n-----END PRIVATE KEY-----\n",
   "client_email": "googlesheets-api@peak-monument-421811.iam.gserviceaccount.com",
   "client_id": "108598628424400148063",
   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
   "token_uri": "https://oauth2.googleapis.com/token",
   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/googlesheets-api%40peak-monument-421811.iam.gserviceaccount.com",
   "universe_domain": "googleapis.com"
  }''';
  final _spreadsheetId = '13yqrtJM6gYEqPl1isPJLo6NRa_R4-pBVZGLEh6GYHCI';

  final String workSheetName = '工作表1';

  Worksheet? _worksheet;

  List<List<dynamic>> sheetData = [];

  bool _isLoading = true;

  SheetController sheetController = Get.put(SheetController());

  @override
  void initState() {
    super.initState();
    _initSheet();
  }

  Future<void> _initSheet() async {
    try {
      final gsheets = GSheets(_credentials);
      final spreadsheet = await gsheets.spreadsheet(_spreadsheetId);
      _worksheet = spreadsheet.worksheetByTitle(workSheetName); //底部工作表名稱
      await _loadData();
      print('表格初始化連結成功');
    } catch (e) {
      print('初始化Google表格發生錯誤: $e');
    }
  }

  Future<void> _loadData() async {
    try {
      final rows = await _worksheet!.values.allRows();
      setState(() {
        sheetData = rows;
        _isLoading = false;
        print('數據更新 : $sheetData');
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('數據更新成功',textAlign: TextAlign.center,),
      duration: Duration(seconds: 2),
    ));
      
    } catch (e) {
      print('讀取數據時發生錯誤: $e');
    }
  }

  Future<void> _updateData(dynamic newValue, int row, int column) async {
    try {
      await _worksheet!.values
          .insertValue(newValue, row: row, column: column); //row=列，column=行
      print('數據已更新');
      _loadData(); // 重新加載數據以更新界面
    } catch (e) {
      print('更新數據時發生錯誤: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String getColumnLabel(int index) {
      String result = '';
      while (index >= 0) {
        result = String.fromCharCode(65 + index % 26) + result;
        index = index ~/ 26 - 1;
      }
      return result;
    }

    List<String> generateColumnLabels(int count) {
      return List.generate(count, (index) => getColumnLabel(index));
    }

    final labels = generateColumnLabels(_isLoading ? 0 : sheetData[0].length);
    final columns = labels
        .map((label) => DataColumn(label: Text(label)))
        .toList(); //(A、B、C、D...)

    final rows = sheetData.sublist(0).map((List<dynamic> row) {
      return DataRow(
          cells: row.map((cell) => DataCell(Text(cell.toString()))).toList());
    }).toList();

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
                      onPressed: _loadData,
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
                        _updateData(newValue, row, column);
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
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            child: DataTable(
                              columns: columns, //這裡只處理標題
                              rows: rows,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
