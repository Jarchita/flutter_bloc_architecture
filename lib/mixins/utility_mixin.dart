import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:uuid/uuid.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../exports/constants.dart';
import '../exports/resources.dart';
import '../exports/utilities.dart';

/// Purpose : mixin for all common utility methods
mixin UtilityMixin {
  static String tag = "UtilityMixin";

  /// Purpose : clear back stack of the screen and place on the top
  void clearStackAndAddScreen(BuildContext context, Widget screen) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screen), (route) => false);
  }

  void clearStackAndAddNamedRoute(BuildContext context, String route) {
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
  }


  /// Purpose : function to hide keyboard
  void hideKeyboard(BuildContext context) =>
      FocusScope.of(context).requestFocus(FocusNode());

  ///Purpose : navigate to next screen and not manage stack
  void navigationPushReplacement(BuildContext context, Widget routeName) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => routeName,
      ),
    );
  }

  ///Purpose : navigate to next screen and manage back press
  Future<dynamic> navigationPush(BuildContext context, Widget screen) async =>
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );


  /// Purpose : method to display snack bar of common types
  void showSnackBar(BuildContext context, String message,
      {SnackBarStyle style = SnackBarStyle.normal, int? duration}) {
    const textStyle = AppStyles.snackBarTextStyle;
    const color = AppColors.primary;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: textStyle),
      margin: const EdgeInsets.all(15),
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      duration: Duration(seconds: duration ?? 4),
      backgroundColor: color,
    ));
  }


  /// Purpose : This method is used to get header widget for pull to refresh.
  // Widget getPullToRefreshHeaderWidget() => const MaterialClassicHeader(
  //     height: 70, color: AppColors.black, backgroundColor: AppColors.primary);


  /// Purpose : This method is used to get date time from string
  DateTime getDateTimeFromString(String date) => DateTime.parse(date);


  /// Purpose : This method is used to get date in fix format.
  String getDateInParticularFormat(DateTime date, String format) =>
      DateFormat(format).format(date);


  /// Purpose : This method is used to launch url.
  Future launchUrl(
    BuildContext context,
    String url,
  ) async {
    // if (await canLaunch(url)) {
    //   await launch(
    //     url,
    //   );
    // } else {
    //   showSnackBar(context, 'Could not launch.', style: SnackBarStyle.error);
    // }
  }


  /// Purpose : This method is used to get date in week day hour format.
  /// added support for unix timestamp conversion
  String getDateInWeekDayHourFormat({String? date, int? unixStamp}) {
    try {
      late DateTime postdate;
      if (date != null) {
        postdate = getDateTimeFromString(date);
      }
      if (unixStamp != null) {
        postdate = DateTime.fromMillisecondsSinceEpoch(unixStamp * 1000);
      }
      final difference = DateTime.now().difference(postdate).inMilliseconds;
      final seconds = (difference / 1000).round();
      final minutes = (seconds / 60).round();
      final hours = (minutes / 60).round();
      final days = (hours / 24).round();
      final weeks = (days / 7).round();
      if (seconds < 60) {
        return "$seconds${AppStrings.secondInitialChar}";
      } else if (minutes < 60) {
        return "$minutes${AppStrings.minuteInitialChar}";
      } else if (hours < 24) {
        return "$hours${AppStrings.hourInitialChar}";
      } else if (days < 7) {
        return "$days${AppStrings.dayInitialChar}";
      } else {
        return "$weeks${AppStrings.weekInitialChar}";
      }
    } catch (e) {
      Logger.d(tag, "exception in getDateInWeekDayHourFormat : $e");
      return "";
    }
  }


  /// Purpose : This method is used to get date in week day hour year format.
  String getDateInYearWeekDayHourFormat({String? date, int? unixStamp}) {
    try {
      late DateTime postdate;
      if (date != null) {
        postdate = getDateTimeFromString(date);
      }
      if (unixStamp != null) {
        postdate = DateTime.fromMillisecondsSinceEpoch(unixStamp * 1000);
      }
      final difference =
          DateTime.now().toUtc().difference(postdate).abs().inMilliseconds;

      final seconds = (difference / 1000).round();
      final minutes = (seconds / 60).round();
      final hours = (minutes / 60).round();
      final days = (hours / 24).round();
      final weeks = (days / 7).round();
      final year = (weeks / 52).round();
      if (seconds < 60) {
        return "$seconds${AppStrings.secondInitialChar}";
      } else if (minutes < 60) {
        return "$minutes${AppStrings.minuteInitialChar}";
      } else if (hours < 24) {
        return "$hours${AppStrings.hourInitialChar}";
      } else if (days < 7) {
        return "$days${AppStrings.dayInitialChar}";
      } else if (weeks < 52) {
        return "$weeks${AppStrings.weekInitialChar}";
      } else {
        return "$year${AppStrings.yearInitialChar}";
      }
    } catch (e) {
      Logger.d(tag, "exception in getDateInWeekDayHourFormat : $e");
      return "";
    }
  }


  /// Purpose : This method is used to captureImage from camera or gallery.
  Future<File?> getMedia({required MediaSource source}) async {
    File? file;
    if (source == MediaSource.camera) {
      // final _picker = ImagePicker();
      // final image = await _picker.pickImage(source: ImageSource.camera);
      // if (image != null) {
      //   file = File(image.path);
      // }
    } else {
      // final result = await FilePicker.platform.pickFiles(
      //   type: FileType.media,
      // );
      // if (result != null) {
      //   file = File(result.files.single.path!);
      // }
    }
    return file;
  }


  /// Purpose : This method is used to generate unique id from given filepath.
  String generateUploadId(String filepath) {
    // const uuid = Uuid();
    // return uuid
    //     .v5(
    //       Uuid.NAMESPACE_URL,
    //       "${DateTime.now().millisecond}_${getFileName(filepath)}",
    //     )
    //     .toString();
    return "";
  }


  /// Purpose : function to get file name from filepath
  String getFileName(String filepath) =>
      filepath.substring(filepath.lastIndexOf("/") + 1, filepath.length);


  /// Purpose : function to get extension from filename
  String getFileExt(String filename) =>
      filename.substring(filename.lastIndexOf(".") + 1, filename.length);


  /// Purpose : format date time as per given format
  String getFormattedDateTime(DateTime dateTime, {String? format}) {
    try {
      final formattedDate =
          DateFormat(format ?? DateFormats.dateFormatDdMmYyyy).format(dateTime);
      Logger.d(tag, "formattedDate: $formattedDate");

      return formattedDate;
    } on Exception catch (e) {
      Logger.e(tag, "exception in  getFormattedDate: $e");
      return dateTime.toString();
    }
  }


  /// Purpose : combine given date and time
  /// convert datetime to unix format
  int? convertToUnix(DateTime date, DateTime time) {
    try {
      final dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
        time.second,
      );
      final convertedDate = (dateTime.toUtc().millisecondsSinceEpoch) ~/ 1000;
      Logger.d(tag, "dateTime: $dateTime");
      Logger.d(tag, "convertToUnix: $convertedDate");
      return convertedDate;
    } on Exception catch (e) {
      Logger.e(tag, "exception in convertToUnix: $e");
    }
  }


  /// Purpose : combine given date and time
  /// convert datetime to unix format
  int? convertDateTimeToUnix(DateTime date) {
    try {
      final dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        date.hour,
        date.minute,
        date.second,
      );
      final convertedDate = (dateTime.toUtc().millisecondsSinceEpoch) ~/ 1000;
      Logger.d(tag, "dateTime: $dateTime");
      Logger.d(tag, "convertToUnix: $convertedDate");
      return convertedDate;
    } on Exception catch (e) {
      Logger.e(tag, "exception in convertToUnix: $e");
    }
  }


  /// Purpose : combine given date and time
  /// convert datetime to unix format
  int convertDateTimeToUnixUTC(DateTime date, {int? firstDay}) {
    try {
      final dateTime =
          DateTime.utc(date.year, date.month, firstDay ?? date.day);
      final convertedDate = (dateTime.millisecondsSinceEpoch) ~/ 1000;
      Logger.d(tag, "dateTime: $dateTime");
      Logger.d(tag, "convertToUnix: $convertedDate");
      return convertedDate;
    } on Exception catch (e) {
      Logger.e(tag, "exception in convertToUnix: $e");
    }
    return 0;
  }

  ///format date as per given format
  String getFormattedDate(String date, {String? format}) {
    try {
      final parsedDate = DateTime.parse(date);
      final formattedDate =
          DateFormat(format ?? DateFormats.dateFormatLong).format(parsedDate);
      Logger.d(tag, "formattedDate : $formattedDate");
      return formattedDate;
    } on Exception catch (e) {
      Logger.e(tag, "exception in  getFormattedDate: $e");
      return date;
    }
  }

  int getTimeZoneOffset() => DateTime.now().timeZoneOffset.inMinutes;

  ///convert utc date to local
  String convertUtcToLocal(String dateUtc) {
    try {
      final temp = DateTime.parse(dateUtc);
      final dateLocal = temp.toLocal().toString();
      Logger.d(tag, "dateLocal: $dateLocal");
      return dateLocal;
    } on Exception catch (e) {
      Logger.e(tag, "exception in  convertUtcToLocal: $e");
      return dateUtc;
    }
  }

  String getSimpleDate(String dateUtc) {
    try {
      final temp = DateTime.parse(dateUtc);
      final dateLocal = temp.toLocal();
      final date = DateTime(dateLocal.year, dateLocal.month, dateLocal.day);
      Logger.d(tag, "dateLocal: $dateLocal");
      return date.toString();
    } on Exception catch (e) {
      Logger.e(tag, "exception in  convertUtcToLocal: $e");
      return dateUtc;
    }
  }

  bool isToday(String date) {
    final temp = DateTime.parse(date);
    final dateLocal = temp.toLocal();
    final now = DateTime.now();
    return DateTime(dateLocal.year, dateLocal.month, dateLocal.day) ==
        DateTime(now.year, now.month, now.day);
  }

  ///get id from youtube video
  String? getYoutubeId(String url) {
    String? videoId;
    try {
      // videoId = YoutubePlayer.convertUrlToId(url);
      Logger.d(tag, "videoId : $videoId");
    } on Exception catch (e) {
      Logger.d(tag, e);
    }
    return videoId;
  }

  ///get thumb from youtube video
  String? getVideoThumb(
    String url,
    // {String quality = ThumbnailQuality.defaultQuality,}
  ) {
    final videoId = getYoutubeId(url);
    return "https://img.youtube.com/vi/$videoId/0.jpg";
    // return "https://i3.ytimg.com/vi/$videoId/0.jpg";
  }

  String getLastRechargeString(double? amount, String? lastRechargeDate) {
    if (lastRechargeDate != null) {
      final date = getFormattedDate(convertUtcToLocal(lastRechargeDate));
      return "Last purchase of R$amount on $date";
    }
    return "No token purchased";
  }
}
