import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:movies/tv/domain/use_cases/tv_usecase.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../data/models/details_tv_model.dart';
import '../../domain/entities/tv.dart';

class TvProvider extends ChangeNotifier{
  List<Tv> listOnTheAir=[] ;
  List<Tv> listTvPopular=[] ;
  List<Tv> listTvTopRated=[] ;
  List<Tv> listTvPopularDate=[] ;
  List<Tv> listTvTopRatedDate=[] ;
  List<Tv> listSearchingData=[] ;
  List<DetailsModelTv> getDetailsList=[] ;
  TextEditingController textEditingController =TextEditingController();
  ScrollController scrollController = ScrollController();
  final RefreshController refreshController = RefreshController();
  bool isSearching =false;
  int page=1;
  bool isPopularTv=true;


  final TvUseCase tvUseCase;
  TvProvider({required this.tvUseCase});


//Searching************************************************
  void chickSearching(){
    isSearching=!isSearching;
    isPopularTv==true?
    listSearchingData=listTvPopular:
    listSearchingData=listTvTopRated;
    notifyListeners();
  }

  Future searching(String movieName)async{
    if(movieName.isNotEmpty){
      if(isPopularTv==true){
        listSearchingData=(listTvPopular.where((element) => element.title.toLowerCase().contains(movieName.toLowerCase()))).toList();
      }
      else{
        listSearchingData=(listTvTopRated.where((element) => element.title.toLowerCase().contains(movieName.toLowerCase()))).toList();
      }
    }
    else{
      isPopularTv==true?
      listSearchingData=listTvPopular:
      listSearchingData=listTvTopRated;
    }
    notifyListeners();
  }

//Start running Function  **********************************
  Future getOnTheAir()async{
    final data =await tvUseCase.getOnTheAir();
    listOnTheAir=data;
    notifyListeners();
  }

  void init(bool isPopular){
    getOnTheAir();
    onFirstLoad(isPopular);
    onFirstLoad(!isPopular);
    scrollController = ScrollController()..addListener(onLoading);
    notifyListeners();
  }

//onFirstLoad***********************************************
  Future onFirstLoad(bool isPopular)async{
    if(isPopular ==true){
      final data =await tvUseCase.getTvPopular(page);
      listTvPopular=data;
      listTvPopularDate=data;
    }else{
      final data =await tvUseCase.getTvTopRated(page);
      listTvTopRated=data;
      listTvTopRatedDate=data;
    }
    notifyListeners();
  }

//onLoading***********************************************
  Future onLoading()async{
     if(scrollController.position.maxScrollExtent<=scrollController.position.pixels){
      page+=1;
      if(isPopularTv ==true){
      try{
        final data1 =await tvUseCase.getTvPopular(page);
        if(data1.isEmpty){
          refreshController.resetNoData();
        }
        else{
          listTvPopular.addAll(data1);
          refreshController.refreshCompleted();
        }
      }catch(e){
        // print('eeeeeeeeeeeeeeeeeee$e');
      }
    }
      else{
        try{
          final data2 =await tvUseCase.getTvTopRated(page);
          if(data2.isEmpty){
            refreshController.resetNoData();
          }
          else{
            listTvTopRated.addAll(data2);
            refreshController.refreshCompleted();
          }
        }catch(e){
          // print('eeeeeeeeeeeeeeeeeee$e');
        }
      }
    }
    notifyListeners();
  }

//onRefresh***********************************************
  Future onRefresh()async{
    final  random =Random();
    final  r = random.nextInt(50);
    r==0?page=1:
    page =r;
    if(isPopularTv ==true){
      final data =await tvUseCase.getTvPopular(page);
      listTvPopular=data;

    }else{
      final data =await tvUseCase.getTvTopRated(page);
      listTvTopRated=data;

    }
    refreshController.resetNoData();
    refreshController.refreshCompleted();
    notifyListeners();
  }

//getDetails***********************************************
  Future getDetails(int id)async{
    getDetailsList.clear();
    final data =await tvUseCase.getTvDetails(id);
    getDetailsList.add(data);
    notifyListeners();
  }

}