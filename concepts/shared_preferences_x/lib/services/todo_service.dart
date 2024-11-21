import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TodoService {
  static const String _key = 'todo_list';

  Future<List<Map<String, dynamic>>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todoString = prefs.getString(_key);

    if (todoString != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(todoString));
    }
    return [];
  }

  Future<void> saveTodos(List<Map<String, dynamic>> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final String todoString = jsonEncode(todos);
    await prefs.setString(_key, todoString);
  }
}
