class Helper {
  // method to replace space with plus sign
  static String? replaceSpace(String? query) {
    if (query == null) return null;
    return query.trim().replaceAll(" ", "+");
  }
}
