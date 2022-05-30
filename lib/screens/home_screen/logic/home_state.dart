class HomeState {}

class HomeInitialState extends HomeState {
  @override
  String toString() {
    return 'HomeInitialState';
  }
}

class SearchCountryRefreshState extends HomeState {
  @override
  String toString() {
    return 'SearchCountryRefreshState';
  }
}

class GetAllCountryRefreshState extends HomeState {
  @override
  String toString() {
    return 'GetAllCountryRefreshState';
  }
}
