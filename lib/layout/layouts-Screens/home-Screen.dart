import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopp_app/models/homeModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopp_app/widget-constant/constWidget.dart';
import '../../models/categoriesModel.dart';
import '../../style/custom_text.dart';
import 'homeCubit.dart';
import 'homeStates.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return BlocConsumer<HomeCubit,States>(
      listener: (context, state) => {
        if (state is GetChangeFavSuccess) {
          if (state.favModel.status == false) {
            toast(msg: state.favModel.message.toString(),
                state: StatusCase.ERROR,
            )
          }
        }
      },
      builder: (context, state) {
        HomeCubit homeCubit = HomeCubit.get(context);
        return Scaffold(
        backgroundColor: Colors.grey[200],
        body: ConditionalBuilder(
          condition: homeCubit.homeMoedl != null && homeCubit.categoriesModel != null,
          builder:(context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: bodyContenr(homeCubit)) ,
          fallback: (context) => Center(
            child: LoadingAnimationWidget.threeRotatingDots(
              color: Colors.black38,
              size: 35.sp,
            ),
          ),
        ),
      );
      } ,
    );
  }
  Widget bodyContenr (HomeCubit homeCubit) {
    Dataa data ;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 5.h,),
        CarouselSlider(
            options:CarouselOptions(
              height:150.h,
              aspectRatio: 13/9,
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayAnimationDuration: Duration(milliseconds: 200),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
            items:homeCubit.homeMoedl!.data?.products?.map((e) =>
            Center(
              child:  Shimmer(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.sp),
                  child: Image(image: NetworkImage('${e.image}'),
                    width: 300.w,
                    height: 200.h ,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
            ).toList(),
        ),
        SizedBox(height: 7.h,),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: CustomText(
              txt: 'Categories',
              color: Colors.black,
              fontSize: 16.sp,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        Container(
          height: 100.h,width: double.infinity,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => innerList(homeCubit.categoriesModel!.data!.data![index]),
            separatorBuilder: (context, index) => SizedBox(width: 12.w,),
            itemCount: homeCubit.categoriesModel!.data!.data!.length,
          ),
        ),
        SizedBox(height: 5.h,),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: CustomText(
              txt: 'New Product',
              color: Colors.black,
              fontSize: 16.sp,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        SizedBox(
          child: Container(
            color: Colors.grey[200],
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 13.0,
              crossAxisSpacing: 15.0,
              childAspectRatio: 1/1.38,
              scrollDirection:Axis.vertical ,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 5.h,vertical: 5.w),
               children: List.generate(
                 homeCubit.homeMoedl!.data!.products!.length,
                     (index) => innerGrid(homeCubit.homeMoedl!.data!.products![index] , homeCubit),
               ),
            ),
          ),
        ),
      ],
    );
  }
  Widget innerGrid(Products products , HomeCubit homeCubit) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Container(
          //   width: 120.w,height: 150.h,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(15.sp),
          //     image: DecorationImage(image:NetworkImage('${products.image}'),
          //       fit: BoxFit.cover,
          //       alignment: Alignment.center,
          //     ),
          //   ),
          // ),
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              ClipRRect(
               borderRadius :BorderRadius.circular(8.r),
                  child: Image.network('${products.image}',fit: BoxFit.fill,width: 170.w,height: 170.h,)),
              if (products.discount != 0)
              Container(
                padding: EdgeInsets.symmetric(vertical:3,horizontal: 7),
                color: Colors.red,
                child:  CustomText(
                  txt: 'DISCOUNT',
                  color: Colors.white,
                  fontSize: 10.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
         Padding(
           padding: const EdgeInsets.all(15.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisSize: MainAxisSize.min,
             children: [
               CustomText(
                 txt: products.name,
                 color: Colors.black,
                 fontSize: 10.sp,
                 overflow: TextOverflow.ellipsis,
                 maxLine: 1,
               ),
               SizedBox(height: 5.h,),
               Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisSize: MainAxisSize.min,
                 //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   CustomText(
                     txt: products.price.toString(),
                     color: Colors.purple,
                     fontSize: 10.sp,
                     overflow: TextOverflow.ellipsis,
                   ),
                   if (products.discount != 0)
                     CustomText(
                       txt: '\t\t\t\t'+products.discount.toString(),
                       color: Colors.grey,
                       fontSize: 10.sp,
                       overflow: TextOverflow.ellipsis,
                     ),
                   Spacer(),
                   IconButton(
                     onPressed: (){
                       homeCubit.changeFav(products.id!);
                     },
                     padding: EdgeInsets.zero,
                     icon: Icon(Icons.favorite_border) ,
                     alignment: Alignment.topRight,
                     iconSize: 13.sp,
                     color: homeCubit.favorite[products.id] == false ? Colors.grey : Colors.red,

                   ),
                 ],
               )
             ],
           ),
         )
        ],

      ),
    );
  }

  Widget innerList (Dataa data) {
    // print('hereeePrint${data}');
    return Container(
      margin: EdgeInsets.all(8),
      color: Colors.grey,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Shimmer(
            child: Image.network('${data.image}',height: 90.h,width:120.w,alignment: Alignment.center ,
                filterQuality: FilterQuality.high ,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:Radius.circular(4.r),topRight: Radius.circular(4.r)),
              color: Colors.black.withAlpha(200),
            ),
            margin: EdgeInsets.only(top: 3),
            padding: EdgeInsets.symmetric(vertical:5,horizontal: 16),
             width: 120.w,
            child: CustomText(
              txt: data.name,
              color: Colors.white,
              fontSize: 10.sp,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLine: 1,
            ),
          ),
        ],
      ),
    );
  }
}

