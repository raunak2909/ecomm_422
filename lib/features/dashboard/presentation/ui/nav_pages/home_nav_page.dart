import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomm_422/features/dashboard/presentation/bloc/category/category_bloc.dart';
import 'package:ecomm_422/features/dashboard/presentation/bloc/category/category_event.dart';
import 'package:ecomm_422/features/dashboard/presentation/bloc/category/category_state.dart';
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
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoQigxZ4yA8MVK-3-mjzDrsm1kQZtSX-1N8g&s"
  ];

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(GetAllCategoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 100,
          ),
          Container(
            width: double.infinity,
            height: 200,
            margin: const EdgeInsets.only(left: 11.0, right: 11, top: 80),
            child: CarouselSlider.builder(
                itemCount: mBannerUrls.length,
                itemBuilder: (_, index, _){
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: double.infinity,
                    height: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      image: DecorationImage(image: NetworkImage(mBannerUrls[index]), fit: BoxFit.cover,)
                    ),
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  viewportFraction: 1,
                  autoPlayCurve: Curves.slowMiddle
                )),
          ),
          SizedBox(
            height: 11,
          ),
          SizedBox(
            height: 110,
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if(state is CategoryLoadedState){
                  return ListView.builder(
                      itemCount: state.mCat.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                //backgroundImage: NetworkImage(""),
                              ),
                              Text(state.mCat[index].name ?? "")
                            ],
                          ),
                        );
                      });
                }
               return Container();
              }
            ),
          ),
        ],
      ),
    );
  }
}
