import 'package:ecomm_422/core/constants/app_urls.dart';
import 'package:ecomm_422/core/services/api_service.dart';
import 'package:ecomm_422/features/dashboard/data/models/product_model.dart';
import 'package:ecomm_422/features/dashboard/presentation/bloc/product/product_event.dart';
import 'package:ecomm_422/features/dashboard/presentation/bloc/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState>{
  APIService apiService;

  ProductBloc({required this.apiService}) : super(ProductInitialState()){
    on<FetchAllProductEvent>((event, emit) async{
      emit(ProductLoadingState());

      try{

        var response = await apiService.postAPI(url: AppUrls.product_url);
        if(response["status"]){
          List<ProductModel> mProducts = [];
          List<dynamic> data = response["data"];

          for(Map<String, dynamic> eachMap in data){
            mProducts.add(ProductModel.fromJson(eachMap));
          }

          emit(ProductLoadedState(allProduct: mProducts));
          
        } else {
          emit(ProductErrorState(errorMsg: response["message"]));
        }

      } catch (e){
        emit(ProductErrorState(errorMsg: e.toString()));
      }

    });
  }
}