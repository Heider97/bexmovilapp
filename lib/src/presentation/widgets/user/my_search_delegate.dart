/* import 'package:bexmovil/src/config/theme/index.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_back_button.dart';
import 'package:bexmovil/src/presentation/widgets/user/search_item.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/search_result.dart';

class MySearchDelegate extends SearchDelegate<SearchResult> {
  MySearchDelegate();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return AppTheme.light.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(Const.padding),
      child: CustomBackButton(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query == ''
        ? const Text("Enter your address")
        : Column(mainAxisSize: MainAxisSize.min, children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (_, index) {
                  return BuildSearchItem(
                    searchResult: SearchResult(title: 'User', type: 'user'),
                  );
                })
          ]);
  }
}
 */