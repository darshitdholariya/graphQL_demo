import 'package:code/api_layer/core/graphQL.dart';
import 'package:code/api_layer/core/queries.dart';
import 'package:code/model/country.dart';
import 'package:graphql/client.dart';

class GetCountryRepo {
  Future<Country?> getCountry(String code) async {
    var result = await client.query(
      QueryOptions(
        document: gql(getCountryQuery),
        variables: {
          "code": code,
        },
      ),
    );

    var json = result.data!["country"];

    if (json == null) {
      return null;
    }

    var country = Country.fromJson(json);
    return country;
  }

  Future<List<Country>> getAllCountries() async {
    var result = await client.query(
      QueryOptions(
        document: gql(getAllCountriesQuery),
      ),
    );
    if (result.hasException) {
      throw result.exception!;
    }
    var json = result.data!["countries"];
    List<Country> countries = [];
    for (var res in json) {
      var country = Country.fromJson(res);
      countries.add(country);
    }
    return countries;
  }
}
