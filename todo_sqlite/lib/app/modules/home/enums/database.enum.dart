enum DATABASE { name, version }

class DatabaseHelperEnum {
  static dynamic getValue(DATABASE databaseName) {
    switch (databaseName) {
      case DATABASE.name:
        return "todo_sqlite.db";
          case DATABASE.version:
        return 1;
      default:
        return "";
    }
  }
}
