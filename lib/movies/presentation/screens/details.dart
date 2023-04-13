import 'package:flutter/material.dart';
import 'package:movies/constantes/constants.dart';
import 'package:movies/movies/presentation/provider/details_provider.dart';
import 'package:movies/movies/presentation/widget/custom_one_movie.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DetailsMovies extends StatefulWidget {
  final int id;
  const DetailsMovies({super.key, required this.id});
  @override
  State<DetailsMovies> createState() => _DetailsMoviesState();
}

class _DetailsMoviesState extends State<DetailsMovies> {
  @override
  void initState() {
    Provider.of<DetailsProvider>(context, listen: false).getDetails(widget.id);
    Provider.of<DetailsProvider>(context, listen: false).getLikeThisMovies(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1E1E29),
        body:
        Consumer<DetailsProvider>(builder: (context,controller ,child){
         if(controller.listDetails.isEmpty || controller.listDetails==[]){
           return const Center(
             child: CircularProgressIndicator(),
           );
         }
         else{
           double r =controller.listDetails[0].rate;
           String newRate=r.toStringAsFixed(1);
           int runtime =controller.listDetails[0].runtime!;
           String hour ='${runtime.toString()[0]}h';
           String min = '${runtime.toString().replaceAll(runtime.toString()[0], '')}m';
           String min2 = runtime.toString().replaceAll(runtime.toString()[0], '');
           if(min2 ==''){
             min ='';
           }
           var year='';
           try{
             DateTime dateTime =
            DateTime.parse(controller.listDetails[0].date!);
             year= DateFormat.y().format((dateTime));
           }catch(e){
             year='';
           }
           return
             SingleChildScrollView(
             child: Column(
               children: [
                 SizedBox(
                   height: MediaQuery.of(context).size.height*0.38,
                   width: MediaQuery.of(context).size.width,
                   child:Image.network(
                     "${AppConstants.imageUrl}${controller.listDetails[0].image}",fit: BoxFit.cover,
                     errorBuilder: (context,object,stack){
                       return const Center(child: CircularProgressIndicator(),);
                     },
                   )
                 ),
                 Container(
                   margin:const EdgeInsets.only(left: 10,top: 10),
                   alignment: Alignment.centerLeft,
                   child: Text(controller.listDetails[0].title!,
                   style: const TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold),
                   ),
                 ),
                 SizedBox(
                   height:MediaQuery.of(context).size.width*0.03,
                 ),
                 Row(
                   children: [
                   const SizedBox(
                       width: 10,
                     ),
                     Container(
                       decoration: const BoxDecoration(
                           color: Color(0xff424242),
                           borderRadius: BorderRadius.all(Radius.circular(5))
                       ),
                       width: MediaQuery.of(context).size.width*0.16,
                       height: MediaQuery.of(context).size.height*0.04,
                       child:  Center(
                         child: Text(year,
                           style: const TextStyle(
                               color: Colors.white,
                               fontSize: 15,
                               fontWeight: FontWeight.bold
                           ),
                         ),
                       ),
                     ),
                     SizedBox(
                       width: MediaQuery.of(context).size.width*0.06,
                     ),
                     const Icon(Icons.star,size: 25,color: Colors.yellow,),
                     SizedBox(width: MediaQuery.of(context).size.width*0.01,),
                     Text(newRate,
                       style:const TextStyle(color: Colors.white,fontSize: 16) ,
                     ),
                     SizedBox(
                       width: MediaQuery.of(context).size.width*0.02,
                     ),
                    const Text('-----',
                       style: TextStyle(color: Colors.white24,fontSize: 8) ,
                     ),
                     SizedBox(
                       width: MediaQuery.of(context).size.width*0.05,
                     ),
                     Text('$hour $min',
                       style:const TextStyle(color: Colors.white70,fontSize: 16) ,
                     ),

                   ],
                 ),
                 SizedBox(
                   height:MediaQuery.of(context).size.width*0.06,
                 ),
                 Container(
                   margin: const EdgeInsets.symmetric(horizontal: 10),
                   child: Text(controller.listDetails[0].description!,
                   style: const TextStyle(
                     color: Colors.white,
                     fontSize: 16
                   ),
                   ),
                 ),
                 SizedBox(
                   height:MediaQuery.of(context).size.width*0.03,
                 ),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const SizedBox(
                       width:10,
                     ),
                     const Text('Genres:  ',style: TextStyle(color: Colors.white70,fontSize: 15),),
                     SizedBox(
                       width: MediaQuery.of(context).size.width*0.7,
                       height: MediaQuery.of(context).size.height*0.03,
                       child: ListView.builder(
                           scrollDirection: Axis.horizontal,
                           itemCount: controller.listDetails[0].genres!.length ,
                           itemBuilder: (context,i){
                             return
                               Text("${controller.listDetails[0].genres![i].name}${i== controller.listDetails[0].genres!.length-1?'':","} ",
                                   style: const TextStyle(color: Colors.white70,fontSize: 15)
                               );}
                           ),
                     ),
                   ],
                 ),
                 SizedBox(
                   height:MediaQuery.of(context).size.height*0.01,
                 ),
                 Container(
                   margin: const EdgeInsets.only(left: 15,bottom: 6),
                   alignment: Alignment.centerLeft,
                   child: const Text('MORE LIKE THIS',
                       style: TextStyle(color: Colors.white,fontSize: 15)
                   ),
                 ),
                LayoutBuilder(builder: (cxt,constraints){
                 if(controller.listLikeThis.isEmpty || controller.listLikeThis==[]){
                   return const Center(child: CircularProgressIndicator(),);
                 }
                 else{
                   return Container(
                     margin:const EdgeInsets.only(left: 10,right: 10),
                     height:controller.listLikeThis.length>=3?( controller.listLikeThis.length.isOdd?( (MediaQuery.of(context).size.height*0.088)*((controller.listLikeThis.length))):
                     ((MediaQuery.of(context).size.height*0.098)*((controller.listLikeThis.length)))):
                     (MediaQuery.of(context).size.height*0.3),
                     width: MediaQuery.of(context).size.width,
                     child: GridView.builder(
                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 3,
                         crossAxisSpacing: 2,
                         mainAxisSpacing: 3,
                         childAspectRatio: 3 / 5,
                       ),
                       physics: const NeverScrollableScrollPhysics(),
                       itemCount: controller.listLikeThis.length,
                       itemBuilder: (context,i){
                         if(controller.listLikeThis[i].image==null){
                           return const Center(
                             child: CircularProgressIndicator(),
                           );
                         }
                         else{
                           return CustomOneMovie(
                               image: '${AppConstants.imageUrl}${controller.listLikeThis[i].image}',
                               onTap: (){
                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DetailsMovies(id: controller.listLikeThis[i].id)));
                               });
                         }
                       }, ),
                   );
                 }

                })


               ],
             ),
           );
         }

        }),
      ),
    );

  }
}
