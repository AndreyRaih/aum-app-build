import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Request {
  Future get(String url, {bool isJson = true}) {
    return http.get(url).then((response) {
      if (response.statusCode != 200) {
        return throw (ErrorHint(response.body));
      }
      if (isJson) {
        return jsonDecode(response.body);
      } else {
        return response.body;
      }
    });
  }

  Future post(url, body, {bool isJson = true}) {
    var _body = json.encode(body);
    return http.post(url, headers: {"Content-Type": "application/json"}, body: _body).then((response) {
      if (response.statusCode != 200) {
        return throw (ErrorHint(response.body));
      }
      if (isJson) {
        return jsonDecode(response.body);
      } else {
        return response.body;
      }
    });
  }
}
