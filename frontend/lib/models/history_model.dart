import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/provider/user_provider.dart';

import "package:http/http.dart" as http;

class HistoryModel with ChangeNotifier {

  final UserProvider userProvider;
  HistoryModel(this.userProvider);
  String address = dotenv.get('ADDRESS');

  List history = [];

  Future<String> getMemberInfo(String accessToken) async {
    var url = Uri.https(address, "/api/v1/member/info");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $accessToken"
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return "Success";
    } else {
      return "fail";
    }
  }
}
