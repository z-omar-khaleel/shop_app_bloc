import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advance_abd/controller/cubit/shop_app_cubit.dart';
import 'package:flutter_advance_abd/controller/cubit/shop_app_states.dart';
import 'package:flutter_advance_abd/model/shop_model_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final shopModel = ShopAppCubit.get(context).shopModelCategory;
        return ConditionalBuilder(
          condition: shopModel != null && !(state is CategoryPageErrorState),
          builder: (c) {
            return ListView.separated(
              itemBuilder: (c, i) => buildCat(shopModel.data.data[i]),
              itemCount: shopModel.data.data.length,
              separatorBuilder: (c, i) => SizedBox(
                height: 10,
              ),
            );
          },
          fallback: (c) => state is CategoryPageErrorState
              ? Center(
                  child: Text(state.message),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }

  Widget buildCat(Datum data) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Image(
            image: NetworkImage(data.image),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 17,
          ),
          Text(
            data.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }
}
