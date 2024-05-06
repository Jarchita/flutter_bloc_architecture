
/// Purpose : this file contains enums used throughout the app
library;

enum DownloadStatus { success, inProgress, failure }

enum ResponseFrom { admin, you }

/// Purpose : Specifies the source where the picked image should come from.
enum MediaSource {
  /// Opens up the device camera, letting the user to take a new picture.
  camera,

  /// Opens the user's photo gallery.
  gallery,
}

enum SnackBarStyle {
  normal,
  success,
  error,
}
