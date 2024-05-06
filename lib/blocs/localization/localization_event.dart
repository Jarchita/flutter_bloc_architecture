part of 'localization_bloc.dart';


/// Purpose : Base Class for localization Bloc Event
abstract class LocalizationEvent extends Equatable {
  const LocalizationEvent();
}

class FetchLocaleEvent extends LocalizationEvent {
  @override
  List<Object?> get props => [];
}

class UpdateLocaleEvent extends LocalizationEvent {
  const UpdateLocaleEvent({required this.languageCode, this.countryCode});

  final String languageCode;
  final String? countryCode;
  @override
  List<Object?> get props => [languageCode, countryCode];
}
