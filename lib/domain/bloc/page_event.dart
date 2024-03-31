part of 'page_bloc.dart';

sealed class PageEvent extends Equatable {
  const PageEvent();
  @override
  List<Object> get props => [];
}

final class PageInitialized extends PageEvent {
  const PageInitialized();
}

final class PageNumberIncremented extends PageEvent {
  const PageNumberIncremented();
}

final class PageNumberDecremented extends PageEvent {
  const PageNumberDecremented();
}

final class PageCountryChanged extends PageEvent {
  final String country;

  const PageCountryChanged(this.country);

  @override
  List<Object> get props => [country];
}

final class ApiKeyEntered extends PageEvent {
  final String apiKey;

  const ApiKeyEntered(this.apiKey);

  @override
  List<Object> get props => [apiKey];
}
