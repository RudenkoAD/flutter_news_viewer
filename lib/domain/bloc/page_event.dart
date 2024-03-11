part of 'page_bloc.dart';

sealed class PageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class PageNumberIncremented extends PageEvent {}

final class PageNumberDecremented extends PageEvent {}
