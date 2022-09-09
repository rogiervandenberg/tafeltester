import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  Settings({
    required this.tables,
  });

  final Map<int, bool> tables;

  static Future<List<int>> getSavedTables() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    // Try reading data from the 'items' key. If it doesn't exist, returns null.
    final tablesString = prefs.getString('tables');

    if (tablesString != null) {
      var arr = tablesString.split(",").map((e) => int.parse(e)).toList();
      return arr;
    } else {
      return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    }
  }

  static setSavedTables(List<int> tables) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tables', tables.join(","));
  }

  List<int> tablesToArray() {
    List<int> arr = [];

    tables.forEach((key, value) {
      if (value) {
        arr.add(key);
      }
    });

    return arr;
  }
}
