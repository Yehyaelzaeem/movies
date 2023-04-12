import 'package:flutter/material.dart';
import 'package:movies/constantes/constants.dart';
import 'package:movies/movies/presentation/widget/custom_one_movie.dart';
import 'package:movies/tv/presentation/provider/season_provider.dart';
import 'package:movies/tv/presentation/provider/tv_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/services/services_locator.dart';
import '../provider/like_this.dart';
import 'package:intl/intl.dart';

class DetailsTv extends StatefulWidget {
  final int id;
  const DetailsTv({super.key, required this.id});

  @override
  State<DetailsTv> createState() => _DetailsMoviesState();
}

class _DetailsMoviesState extends State<DetailsTv>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    Provider.of<DetailsProviderTv>(context, listen: false).getLikeThisMovies(widget.id);
    Provider.of<TvProvider>(context, listen: false).getDetails(widget.id);
    Provider.of<SeasonProvider>(context, listen: false).getSeasonsData(widget.id,1);
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
     WillPopScope(onWillPop: () {
       sl<SeasonProvider>().chan2();
       return Future.value(true);
     },
     child:  Scaffold(
       backgroundColor: const Color(0xff1E1E29),
       body: Consumer<TvProvider>(builder: (context, controller, child) {
         if (controller.getDetailsList.isEmpty ||
             controller.getDetailsList == []) {
           return const Center(
             child: CircularProgressIndicator(),
           );
         } else {
           double r = controller.getDetailsList[0].rate;
           String newRate = r.toStringAsFixed(1);
           String date = controller.getDetailsList[0].date;
           int seasonNumber = controller.getDetailsList[0].seasonNumber;
           String season = '${seasonNumber.toString()[0]} Season';
           var year = '';
           try {
             DateTime dateTime = DateTime.parse(date);
             year = DateFormat.y().format((dateTime));
           } catch (e) {
             year = '';
           }
           return SingleChildScrollView(
             child: Column(
               children: [
                 SizedBox(
                     height: MediaQuery.of(context).size.height * 0.38,
                     width: MediaQuery.of(context).size.width,
                     child: Image.network(
                       "${AppConstants.imageUrl}${controller.getDetailsList[0].image}",
                       fit: BoxFit.cover,
                     )),
                 Container(
                   margin: const EdgeInsets.only(left: 10, top: 10),
                   alignment: Alignment.centerLeft,
                   child: Text(
                     controller.getDetailsList[0].title,
                     style: const TextStyle(
                         color: Colors.white,
                         fontSize: 28,
                         fontWeight: FontWeight.bold),
                   ),
                 ),
                 SizedBox(
                   height: MediaQuery.of(context).size.width * 0.03,
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     const SizedBox(width: 10,),
                     Container(
                       alignment: Alignment.centerLeft,
                       decoration: const BoxDecoration(
                           color: Color(0xff424242),
                           borderRadius: BorderRadius.all(Radius.circular(5))),
                       width: MediaQuery.of(context).size.width * 0.16,
                       height: MediaQuery.of(context).size.height * 0.04,
                       child: Center(
                         child: Text(year,
                           style: const TextStyle(
                               color: Colors.white,
                               fontSize: 15,
                               fontWeight: FontWeight.bold),
                         ),
                       ),
                     ),
                     SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                     const Icon(Icons.star, size: 25, color: Colors.yellow,),
                     const SizedBox(width: 1,),
                     Text(
                       newRate,
                       style:
                       const TextStyle(color: Colors.white, fontSize: 16),
                     ),
                     SizedBox(
                       width: MediaQuery.of(context).size.width * 0.01,
                     ),
                     const Text(
                       '-----',
                       style: TextStyle(color: Colors.white24, fontSize: 8),
                     ),
                     SizedBox(
                       width: MediaQuery.of(context).size.width * 0.01,
                     ),
                     Text(
                       season,
                       style: const TextStyle(
                           color: Colors.white70, fontSize: 16),
                     ),
                     SizedBox(
                       width: MediaQuery.of(context).size.width * 0.001,
                     ),
                     Text(
                       '${controller.getDetailsList[0].numberEpisodes} Episodes',
                       style: const TextStyle(
                           color: Colors.white70, fontSize: 16),
                       overflow: TextOverflow.ellipsis,
                     ),
                     SizedBox(
                       width: MediaQuery.of(context).size.width * 0.02,
                     ),
                   ],
                 ),
                 SizedBox(
                   height: MediaQuery.of(context).size.width * 0.06,
                 ),
                 Container(
                   margin: const EdgeInsets.symmetric(horizontal: 10),
                   child: Text(
                     controller.getDetailsList[0].description,
                     style: const TextStyle(color: Colors.white, fontSize: 16),
                   ),
                 ),
                 SizedBox(
                   height: MediaQuery.of(context).size.width * 0.03,
                 ),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const SizedBox(
                       width: 10,
                     ),
                     const Text(
                       'Genres:  ',
                       style: TextStyle(color: Colors.white70, fontSize: 15),
                     ),
                     SizedBox(
                       width: MediaQuery.of(context).size.width * 0.7,
                       height: MediaQuery.of(context).size.height * 0.03,
                       child: ListView.builder(
                           scrollDirection: Axis.horizontal,
                           itemCount:
                           controller.getDetailsList[0].genres.length,
                           itemBuilder: (context, i) {
                             return Text(
                                 "${controller.getDetailsList[0].genres[i].name}${i == controller.getDetailsList[0].genres.length - 1 ? '' : ","} ",
                                 style: const TextStyle(
                                     color: Colors.white70, fontSize: 15));
                           }),
                     ),
                   ],
                 ),
                 SizedBox(
                   height: MediaQuery.of(context).size.height * 0.01,
                 ),
                 SizedBox(
                   height: 50,
                   width: MediaQuery.of(context).size.width,
                   child: DefaultTabController(
                     length: 2,
                     child: TabBar(
                       controller: _tabController,
                       onTap: (d){
                         if(d ==1){
                           sl<SeasonProvider>().chan();
                           int r=sl<TvProvider>().getDetailsList[0].seasonNumber;
                           sl<SeasonProvider>().getData(widget.id,r);
                         }
                         else if(d==0){
                           sl<SeasonProvider>().chan2();
                         }
                       },
                       unselectedLabelColor: Colors.grey[600],
                       labelColor: Colors.white,
                       tabs: const [
                         Tab(
                           text: 'MORE LIKE THIS',
                         ),
                         Tab(
                           text: 'EPISODES',
                         ),
                       ],
                       // controller: _tabController,
                       indicatorSize: TabBarIndicatorSize.tab,
                       indicatorColor: Colors.red[300],
                     ),
                   ),
                 ),

                 //another part********************
                 Consumer<SeasonProvider>(builder: (context,c,child){
                   int l = sl<DetailsProviderTv>().listLikeThis.length;
                   return c.listSeason.isEmpty? const Center(child: CircularProgressIndicator(),):
                   SizedBox(
                     height:
                     c.isChick==false?((MediaQuery.of(context).size.height*0.275)*(c.listSeason[0].episode!.length)*seasonNumber):
                     (l.isOdd ? ((MediaQuery.of(context).size.height * 0.088) * ((l))) : ((MediaQuery.of(context).size.height * 0.098) * ((l)))),
                     child:
                     TabBarView(controller: _tabController, children: <Widget>
                     [
                       Consumer<DetailsProviderTv>(builder: (context, c, child) {
                         return LayoutBuilder(builder: (cxt, constraints) {
                           if (c.listLikeThis.isEmpty || c.listLikeThis == []) {
                             return const Center(
                               child: CircularProgressIndicator(),);
                           }
                           else {
                             return Container(
                               margin: const EdgeInsets.only(left: 10, right: 10),
                               width: MediaQuery.of(context).size.width,
                               child: GridView.builder(
                                 gridDelegate:
                                 const SliverGridDelegateWithFixedCrossAxisCount(
                                   crossAxisCount: 3,
                                   crossAxisSpacing: 2,
                                   mainAxisSpacing: 3,
                                   childAspectRatio: 3 / 5,
                                 ),
                                 physics: const NeverScrollableScrollPhysics(),
                                 itemCount: c.listLikeThis.length,
                                 itemBuilder: (context, i) {
                                   if (c.listLikeThis[i].image == null) {
                                     return const Center(
                                       child: CircularProgressIndicator(),
                                     );
                                   } else {
                                     return CustomOneMovie(
                                         image:
                                         '${AppConstants.imageUrl}${c.listLikeThis[i].image}',
                                         onTap: () {
                                           Navigator.pushReplacement(
                                               context,
                                               MaterialPageRoute(
                                                   builder: (context) => DetailsTv(
                                                       id: c.listLikeThis[i].id)));
                                         });
                                   }
                                 },
                               ),
                             );
                           }
                         });
                       }),
                       c.isOk==false? const Center(child: CircularProgressIndicator(),):
                       Padding(
                           padding:
                           const EdgeInsets.only(top: 10, left: 5, right: 5),
                           child:
                           ListView.builder(
                               physics: const NeverScrollableScrollPhysics(),
                               itemCount: seasonNumber,
                               itemBuilder: (context ,index){
                                 return
                                   Padding(
                                     padding: const EdgeInsets.only(top: 20.0),
                                     child: SizedBox(
                                       height: (MediaQuery.of(context).size.height*0.275)*(c.listSeason[0].episode!.length),
                                       child:
                                       Column(
                                         children: [
                                           Container(
                                             height: 60,
                                             decoration: const BoxDecoration(
                                                 color: Color(0xff303030),
                                                 borderRadius:
                                                 BorderRadius.all(Radius.circular(10))),
                                             child:  ExpansionTile(
                                               title: Text(
                                                 'Season ${index+1}',
                                                 style: const TextStyle(
                                                     color: Colors.white,
                                                     fontWeight: FontWeight.bold),
                                               ),
                                             ),
                                           ),
                                           Expanded(
                                             child: Padding(
                                               padding: const EdgeInsets.only(top: 18.0,bottom: 0),
                                               child: ListView.builder(
                                                 physics: const NeverScrollableScrollPhysics(),
                                                 itemBuilder: (BuildContext context, int i) {
                                                   var d=  c.listSeason[index].episode![i];
                                                   return Padding(
                                                     padding: const EdgeInsets.all(8.0),
                                                     child: Padding(
                                                       padding: const EdgeInsets.only(
                                                           left: 3.0, right: 3),
                                                       child: Container(
                                                         height: 200,
                                                         color:  const Color(0xff1E1E29),
                                                         child: Column(
                                                           crossAxisAlignment: CrossAxisAlignment.center,
                                                           children: [
                                                             Row(
                                                               children: [
                                                                 Expanded(
                                                                   flex:4,
                                                                   child: SizedBox(
                                                                     height:100,
                                                                     width:150,
                                                                     child:
                                                                     ClipRRect(
                                                                       borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                       child:
                                                                       Image.network('${AppConstants.imageUrl}${d.imageEpisode}',
                                                                           fit:BoxFit.cover,
                                                                           errorBuilder: ( context,exception,stackTrace){
                                                                             return const Center(child: CircularProgressIndicator());
                                                                           }
                                                                       ),
                                                                     )
                                                                     ,),
                                                                 ),
                                                                 const SizedBox(width: 20,),
                                                                 Expanded(
                                                                   flex: 5,
                                                                   child: Column(
                                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                                     mainAxisAlignment: MainAxisAlignment.start,
                                                                     children: [
                                                                       FittedBox(
                                                                         child: Row(
                                                                           children: [
                                                                             Text('${d.numberEpisode}.',
                                                                               style: const TextStyle(color: Colors.white,fontSize: 18),
                                                                             ),
                                                                             Text(' ${d.name}',
                                                                               style: const TextStyle(color: Colors.white,fontSize: 18,
                                                                                   overflow: TextOverflow.ellipsis
                                                                               ),
                                                                               maxLines: 2,
                                                                             ),
                                                                           ],
                                                                         ),
                                                                       ),
                                                                       const SizedBox(height: 3,),
                                                                       Text('${d.dateOfEpisode}',
                                                                         style: const TextStyle(color: Colors.white30,fontSize: 12),
                                                                       ),
                                                                     ],
                                                                   ),
                                                                 )
                                                               ],
                                                             ),
                                                             const SizedBox(height: 10,),
                                                             Text('${d.descriptionEpisode}',
                                                               style: const TextStyle(color: Colors.white60),
                                                               overflow: TextOverflow.ellipsis,
                                                               maxLines: 4,
                                                             ),
                                                           ],)
                                                         ,),
                                                     ),
                                                   );
                                                 },
                                                 itemCount: c.listSeason[index].episode!.length,
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   );
                               })
                       ),
                     ]),
                   );
                 })
               ],
             ),
           );
         }
       }),
     ),)
    );
  }
}
