import 'package:code/api_layer/repository/get_country_repo.dart';
import 'package:code/model/country.dart';
import 'package:code/screens/home_screen/logic/home_event.dart';
import 'package:code/screens/home_screen/logic/home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeInitialEvent>(_homeInitialEvent);
    on<SearchCountryDataEvent>(_searchCountryDataEvent);
  }

  TextEditingController searchController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Country? country;
  bool isLoading = false;
  bool isAllLoading = false;
  List<Country> countries = [];
  bool isFirstTime = true;

  Future<void> _homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    isAllLoading = true;

    emit(GetAllCountryRefreshState());
    countries = await GetCountryRepo().getAllCountries();
    isAllLoading = false;
    emit(GetAllCountryRefreshState());
  }

  Future<void> _searchCountryDataEvent(
      SearchCountryDataEvent event, Emitter<HomeState> emit) async {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      isFirstTime = false;
      isLoading = true;
      emit(SearchCountryRefreshState());
      country = await GetCountryRepo().getCountry(searchController.text);
      isLoading = false;
      emit(SearchCountryRefreshState());
    }
  }
}
