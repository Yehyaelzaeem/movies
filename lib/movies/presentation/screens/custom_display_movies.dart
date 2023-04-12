import 'package:flutter/material.dart';
import 'package:movies/movies/presentation/provider/playnow_provider.dart';
import 'package:movies/movies/presentation/widget/custom_one_movie.dart';
import 'package:movies/tv/presentation/provider/tv_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';
import '../../../constantes/constants.dart';
import '../../../core/services/services_locator.dart';
import 'details.dart';
class CustomDisplayMovies extends StatelessWidget {
  final String title;
  final bool isPopular;
  const CustomDisplayMovies({super.key,
    required this.title,
    required this.isPopular,
  });

  @override
  Widget build(BuildContext context) {
    sl<PlayNowProvider>().isPopularMovies=isPopular;
    return Consumer<PlayNowProvider>(builder: (context,controllerProvider,child){
      return  WillPopScope(
           onWillPop: (){
             controllerProvider.isSearching=false;
             controllerProvider.textEditingController.text='';
             controllerProvider.listSearchingData=[];
             return Future.value(true);
           },
          child:
          Scaffold(
            appBar: AppBar(

              backgroundColor: const Color(0xff0C0C10),
              toolbarHeight: 50,
              title:
              controllerProvider.isSearching == false
                  ? Center(child: Text(title,style: const TextStyle(color: Colors.white,fontSize: 18),),)
                  :   Center(
                child: TextField(
                  controller: controllerProvider.textEditingController,
                  onChanged: (value){
                    print(value);
                    controllerProvider.searching(value);
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: ' Search.....',
                    hintStyle: TextStyle(color: Colors.white54),
                  ),

                ),
              ),
              actions: [
                IconButton(onPressed: (){
                  controllerProvider.chickSearching();
                  controllerProvider.textEditingController.text='';
                }, icon: controllerProvider.isSearching==false?const Icon(Icons.search):const Icon(Icons.clear))

              ],
            ),
            backgroundColor: const Color(0xff1E1E29),
            body:controllerProvider.isSearching==true?
            SmartRefresher(
              enablePullUp: true,
              enablePullDown:true,
              onRefresh: controllerProvider.onRefresh,
              scrollController: controllerProvider.scrollController,
              scrollDirection: Axis.vertical,
              onLoading: controllerProvider.onLoading,
              controller: controllerProvider.refreshController,
              child:
              ListView.builder(
                  itemCount:controllerProvider.listSearchingData.length ,
                  itemBuilder: (context,i){
                    var year='';
                    try{
                      DateTime dateTime =
                      DateTime.parse(controllerProvider.listSearchingData[i].date);
                      year= DateFormat.y().format((dateTime));
                    }catch(e){
                      year='';
                      print('$e');
                    }
                    return
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0,left: 5,right: 5),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsMovies(id:controllerProvider.listSearchingData[i].id)));
                          },
                          child:
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xff303030),
                                borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            height:( MediaQuery.of(context).size.height-15)/5,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 2,),
                                SizedBox(
                                  height: ( MediaQuery.of(context).size.height-15)/5 -5,
                                  child: CustomOneMovie(
                                      image:
                                      '${AppConstants.imageUrl}${controllerProvider.listSearchingData[i].posterImage}',
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsMovies(id:controllerProvider.listSearchingData[i].id)));
                                      }),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: LayoutBuilder(
                                      builder: (ctx ,constraints ) {
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: constraints.maxHeight*0.15,
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  controllerProvider.listSearchingData[i].title,style:
                                                const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    overflow: TextOverflow.ellipsis
                                                ),),
                                              ),
                                              SizedBox(
                                                height: constraints.maxHeight*0.07,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.red[300],
                                                        borderRadius: const BorderRadius.all(Radius.circular(5))
                                                    ),
                                                    width: constraints.maxWidth*0.2,
                                                    height: constraints.maxHeight*0.2,
                                                    child: Center(
                                                      child: Text(year,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: constraints.maxWidth*0.1,),
                                                  const Icon(Icons.star,size: 25,color: Colors.yellow,),
                                                  SizedBox(width: constraints.maxWidth*0.02,),
                                                  Text(
                                                    '${controllerProvider.listSearchingData[i].rate}',
                                                    style:const TextStyle(color: Colors.white,fontSize: 16) ,
                                                  )

                                                ],
                                              ),
                                              SizedBox(
                                                height: constraints.maxHeight*0.07,
                                              ),
                                              Text(

                                                controllerProvider.listSearchingData[i].description,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    overflow: TextOverflow.ellipsis
                                                ),
                                                maxLines: 2,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                  }),

            ):
            SmartRefresher(
              enablePullUp: true,
              enablePullDown:true,
              onRefresh: controllerProvider.onRefresh,
              scrollController: controllerProvider.scrollController,
              scrollDirection: Axis.vertical,
              onLoading: controllerProvider.onLoading,
              controller: controllerProvider.refreshController,
              child:
              ListView.builder(
                  itemCount:isPopular==true?controllerProvider.listPopular.length:controllerProvider.listTopRated.length ,
                  itemBuilder: (context,i){
                    var year='';
                    try{
                      DateTime dateTime =
                      isPopular==true?
                      DateTime.parse(controllerProvider.listPopular[i].date):DateTime.parse(controllerProvider.listTopRated[i].date);
                      year= DateFormat.y().format((dateTime));
                    }catch(e){
                      year='';
                      print('$e');
                    }
                    return
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0,left: 5,right: 5),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsMovies(id: isPopular==true?controllerProvider.listPopular[i].id:controllerProvider.listTopRated[i].id)));
                          },
                          child:
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xff303030),
                                borderRadius: BorderRadius.all(Radius.circular(15))
                            ),
                            height:( MediaQuery.of(context).size.height-15)/5,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 2,),
                                SizedBox(
                                  height: ( MediaQuery.of(context).size.height-15)/5 -5,
                                  child: CustomOneMovie(
                                      image:isPopular==true?
                                      '${AppConstants.imageUrl}${controllerProvider.listPopular[i].posterImage}':
                                      '${AppConstants.imageUrl}${controllerProvider.listTopRated[i].posterImage}',
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsMovies(id:isPopular==true?controllerProvider.listPopular[i].id:controllerProvider.listTopRated[i].id)));
                                      }),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: LayoutBuilder(
                                      builder: (ctx ,constraints ) {
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: constraints.maxHeight*0.15,
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(isPopular==true?
                                                controllerProvider.listPopular[i].title:
                                                controllerProvider.listTopRated[i].title,style:
                                                const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    overflow: TextOverflow.ellipsis
                                                ),),
                                              ),
                                              SizedBox(
                                                height: constraints.maxHeight*0.07,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.red[300],
                                                        borderRadius: const BorderRadius.all(Radius.circular(5))
                                                    ),
                                                    width: constraints.maxWidth*0.2,
                                                    height: constraints.maxHeight*0.2,
                                                    child: Center(
                                                      child: Text(year,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: constraints.maxWidth*0.1,),
                                                  const Icon(Icons.star,size: 25,color: Colors.yellow,),
                                                  SizedBox(width: constraints.maxWidth*0.02,),
                                                  Text(
                                                    isPopular==true?'${controllerProvider.listPopular[i].rate}':
                                                    '${controllerProvider.listTopRated[i].rate}',
                                                    style:const TextStyle(color: Colors.white,fontSize: 16) ,
                                                  )

                                                ],
                                              ),
                                              SizedBox(
                                                height: constraints.maxHeight*0.07,
                                              ),
                                              Text(
                                                isPopular==true?controllerProvider.listPopular[i].description:
                                                controllerProvider.listTopRated[i].description,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    overflow: TextOverflow.ellipsis
                                                ),
                                                maxLines: 2,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                  }),

            ),
          ));


    });
  }
}
