// BASED ON FLUTTER ICON DATA

// ignore_for_file: non_constant_identifier_names

abstract final class UntoldIcons {
  static final eye_slash = UntoldIconData('assets/icons/eye_slash.svg');
  static final apple_button = UntoldIconData('assets/icons/apple_button_icon.svg');
  static final google_button = UntoldIconData('assets/icons/google_button_icon.svg');
  static final camera = UntoldIconData('assets/icons/camera.svg');
  static final gallery = UntoldIconData('assets/icons/gallery.svg');
  static final like_enabled = UntoldIconData('assets/icons/like_enabled.svg');
  static final like_disabled = UntoldIconData('assets/icons/like_disabled.svg');
  static final dislike_enabled = UntoldIconData('assets/icons/dislike_enabled.svg');
  static final dislike_disabled = UntoldIconData('assets/icons/dislike_disabled.svg');
  static final love_enabled = UntoldIconData('assets/icons/love_enabled.svg');
  static final love_disabled = UntoldIconData('assets/icons/love_disabled.svg');
  static final share = UntoldIconData('assets/icons/share.svg');
  static final close = UntoldIconData('assets/icons/close.svg');
  static final shield = UntoldIconData('assets/icons/shield.svg');
  static final trash = UntoldIconData('assets/icons/trash.svg');
  static final backwards = UntoldIconData('assets/icons/backwards.svg');
  static final comments = UntoldIconData('assets/icons/comments.svg');
  static final edit = UntoldIconData('assets/icons/edit.svg');
  static final flag = UntoldIconData('assets/icons/flag.svg');
  static final forward = UntoldIconData('assets/icons/forward.svg');
  static final backward = UntoldIconData('assets/icons/backward.svg');
  static final pause = UntoldIconData('assets/icons/pause.svg');
  static final send = UntoldIconData('assets/icons/send.svg');
  static final subtitles = UntoldIconData('assets/icons/subtitles.svg');
  static final fullscreen = UntoldIconData('assets/icons/fullscreen.svg');
  static final arrow_down = UntoldIconData('assets/icons/arrow_down.svg');
}

class UntoldIconData {
  final String path;
  UntoldIconData(this.path);

  @override
  String toString() => path;
}
