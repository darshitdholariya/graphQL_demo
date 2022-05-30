class HomeEvent {}

class HomeInitialEvent extends HomeEvent {
  @override
  String toString() {
    return 'HomeInitialEvent';
  }
}

class SearchCountryDataEvent extends HomeEvent {
  @override
  String toString() {
    return 'SearchCountryDataEvent';
  }
}
