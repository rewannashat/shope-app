import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../models/categoriesModel.dart';
import '../../style/custom_text.dart';
import 'homeCubit.dart';
import 'homeStates.dart';
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return BlocConsumer<HomeCubit,States>(
      listener: (context, state) => {},
        builder: (context, state) {
          HomeCubit categCubit = HomeCubit.get(context);
        return Scaffold (
          body: ConditionalBuilder(
            condition: categCubit.categoriesModel != null,
            builder:(context) => ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index) => SizedBox(height: 8.h),
                itemCount: categCubit.categoriesModel!.data!.data!.length,
                itemBuilder: (context, index) =>  innerList(categCubit.categoriesModel!.data!.data![index])) ,
            fallback: (context) => Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                color: Colors.black38,
                size: 35.sp,
              ),
            ),
          ),
        ) ;
        }
    );
  }
  Widget innerList (Dataa data) {
    return Container(
      margin: EdgeInsets.all(8),
      height: 100.h, width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.r)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.network('${data.image}' , width: 100.w,height: 100.h,),
             SizedBox(width: 5.w,),
              CustomText(
                txt: data.name,
                color: Colors.black,
                fontSize: 12.sp,
                textAlign: TextAlign.left,
              ),
            ],
          ),
          IconButton(onPressed: (){},
              icon: Icon(Icons.arrow_forward_ios ,
              ),
          ) ,
        ],
      ),
    ) ;
  }
}
