import 'package:covid_19_tracking/database/country_database.dart';
import 'package:covid_19_tracking/model/country/country.dart';
import 'package:covid_19_tracking/ui/account/account_bloc/authentication_bloc.dart';
import 'package:covid_19_tracking/ui/country_list/country_list_widget/country_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Country> countries = <Country>[];
  bool isLoading = false;

  @override
  void initState() {
    CountryDatabase.instance.database;
    refreshCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Country'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationEventLoggedOut());
            },
          )
        ],
      ),
      body: Center(
        child: countries.isEmpty
            ? const Text(
                'No Favorite Country',
                style: TextStyle(color: Colors.white, fontSize: 24),
              )
            : buildNotes(),
      ),
    );
  }

  Future refreshCountry() async {
    setState(() => isLoading = true);
    countries = await CountryDatabase.instance.readAllCountries();
    setState(() => isLoading = false);
  }

  Widget buildNotes() => ListView.builder(
        itemBuilder: (context, index) {
          final Country country = countries[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/countryDetails', arguments: country);
            },
            child: Dismissible(
              background: Container(
                alignment: AlignmentDirectional.centerEnd,
                color: Colors.red,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              key: Key(country.country),
              direction: DismissDirection.endToStart,
              onDismissed: (_) async {
                // Remove the item from the data source.
                await CountryDatabase.instance.deleteBySlug(country.slug);
                setState(
                  () {
                    countries.removeAt(index);
                  },
                );
                // Then show a snack bar.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${country.country} has remove from favorite'),
                    action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () async {
                          await CountryDatabase.instance.createData(country);
                          refreshCountry();
                        }),
                  ),
                );
              },
              child: CountryCard(
                country: country,
              ),
            ),
          );
        },
        itemCount: countries.length,
      );
}

