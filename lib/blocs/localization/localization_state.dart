part of 'localization_bloc.dart';

/// Purpose : state class for localization bloc
/// extended by all subsequent states
abstract class LocalizationBlocState extends Equatable {
  const LocalizationBlocState();
}

class LatestLocalizationState extends LocalizationBlocState {
  const LatestLocalizationState({required this.currentLocale});

  final Locale currentLocale;

  @override
  List<Object> get props => [];
}
