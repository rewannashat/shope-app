import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shopp_app/layout/layouts-Screens/homeCubit.dart';

import '../../models/getFavModel.dart';
import '../../style/custom_text.dart';
import '../../widget-constant/constWidget.dart';
import 'homeStates.dart';
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    HomeCubit homeCubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit,States>(
      listener: (context, state) => {},
      builder:(context, state) => Scaffold(
        body: ConditionalBuilder(
          condition: state is! GetFavLoading ,
          builder:(context) =>ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: divider(),
              ),
              itemCount: homeCubit.getFavModel!.data!.data!.length,
              itemBuilder: (context, index) =>  innerList(homeCubit.getFavModel!.data!.data![index] , homeCubit)) ,
          fallback: (context) => Center(
            child: LoadingAnimationWidget.threeRotatingDots(
              color: Colors.black38,
              size: 35.sp,
            ),
          ),
        ),
      ),
    );
  }
  Widget innerList (DataFav dataFav,HomeCubit homeCubit) {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipRRect(
                    borderRadius :BorderRadius.circular(8.r),
                    child: Image.network('${dataFav.product!.image}',width: 130.w,height: 130.h,)),
                if (dataFav.product!.discount != 0)
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
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  txt: dataFav.product!.name,
                  color: Colors.black,
                  fontSize: 10.sp,
                  overflow: TextOverflow.ellipsis,
                  maxLine: 1,
                ),
               SizedBox(height: 25.h,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      txt: dataFav.product!.price.toString(),
                      color: Colors.purple,
                      fontSize: 10.sp,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (1 != 0)
                      CustomText(
                        txt: '\t\t\t\t'+dataFav.product!.discount.toString(),
                        color: Colors.grey,
                        fontSize: 10.sp,
                        overflow: TextOverflow.ellipsis,
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: (){
                        homeCubit.changeFav(dataFav.product!.id!.toInt());
                      },
                      padding: EdgeInsets.zero,
                      icon: CircleAvatar(
                        backgroundColor: homeCubit.favorite[dataFav.product!.id] == false ? Colors.grey : Colors.red,
                         radius: 15.r,
                          foregroundColor: Colors.black,
                          child: Icon(Icons.favorite_border)) ,
                      alignment: Alignment.topRight,
                      iconSize: 13.sp,
                      //color: homeCubit.favorite[dataFav.product!.id] == false ? Colors.grey : Colors.red,

                    ),
                  ],
                )

              ],
            ),
          )
        ],

      ),
    ) ;
  }
}
