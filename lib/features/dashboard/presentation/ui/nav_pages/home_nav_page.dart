import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomm_422/features/dashboard/presentation/bloc/category/category_bloc.dart';
import 'package:ecomm_422/features/dashboard/presentation/bloc/category/category_event.dart';
import 'package:ecomm_422/features/dashboard/presentation/bloc/category/category_state.dart';
import 'package:ecomm_422/features/dashboard/presentation/bloc/product/product_bloc.dart';
import 'package:ecomm_422/features/dashboard/presentation/bloc/product/product_event.dart';
import 'package:ecomm_422/features/dashboard/presentation/bloc/product/product_state.dart';
import 'package:ecomm_422/features/detail/presentation/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNavPage extends StatefulWidget {
  @override
  State<HomeNavPage> createState() => _HomeNavPageState();
}

class _HomeNavPageState extends State<HomeNavPage> {
  List<String> mBannerUrls = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShU5RGj0QW-aK-Aqe-_BpNB8EiJw6pZkwgtw&s",
    "https://static.vecteezy.com/system/resources/previews/014/295/515/non_2x/end-of-year-sale-banner-template-design-big-sale-event-on-red-background-social-media-shopping-online-vector.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoQigxZ4yA8MVK-3-mjzDrsm1kQZtSX-1N8g&s",
  ];

  List<Color> mColors = [
    Colors.black,
    Colors.blue,
    Colors.orange,
    Colors.red,
    Colors.black,
    Colors.blue,
    Colors.orange,
    Colors.red,
  ];

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(GetAllCategoryEvent());
    context.read<ProductBloc>().add(FetchAllProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(width: double.infinity, height: 100),
          Container(
            width: double.infinity,
            height: 200,
            margin: const EdgeInsets.only(left: 11.0, right: 11, top: 80),
            child: CarouselSlider.builder(
              itemCount: mBannerUrls.length,
              itemBuilder: (_, index, _) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: double.infinity,
                  height: 210,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    image: DecorationImage(
                      image: NetworkImage(mBannerUrls[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: true,
                viewportFraction: 1,
                autoPlayCurve: Curves.slowMiddle,
              ),
            ),
          ),
          SizedBox(height: 11),
          SizedBox(
            height: 110,
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryErrorState) {
                  return Center(child: Text(state.errorMsg));
                }
                print("state : $state");
                if (state is CategoryLoadedState) {
                  return ListView.builder(
                    itemCount: state.mCat.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                "https://cdn.jhattse.com/resize?width=384&file=images/category/electronics.png&quality=75&type=webp",
                              ),
                            ),
                            Text(state.mCat[index].name ?? ""),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
          SizedBox(height: 11),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Special for you",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text("See more"),
              ],
            ),
          ),
          SizedBox(height: 11),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductErrorState) {
                  return Center(child: Text(state.errorMsg));
                }
                print("state : $state");
                if (state is ProductLoadedState) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 11,
                        crossAxisSpacing: 11,
                        childAspectRatio: 8 / 9,
                      ),
                      itemCount: state.allProduct.length,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  currProduct : state.allProduct[index]
                                ),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          state.allProduct[index].image ??
                                              "https://cdn.jhattse.com/resize?width=384&file=images/category/electronics.png&quality=75&type=webp",
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                      Text(
                                        state.allProduct[index].name ?? "",
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "₹ ${state.allProduct[index].price ?? ""}",
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          mColors.length > 4
                                              ? Row(
                                                  children: List.generate(4, (
                                                    index,
                                                  ) {
                                                    if (index == 3) {
                                                      return Container(
                                                        margin: EdgeInsets.only(
                                                          left: 2,
                                                        ),
                                                        width: 20,
                                                        height: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                        child: Center(
                                                          child: Text(
                                                            "+${mColors.length - 3}",
                                                            style: TextStyle(
                                                              fontSize: 11,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return Container(
                                                        margin: EdgeInsets.only(
                                                          left: 2,
                                                        ),
                                                        width: 20,
                                                        height: 20,
                                                        decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color:
                                                                mColors[index],
                                                          ),
                                                        ),
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.all(1),
                                                          decoration:
                                                              BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color:
                                                                    mColors[index],
                                                              ),
                                                        ),
                                                      );
                                                    }
                                                  }),
                                                )
                                              : Row(
                                                  children: List.generate(
                                                    mColors.length,
                                                    (index) {
                                                      return Container(
                                                        margin: EdgeInsets.only(
                                                          left: 2,
                                                        ),
                                                        width: 20,
                                                        height: 20,
                                                        decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color:
                                                                mColors[index],
                                                          ),
                                                        ),
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.all(1),
                                                          decoration:
                                                              BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color:
                                                                    mColors[index],
                                                              ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.deepOrangeAccent,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(25),
                                        bottomLeft: Radius.circular(11),
                                      ),
                                    ),
                                    width: 45,
                                    height: 45,
                                    child: Center(
                                      child: Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
