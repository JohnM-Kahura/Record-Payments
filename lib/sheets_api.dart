import 'package:gsheets/gsheets.dart';

import 'user.dart';

class UserSheetsApi {
static const _credentials ="{}";
  static const _spreadsheetId = "1CvVa3Xgynky9gu6yptgFCfG7fBGRwo2gy-tDxNaBdaY";
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final spreadsheat = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheat, title: 'test_1');
      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
  static Future insert(List<Map<String,dynamic>> rowList) async{
    if(_userSheet==null) return;
    _userSheet!.values.map.appendRows(rowList);
  }
}
