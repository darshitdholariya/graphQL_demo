const getCountryQuery = r'''
query getCountry($code:ID!){
  country(code:$code){
    name
    capital
    native
    currency
    emoji
    languages {
      code
      name
    }
  }
}
''';

const getAllCountriesQuery = r'''
query {
  countries{
    name
    capital
    }
  }
''';
