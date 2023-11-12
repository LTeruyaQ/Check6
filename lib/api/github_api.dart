import 'dart:convert';
import 'package:github_api_demo/models/branch.dart';
import 'package:github_api_demo/models/repository.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class GitHubApi {
  final String baseUrl = 'https://api.github.com/';
  final String token =
      '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';

  Future<User?> findUser(String userName) async {
    final url = '${baseUrl}users/$userName';
    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var user = User.fromJson(json);

      return user;
    } else {
      return null;
    }
  }

  Future<List<User>> getFollowing(String userName) async {
    final url = '${baseUrl}users/$userName/following';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);
      var users = jsonList.map<User>((json) => User.fromJson(json)).toList();
      
      return users ?? [];
    } else {
      return [];
    }
  }

  Future<List<Repository>> getRepos(String userName) async {
    final url = '${baseUrl}users/$userName/repos';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);

      var repos = jsonList.map<Repository>((json) => Repository.fromJson(json)).toList();

      return repos ?? [];
    } else {
      return [];
    }
  }

    Future<List<Repository>> getFavs(String userName) async {
    final url = '${baseUrl}users/$userName/starred';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);

      var repos = jsonList.map<Repository>((json) => Repository.fromJson(json)).toList();

      return repos ?? [];
    } else {
      return [];
    }
  }

    Future<List<Branch>> getBranches(String userName, String repoName) async {
    final url = '${baseUrl}repos/$userName/$repoName/branches';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);

      var branch = jsonList.map<Branch>((json) => Branch.fromJson(json)).toList();
      return branch ?? [];
    } else {
      return [];
    }
  }
}
