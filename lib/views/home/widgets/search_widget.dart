import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taba3ni/constant/const.dart';
import 'package:taba3ni/providers/data_provider.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.width * 0.09),
      width: size.width * 0.9,
      height: 60,
      child: Center(
        child: TextFormField(
          onFieldSubmitted: (val) {},
          controller: context.watch<DataProvider>().searchController,
          onChanged: (String value) =>
              context.read<DataProvider>().updateSearch(value),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: textbody1,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            hintText: "Search...",
            hintStyle: textbody1,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white60,
            ),
            suffixIcon: context.watch<DataProvider>().search.isNotEmpty
                ? InkWell(
                    onTap: () =>
                        context.read<DataProvider>().clearSearch(context),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white60,
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
