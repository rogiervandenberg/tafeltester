class Settings {
  Settings({
    required this.tables,
  });

  final Map<int, bool> tables;

  List<int> toArray() {
    List<int> arr = [];

    tables.forEach((key, value) {
      if (value) {
        arr.add(key);
      }
    });

    return arr;
  }
}
