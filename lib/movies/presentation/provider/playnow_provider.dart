import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:movies/movies/domain/entities/movies.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../domain/usecase/getPlayNow.dart';

class PlayNowProvider extends ChangeNotifier{
  TextEditingController textEditingController =TextEditingController();
   List<Movies> listPlayNow=[] ;
   List<Movies> listPopular=[] ;
   List<Movies> listTopRated=[] ;
   List<Movies> listPopularData=[] ;
   List<Movies> listTopRatedData=[] ;
   // List<Movies> listSearchingData=[] ;
   List<Movies> listOnSearching=[] ;

   bool isSearching =false;
   ScrollController scrollController = ScrollController();
   final RefreshController refreshController = RefreshController();
   bool isPopularMovies=true;
   int page=1;


  final GetPlayNowUseCase getPlayNowUseCase;
   PlayNowProvider({required this.getPlayNowUseCase});




//searching *****************************************************
   void chickSearching(){
     isSearching=!isSearching;
     isPopularMovies==true?
     listOnSearching=listPopular:
     listOnSearching=listTopRated;
     notifyListeners();
   }
  Future onSearching(String query, int page)async{
    final data =await getPlayNowUseCase.getSearch(query,page);
    listOnSearching=data;
    notifyListeners();
  }
   // Future searchhing(String movieName)async{
   //    if(movieName.isNotEmpty){
   //      if(isPopularMovies==true){
   //        listSearchingData=(listPopular.where((element) => element.title.toLowerCase().contains(movieName.toLowerCase()))).toList();
   //      }
   //      else{
   //        listSearchingData=(listTopRated.where((element) => element.title.toLowerCase().contains(movieName.toLowerCase()))).toList();
   //      }
   //    }
   //    else{
   //      isPopularMovies==true?
   //      listSearchingData=listPopular:
   //      listSearchingData=listTopRated;
   //
   //    }
   //     notifyListeners();
   // }


//start page run (Play Now && initA )*****************************************
   Future playNow()async{
     final data =await getPlayNowUseCase.execute(page);
     listPlayNow=data;
     notifyListeners();
   }

   void initA(bool isPopular){
     playNow();
     onFirstLoad(isPopular);
     onFirstLoad(!isPopular);
     scrollController = ScrollController()..addListener(onLoading);
     notifyListeners();
   }

// onFirstLoad ***************************************************************
   Future onFirstLoad(bool isPopular)async{
     if(isPopular ==true){
       final data =await getPlayNowUseCase.getPopular(page);
       listPopular=data;
       listPopularData=data;
     }else{
       final data =await getPlayNowUseCase.getTopRated(page);
       listTopRated=data;
       listTopRatedData=data;
     }
     notifyListeners();
   }

// onLoading ***************************************************************
   Future onLoading()async{
     if(scrollController.position.maxScrollExtent<=scrollController.position.pixels){
       page+=1;
       if(isPopularMovies ==true){
         try{
           final data1 =await getPlayNowUseCase.getPopular(page);
           if(data1.isEmpty){
             refreshController.resetNoData();
           }
           else{
             listPopular.addAll(data1);
             refreshController.refreshCompleted();
           }
         }catch(e){
           // print('$e');
         }
       }
       else{
         try{
           final data2 =await getPlayNowUseCase.getTopRated(page);
           if(data2.isEmpty){
             refreshController.resetNoData();
           }
           else{
             listTopRated.addAll(data2);
             refreshController.refreshCompleted();
           }
         }catch(e){
           // print('$e');
         }
       }
     }
     notifyListeners();
   }

// onRefresh ***************************************************************
  Future onRefresh()async{
    final  random =Random();
    final  r = random.nextInt(50);
    r==0?page=1:
    page =r;
    if(isPopularMovies ==true){
      final data =await getPlayNowUseCase.getPopular(page);
      listPopular=data;

    }else{
      final data =await getPlayNowUseCase.getTopRated(page);
      listTopRated=data;

    }
    refreshController.resetNoData();
    refreshController.refreshCompleted();
    notifyListeners();
  }

}