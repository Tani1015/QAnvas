enum SharedPreferencesKey {
  email,
  password,
  note
}

extension SharedPreferencesKeyExtension on SharedPreferencesKey {
  String get value => name;
}