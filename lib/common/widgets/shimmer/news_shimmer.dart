import 'package:clima_news/common/widgets/shimmer/shimmer.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';

class NewsShimmer extends StatelessWidget {
  const NewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(context.screenWidth * 0.045),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //-- heading shimmer
                Center(
                  child: ShimmerEffect(
                    width: context.screenWidth * 0.55,
                    height: context.screenHeight * 0.05,
                    radius: 40,
                  ),
                ),

                //-- see all and hottest news shimmer
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerEffect(
                        width: context.screenWidth * 0.3,
                        height: context.screenHeight * 0.03,
                        radius: 10,
                      ),
                      ShimmerEffect(
                        width: context.screenWidth * 0.2,
                        height: context.screenHeight * 0.03,
                        radius: 10,
                      ),
                    ],
                  ),
                ),

                //-- hottes listview shimmer
                SizedBox(
                  height: context.screenHeight * 0.35,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(context.screenHeight * 0.01),
                        child: ShimmerEffect(
                          width: context.screenWidth * 0.6,
                          height: context.screenHeight * 0.1,
                          radius: 25,
                        ),
                      );
                    },
                  ),
                ),
                //-- news for you and hottest news shimmer
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerEffect(
                        width: context.screenWidth * 0.3,
                        height: context.screenHeight * 0.03,
                        radius: 10,
                      ),
                      ShimmerEffect(
                        width: context.screenWidth * 0.2,
                        height: context.screenHeight * 0.03,
                        radius: 10,
                      ),
                    ],
                  ),
                ),

                //-- news for you listview shimmer
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.02),
                  child: SizedBox(
                    height: context.screenHeight * 0.35,
                    child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: context.screenHeight * 0.025,
                          ),
                          child: ShimmerEffect(
                            width: context.screenWidth * 0.6,
                            height: context.screenHeight * 0.2,
                            radius: 25,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
