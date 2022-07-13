import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/views/search/widgets/profile_card.dart';
import 'package:taba3ni/views/search/widgets/search_widget.dart';

import '../../providers/data_provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SearchWidget(),
            context.watch<DataProvider>().search.isNotEmpty
                ? SizedBox(
                    width: size.width * 0.91,
                    child: Column(
                      children: context
                          .watch<DataProvider>()
                          .searchUsers
                          .map((user) => UserCard(
                                user: user,
                              ))
                          .toList(),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
