import 'package:code/model/country.dart';
import 'package:code/screens/home_screen/logic/home_bloc.dart';
import 'package:code/screens/home_screen/logic/home_event.dart';
import 'package:code/screens/home_screen/logic/home_state.dart';
import 'package:code/shared_widget/country_details_item.dart';
import 'package:code/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) {
        return HomeBloc()..add(HomeInitialEvent());
      },
      child: const _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen({Key? key}) : super(key: key);

  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  late final HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (BuildContext context, HomeState state) {},
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: BlocBuilder<HomeBloc, HomeState>(
                bloc: homeBloc,
                buildWhen: (previous, current) {
                  if (current is GetAllCountryRefreshState) {
                    return true;
                  }
                  return false;
                },
                builder: (BuildContext context, HomeState state) {
                  if (homeBloc.isAllLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Form(
                                  key: homeBloc.formKey,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.search,
                                    controller: homeBloc.searchController,
                                    keyboardType: TextInputType.text,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Enter Valid Value';
                                      }
                                      return null;
                                    },
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                    ),
                                    cursorColor: Colors.black,
                                    onFieldSubmitted: (val) {
                                      homeBloc.add(SearchCountryDataEvent());
                                    },
                                    inputFormatters: [
                                      UpperCaseTextFormatter(),
                                    ],
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[300],
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: const EdgeInsets.all(10),
                                      hintText: 'Search',
                                      hintStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.25),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                BlocBuilder<HomeBloc, HomeState>(
                                  bloc: homeBloc,
                                  buildWhen: (previous, current) {
                                    if (current is SearchCountryRefreshState) {
                                      return true;
                                    }
                                    return false;
                                  },
                                  builder:
                                      (BuildContext context, HomeState state) {
                                    if (homeBloc.isLoading) {
                                      return const Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }

                                    if (homeBloc.country == null) {
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Text(homeBloc.isFirstTime
                                              ? 'Search Country'
                                              : "No data available."),
                                        ),
                                      );
                                    }

                                    Country country = homeBloc.country!;
                                    String? language = '';
                                    if (country.language != null) {
                                      for (int i = 0;
                                          i < country.language!.length;
                                          i++) {
                                        language = language! +
                                            '${country.language![i].name}(${country.language![i].code}), ';
                                      }
                                    }

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            "Country Details",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Card(
                                          color: Colors.grey.shade50,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 10),
                                            child: Column(
                                              children: [
                                                CountryDetailsItem(
                                                  title: 'Name',
                                                  value: country.name,
                                                ),
                                                CountryDetailsItem(
                                                  title: 'Native',
                                                  value: country.native!,
                                                ),
                                                CountryDetailsItem(
                                                  title: 'Capital',
                                                  value: country.capital!,
                                                ),
                                                CountryDetailsItem(
                                                  title: 'Emoji',
                                                  value: country.emoji!,
                                                ),
                                                CountryDetailsItem(
                                                  title: 'Currency',
                                                  value: country.currency!,
                                                ),
                                                if (language != null)
                                                  if (language.isNotEmpty)
                                                    CountryDetailsItem(
                                                      title: 'Languages',
                                                      value: language,
                                                    ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'All Countries',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: homeBloc.countries.length,
                            itemBuilder: (BuildContext context, int index) {
                              Country countryItem = homeBloc.countries[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  countryItem.capital != null
                                      ? Text(countryItem.name +
                                          ' (${countryItem.capital})')
                                      : Text(countryItem.name),
                                  const Divider(),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
