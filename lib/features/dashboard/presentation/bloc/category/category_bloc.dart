import 'package:ecomm_422/core/services/api_service.dart';
import 'package:ecomm_422/features/dashboard/data/models/cat_model.dart';
import 'package:ecomm_422/features/dashboard/presentation/bloc/category/category_event.dart';
import 'package:ecomm_422/features/dashboard/presentation/bloc/category/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_urls.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState>{
  APIService apiService;
  CategoryBloc({required this.apiService}) : super(CategoryInitialState()){

    on<GetAllCategoryEvent>((event, emit) async{

      emit(CategoryLoadingState());

      try {

        var responseBody = await apiService.getAPI(url: AppUrls.cat_url);
        if(responseBody["status"]){
          print(responseBody["data"]);
          List<Map<String, dynamic>> mCatMap = responseBody["data"];
          List<CatModel> mCatModel = [];

          for(Map<String, dynamic> eachMap in mCatMap){
            mCatModel.add(CatModel.fromJson(eachMap));
          }

          emit(CategoryLoadedState(mCat: mCatModel));


        } else {
          emit(CategoryErrorState(errorMsg: responseBody["message"]));
        }


      } catch (e) {
        emit(CategoryErrorState(errorMsg: e.toString()));
      }

    });


  }

}