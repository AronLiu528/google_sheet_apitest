import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gsheets/gsheets.dart';

class SheetService {
  late final GSheets gsheets;
  late final Spreadsheet spreadsheet;
  Worksheet? worksheet;

  Future<void> loadEnvAndInitialize() async {
    await dotenv.load();//讀取
    final credentials = dotenv.env['CREDENTIALS_JSON'];
    final spreadsheetId = dotenv.env['SPREADSHEET_ID'];
    final workSheetName = dotenv.env['WORKSHEET_NAME'];
    // print('credentials : $credentials');
    // print('spreadsheetId : $spreadsheetId');
    // print('workSheetName : $workSheetName');

    if (credentials == null || spreadsheetId == null || workSheetName == null) {
      print('用戶訊息獲取失敗');
      throw Exception('環境變數獲取失敗(.env)');
    }

    gsheets = GSheets(credentials);
    spreadsheet = await gsheets.spreadsheet(spreadsheetId);
    worksheet = spreadsheet.worksheetByTitle(workSheetName);
    print('4 $worksheet');

    if (worksheet == null) {
      print('worksheet為空 : $worksheet');
      throw Exception('Failed to load worksheet: $workSheetName');
    }
  }

  // 讀取數據
  Future<List<List<dynamic>>> loadData() async {
    if (worksheet == null) throw Exception('1:Worksheet is not initialized');
    return await worksheet!.values.allRows();
  }

  // 更新數據
  Future<void> updateData(dynamic newValue, int row, int column) async {
    if (worksheet == null) throw Exception('2:Worksheet is not initialized');
    await worksheet!.values.insertValue(newValue, row: row, column: column);
  }

}
