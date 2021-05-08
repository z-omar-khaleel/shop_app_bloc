import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advance_abd/controller/cubit/shop_app_cubit.dart';
import 'package:flutter_advance_abd/controller/cubit/shop_app_states.dart';
import 'package:flutter_advance_abd/model/get_fav.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_advance_abd/model/search_model.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (ShopAppCubit.get(context).shopModelGetFav == null)
          ShopAppCubit.get(context).getFaviourte();
        var fav = null;
        if (ShopAppCubit.get(context).shopModelGetFav != null)
          fav = ShopAppCubit.get(context).shopModelGetFav.data.data ?? null;

        return ConditionalBuilder(
          builder: (c) => ListView.separated(
            itemBuilder: (c, index) => buildFav(fav[index].product),
            separatorBuilder: (c, index) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: Divider(),
            ),
            itemCount: fav.length,
          ),
          condition: ShopAppCubit.get(context).shopModelGetFav != null,
          fallback: (c) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class buildFav extends StatelessWidget {
  final Product product;
  final bool isSearch;
  const buildFav(this.product, {this.isSearch = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image(
                      fit: BoxFit.cover,
                      height: 120,
                      image: NetworkImage(product.image),
                      width: 120,
                    ),
                    if (product.discount != null && !isSearch)
                      Container(
                        color: Colors.red,
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    child: Text(
                      product.name,
                      maxLines: 2,
                      textDirection: TextDirection.ltr,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.3,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        product.price.round().toString(),
                        style: TextStyle(color: Colors.blue),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if (product.discount != null && !isSearch)
                        Text(
                          product.oldPrice.round().toString(),
                          style: TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.bold),
                        ),
                      Spacer(),
                      IconButton(
                        icon: Icon(ShopAppCubit.get(context)
                                .changeFaviourte[product.id]
                            ? Icons.favorite
                            : Icons.favorite_outline_rounded),
                        onPressed: () async {
                          await ShopAppCubit.get(context).changeFav(product.id);
                        },
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
