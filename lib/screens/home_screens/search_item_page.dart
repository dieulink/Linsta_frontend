import 'package:flutter/material.dart';
import 'package:linsta_app/screens/home_screens/widgets/app_bar_search.dart';

class SearchItemPage extends StatelessWidget {
  const SearchItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSearch(),
      body: Container(child: Text("searchpage")),
    );
  }
}
