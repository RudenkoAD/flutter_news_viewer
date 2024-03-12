part of 'page_bloc.dart';

sealed class PageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class PageInitialized extends PageEvent {}

final class PageNumberIncremented extends PageEvent {}

final class PageNumberDecremented extends PageEvent {}

final class PageCountryChanged extends PageEvent {
  final String country;

  PageCountryChanged(this.country);

  @override
  List<Object> get props => [country];
}

final class ApiKeyEntered extends PageEvent {
  final String apiKey;

  ApiKeyEntered(this.apiKey);

  @override
  List<Object> get props => [apiKey];
}
