class Utils {
  static String getUsername(String email) {
    return "live:${email.split('@')[0]}";
  }

  static String getInitials(String displayName) {
    List<String> nameSplit = displayName.split(' ');
    String firstName = nameSplit[0][0] ?? '-';
    String secondName = nameSplit[1][0] ?? '-';
    return firstName.toUpperCase() + secondName.toUpperCase();
  }
}
