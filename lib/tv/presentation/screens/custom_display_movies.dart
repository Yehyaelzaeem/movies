import 'package:flutter/material.dart';
import 'package:movies/movies/presentation/widget/custom_one_movie.dart';
import 'package:movies/tv/presentation/provider/tv_provider.dart';
import 'package:movies/tv/presentation/screens/details_tv.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';
import '../../../constantes/constants.dart';
class CustomDisplayTv extends StatelessWidget {
  final String title;
  final bool isPopular;

  const CustomDisplayTv({super.key,
    required this.title,
    required this.isPopular,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TvProvider>(builder: (context,controllerProvider,child){
      return  WillPopScope(
          onWillPop: (){
            controllerProvider.isSearching=false;
            controllerProvider.textEditingController.text='';
            controllerProvider.listSearchingData=[];
            return Future.value(true);
          },
          child:
          Scaffold(
            backgroundColor: const Color(0xff1E1E29),

            appBar:
            AppBar(
              backgroundColor: const Color(0xff0C0C10),
              toolbarHeight: 50,
              title:
              controllerProvider.isSearching == false ?
              Center(child: Text(title,style: const TextStyle(color: Colors.white,fontSize: 18),),) :
              Center(child: TextField(
                  controller: controllerProvider.textEditingController,
                  onChanged: (value){
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsTv(id:controllerProvider.listSearchingData[i].id)));
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsTv(id:controllerProvider.listSearchingData[i].id)));
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
                  itemCount:isPopular==true?controllerProvider.listTvPopular.length:controllerProvider.listTvTopRated.length ,
                  itemBuilder: (context,i){
                    var year='';
                    try{
                      DateTime dateTime =
                      isPopular==true?
                      DateTime.parse(controllerProvider.listTvPopular[i].date):DateTime.parse(controllerProvider.listTvTopRated[i].date);
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsTv(id: isPopular==true?controllerProvider.listTvPopular[i].id:controllerProvider.listTvTopRated[i].id)));
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
                                      '${AppConstants.imageUrl}${controllerProvider.listTvPopular[i].posterImage}':
                                      '${AppConstants.imageUrl}${controllerProvider.listTvTopRated[i].posterImage}',
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsTv(id:isPopular==true?controllerProvider.listTvPopular[i].id:controllerProvider.listTvTopRated[i].id)));
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
                                                height: constraints.maxHeight*0.1,
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(isPopular==true?
                                                controllerProvider.listTvPopular[i].title:
                                                controllerProvider.listTvTopRated[i].title,style:
                                                const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
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
                                                    isPopular==true?'${controllerProvider.listTvPopular[i].rate}':
                                                    '${controllerProvider.listTvTopRated[i].rate}',
                                                    style:const TextStyle(color: Colors.white,fontSize: 16) ,
                                                  )

                                                ],
                                              ),
                                              SizedBox(
                                                height: constraints.maxHeight*0.07,
                                              ),
                                              Text(
                                                isPopular==true?controllerProvider.listTvPopular[i].description:
                                                controllerProvider.listTvTopRated[i].description,
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
