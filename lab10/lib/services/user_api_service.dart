import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserApiService {
  static const String _baseUrl = 'https://fakestoreapi.com/users';
  static const String _cacheKeyUsers = 'cached_users';
  static const String _cacheKeyTimestamp = 'cache_timestamp';
  static const Duration _cacheDuration = Duration(hours: 24);

  /// Get cached users from local storage
  Future<List<UserModel>?> getCachedUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(_cacheKeyUsers);
      final cachedTimestamp = prefs.getInt(_cacheKeyTimestamp);

      if (cachedData == null) return null;

      // Check if cache is still valid
      if (cachedTimestamp != null) {
        final now = DateTime.now().millisecondsSinceEpoch;
        if (now - cachedTimestamp > _cacheDuration.inMilliseconds) {
          return null; // Cache expired
        }
      }

      final List data = jsonDecode(cachedData);
      return data.map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      return null;
    }
  }

  /// Save users to local storage
  Future<void> cacheUsers(List<UserModel> users) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonData = jsonEncode(users.map((u) => u.toJson()).toList());
      await prefs.setString(_cacheKeyUsers, jsonData);
      await prefs.setInt(_cacheKeyTimestamp, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      print('Error caching users: $e');
    }
  }

  /// Clear cached users
  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_cacheKeyUsers);
      await prefs.remove(_cacheKeyTimestamp);
    } catch (e) {
      print('Error clearing cache: $e');
    }
  }

  Future<List<UserModel>> fetchUsers() async {
    final res = await http.get(Uri.parse(_baseUrl));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      final users = data.map((e) => UserModel.fromJson(e)).toList();
      // Cache the data locally
      await cacheUsers(users);
      return users;
    }
    throw Exception('Failed to load users (${res.statusCode})');
  }
Future<UserModel> fetchUserById(int id) async {
final res = await http.get(Uri.parse('$_baseUrl/$id'));
if (res.statusCode == 200) {
return UserModel.fromJson(jsonDecode(res.body));
}
throw Exception('Failed to load user ($id) (${res.statusCode})');
}
Future<UserModel> createUser(UserModel user) async {
final res = await http.post(
Uri.parse(_baseUrl),
headers: {'Content-Type': 'application/json'},
body: jsonEncode(user.toJson()),
);
// FakeStoreAPI คืนค่า 200/201 (ขึ้นกับระบบ)
if (res.statusCode == 200 || res.statusCode == 201) {
return UserModel.fromJson(jsonDecode(res.body));
}
throw Exception('Failed to create user (${res.statusCode})');
}
Future<UserModel> updateUser(int id, UserModel user) async {
final res = await http.put(
Uri.parse('$_baseUrl/$id'),
headers: {'Content-Type': 'application/json'},
body: jsonEncode(user.toJson()),
);
if (res.statusCode == 200) {
return UserModel.fromJson(jsonDecode(res.body));
}
throw Exception('Failed to update user ($id) (${res.statusCode})');
}
Future<void> deleteUser(int id) async {
final res = await http.delete(Uri.parse('$_baseUrl/$id'));
if (res.statusCode == 200) return;
throw Exception('Failed to delete user ($id) (${res.statusCode})');
}
}