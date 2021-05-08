import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advance_abd/controller/cubit/shop_app_cubit.dart';
import 'package:flutter_advance_abd/controller/cubit/shop_app_states.dart';
import 'package:flutter_advance_abd/model/shop_model_category.dart';
import 'package:flutter_advance_abd/model/shop_model_home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is InternetConnectSuccess ||
            state is ChangeCurrentIndexState) {
          ShopAppCubit.get(context).getCategoryData();
          ShopAppCubit.get(context).getHomeData();
        }
        if (state is ChangeFavDataState) {
          Fluttertoast.showToast(
              msg: state.dataState.message,
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        final home = ShopAppCubit.get(context).shopModelHome;
        final cat = ShopAppCubit.get(context).shopModelCategory;
        return ConditionalBuilder(
          condition:
              home != null && cat != null && !(state is HomePageErrorState),
          builder: (context) {
            return productsBuilder(home, cat, context);
          },
          fallback: (context) => state is HomePageErrorState
              ? Center(
                  child: Text(state.message),
                )
              : state is CategoryPageErrorState
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

  Widget productsBuilder(ShopModelHome shop, ShopModelCategory cat, context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CarouselSlider(
              items: shop.data.banners
                  .map((banner) => Image(
                        image: NetworkImage(banner.image),
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ))
                  .toList(),
              options: CarouselOptions(
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.easeOut,
                  height: 250,
                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1)),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 150,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          bulidCategory(cat.data.data[index], context),
                      separatorBuilder: (c, i) => SizedBox(
                            width: 7,
                          ),
                      itemCount: cat.data.data.length),
                ),
                SizedBox(
                  height: 20,
                ),
                const Text(
                  'Products',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey.withOpacity(.5),
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(shop.data.products.length,
                  (index) => buildGrid(shop.data.products[index], context)),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1 / 1.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGrid(Product product, context) {
    return Container(
      height: 250,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    height: 200,
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      product.image,
                    ),
                    width: double.infinity,
                  ),
                  if (product.discount != null)
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                SizedBox(
                  height: 10,
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
                    if (product.discount != null)
                      Text(
                        product.oldPrice.round().toString(),
                        style: TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.bold),
                      ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                          ShopAppCubit.get(context).changeFaviourte[product.id]
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
          ),
        ],
      ),
    );
  }

  Widget bulidCategory(Datum cat, context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width * .45,
      color: Colors.black87,
      child: GridTile(
        child: Image(
          fit: BoxFit.cover,
          image: NetworkImage(cat.image),
        ),
        footer: GridTileBar(
          title: Text(
            cat.name,
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          backgroundColor: Colors.black87.withOpacity(.6),
        ),
      ),
    );
  }
}
