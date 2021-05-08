import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advance_abd/controller/cubit/observer/search_cubit.dart';
import 'package:flutter_advance_abd/controller/cubit/observer/search_states.dart';
import 'package:flutter_advance_abd/views/widgets/faviourte.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: BlocProvider(
        create: (c) => SearchCubit(InitialStateSearch()),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Builder(
                builder: (context) => TextFormField(
                  controller: searchController,
                  validator: (val) {
                    if (val.isEmpty) return 'Enter Text';
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 1))),
                  onFieldSubmitted: (txt) async {
                    await SearchCubit.get(context).search(txt);
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: BlocConsumer<SearchCubit, SearchStates>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: ConditionalBuilder(
                        fallback: (c) => Center(
                          child: Text('Enter Search Text'),
                        ),
                        condition: state is! LoadingStateSearch &&
                            SearchCubit.get(context).searchResult != null,
                        builder: (c) => ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (c, index) => buildFav(
                                  SearchCubit.get(context)
                                      .searchResult
                                      .data
                                      .data[index],
                                  isSearch: true,
                                ),
                            separatorBuilder: (c, i) => Padding(
                                  padding: EdgeInsets.all(10),
                                ),
                            itemCount: SearchCubit.get(context)
                                .searchResult
                                .data
                                .data
                                .length),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
