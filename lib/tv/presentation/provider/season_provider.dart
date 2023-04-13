import 'package:flutter/cupertino.dart';
import 'package:movies/tv/domain/use_cases/seasons_usecase.dart';
import '../../data/models/seasons_tv.dart';

class SeasonProvider extends ChangeNotifier{
  final SeasonUseCase seasonUseCase;
  SeasonProvider({required this.seasonUseCase});

  List<SeasonsModel> listSeason=[];
  bool isOk =false;
  bool isChick=true;

  void chan(){
    isChick=false;
    notifyListeners();
  }
  void chan2(){
    isChick=true;
    notifyListeners();
  }

  void getData(int id,int r,String lang)async{
   getSeasonsData(id,r,lang);
     isOk =true;
    notifyListeners();
  }

  Future getSeasonsData(int id ,int seasonNumber,String lang)async{
    listSeason.clear();
    String l='en';
    if(lang =='ar'){
      l='ar';
    }
    for(int i=1;i<=seasonNumber;i++){
      final data =await seasonUseCase.getSeasonData(id, i,l);
       listSeason.add(data);
    }
    notifyListeners();
  }

}