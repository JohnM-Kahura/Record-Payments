import 'package:gsheets/gsheets.dart';

import 'user.dart';

class UserSheetsApi {
  static const _credentials = r"""
{
  "type": "service_account",
  "project_id": "gshe-356012",
  "private_key_id": "2d0bcf556e13f0f3f2324d9daa37d7caa80a7ab6",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDC1jFqY+eR1dT0\n5iLP7AFrvjgxeMqQVsFMVgArJl0lHkPL3t7lGZtGEHS5NClX43Yi54JWWqaVmITd\nK5u5kT8mE3QCn3/0JEFBT9e80e4bhaFjYbVK74wc+pCA/wy7wZAkEky9hnKvaveM\naTT1TA4ksyS0dUP6LSQoXP/+rhcr90/w4sm3bJebRUgQjbwHO42h2Y926KR0LUmy\nLtFPq/VTVa9IQ/sjq4KJFFsJR8qt62aFCVA0PAppAig1ckeDjoc+ewPnCRN1zX7J\n049f3mlszopNIcwLNOQWcxZXqAkjuG5rfqbWpb+TgqAGeV54O1SbdK66vHduHGLP\nfijF2r4LAgMBAAECggEAOdXXKVuqm9G7u06tOsc1zMPUbmsKxjnae0x0FFr4/1Gy\nkkwAIkWtn+i2nVtsglhU8xuBxxx1oqZ5miWdvkHtWuIfZ7/s/Y3diQOoaLZwVd8e\n/x8775iYIOoIByKupvVYUjzUZtYIKSY5gYahX8dJ038SADdnDFZmC00/+Fu5KSVl\nsE7ugzYnBUuGmHvWtAbFHyjifKldOwbRI8yTV+fmiBXgiowqNp+BgKxloR7T0Wyz\nGTYJ6+Q2tjHw/F52c0HOom0+EC+44WKCPCeDFtAcuyaVd+H/uH204b1oCHbnyVvA\nQIS09Ywg2RQZVaUyrfRrF1ith7lFtmhl6cPu2/3OYQKBgQDwwwuPyrtdlyou//25\nBG3i1VHgE0vMA6bR3Jzx+cMOWTTt5chBiXk80FA5SOJNa6tvbWxxk2vXOgN618yk\nLwl3RUxm5qWSLLpZCNHLPn0HPb0RxcWMfrHWt65n13gDiJDBVCSJmIMTd5xx7ID5\n3jV8Ac2ag0Wk1zp1LHjdc9abKQKBgQDPKwr1JwgZ1fZb1afyKzxLhuQlie8yjIcL\nf800oKNPdjAd/m/6GT1MU0iJRL8DMLcF7+IZREaSlS5TEB6397DpElFfomHBA6eW\nuwJ12tt7JLvtdKen6+yLhaMMskJjj0PeTaJrArGnzZ2P2gkglFmT6XrMuveUgh2k\nBZXhO0SqEwKBgHGbx//hLUq7gxdMiqBcm7G28Xyn/lNVwckzrgds0QMbSyObE0UB\npujwb3qojsjzrqDU5KAvbWrRIEU+QX2UCIZ0d9nyqlxwqLpMtBqQ8RSSqH4TceWa\n/zYP1MeBYEtijNP9bYRUKD3uai9D55SAq4JJo4huu1VOjnIuOxZci/8JAoGAayEU\n/4T5mXKdfQvVV1OoUF4m6IqVmQw2YWnrUcWn7dVuOHR0r14R5sBCiEl2hU3Rt04/\nG1XFMNPYKrfxSqzZXQ1N6yhraIZdSYLXWN6eFOYAEGD8ucc0gUnP8SbVUeqp6/E1\nhiTUfbPEQLk9cw2D7QsVp30fvjoy3bjNsrUVYuUCgYAbrZItuGpFFG5J6lH//QV7\n1gUlfTJeGshBVml+ItfLl6JFTPSdcw9MjQnnGeQr1MCEynnNyfLIURCjwAhK1Gn/\neJkFA/zAawVkX1NU4d6aJr0sefVr0PkDJcVy43zNKOnt6vlL7JckbegYDDmCR7cE\n031wKjdeYhuOIJAbCdQ5LQ==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gshe-356012.iam.gserviceaccount.com",
  "client_id": "109730106027167715923",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gshe-356012.iam.gserviceaccount.com"
}
""";
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
