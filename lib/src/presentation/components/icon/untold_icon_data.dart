// BASED ON FLUTTER ICON DATA

// ignore_for_file: non_constant_identifier_names

abstract final class UntoldIcons {
  static final eye_slash = UntoldIconData('assets/icons/eye_slash.svg');
  static final apple_button = UntoldIconData('assets/icons/apple_button_icon.svg');
  static final google_button = UntoldIconData('assets/icons/google_button_icon.svg');
}

class UntoldIconData {
  final String path;
  UntoldIconData(this.path);

  @override
  String toString() => path;
}
