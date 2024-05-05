import 'package:flutter/material.dart';
import 'package:google_sheet_apitest/screens/spreadsheet_page.dart';


class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login to Google Sheets'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 假設登錄成功，導航到試算表頁面
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SpreadsheetPage(data: [['Row 1 Data'], ['Row 2 Data']])),
            );
          },
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}
