import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app_bounties/app/modules/models/user/user.dart';
import 'package:app_bounties/app/modules/repository/repository_interface.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../baseApi/constants.dart';

class Repository extends IRepository {
  @override
  Future<List<User>?> getAllUsers() async {
    try {
      const url = '$baseApi/users';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        final usersData = data.map((json) => User.fromJson(json)).toList();
        return usersData.length >= 0 ? usersData : [];
      } else {
        throw HttpException('Erro status code: $response.statusCode');
      }
    } on HttpException catch (error) {
      debugPrint('Erro ao conectar a API: $error');
    } on TimeoutException {
      debugPrint('Timeout excedido ao conectar a API!');
    }
    return [];
  }
}
