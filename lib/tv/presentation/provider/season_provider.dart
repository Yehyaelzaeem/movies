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

  void getData(int id,int r)async{
   getSeasonsData(id,r);
     isOk =true;
    notifyListeners();
  }

  Future getSeasonsData(int id ,int seasonNumber)async{
    listSeason.clear();
    for(int i=1;i<=seasonNumber;i++){
      final data =await seasonUseCase.getSeasonData(id, i);
       listSeason.add(data);
    }
    notifyListeners();
  }

}