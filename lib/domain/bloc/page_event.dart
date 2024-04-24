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

final class FilterModified extends PageEvent {
  final Filter filter;

  const FilterModified(this.filter);

  @override
  List<Object> get props => [filter];
}

final class FilterModifiedKeywords extends PageEvent {
  final String keywords;

  const FilterModifiedKeywords(this.keywords);

  @override
  List<Object> get props => [keywords];
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
