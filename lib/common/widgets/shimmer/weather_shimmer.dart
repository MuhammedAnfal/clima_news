import 'package:clima_news/common/widgets/shimmer/shimmer.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';

class WeatherShimmerEffect extends StatelessWidget {
  const WeatherShimmerEffect({super.key, this.itemCount = 6});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(context.screenWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //-- user Icon and place text shimmers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //-- place shimmer
                  ShimmerEffect(
                    width: context.screenWidth * 0.4,
                    height: context.screenHeight * 0.045,
                    radius: 40,
                  ),

                  //-- profile icon shimmer
                  ShimmerEffect(
                    width: context.screenWidth * 0.15,
                    height: context.screenHeight * 0.07,
                    radius: 40,
                  ),
                ],
              ),

              //-- textformfiled shimmer
              Padding(
                padding: EdgeInsets.only(top: context.screenHeight * 0.035),
                child: ShimmerEffect(
                  width: context.screenWidth,
                  height: context.screenHeight * 0.07,
                  radius: 40,
                ),
              ),

              //-- temp weather and weather des shimmer
              Padding(
                padding: EdgeInsets.only(top: context.screenHeight * 0.02),
                child: ShimmerEffect(
                  width: context.screenWidth,
                  height: context.screenHeight * 0.18,
                  radius: 40,
                ),
              ),

              //-- weather datas shimmer  such as humidity,uv......
              Padding(
                padding: EdgeInsets.only(top: context.screenHeight * 0.02),
                child: ShimmerEffect(
                  width: context.screenWidth,
                  height: context.screenHeight * 0.28,
                  radius: 40,
                ),
              ),

              //-- hourly forecast simmer
              Padding(
                padding: EdgeInsets.only(top: context.screenHeight * 0.02),
                child: SizedBox(
                  height: context.screenHeight * 0.18,
                  width: context.screenWidth * 0.9,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: context.screenWidth * 0.025),
                        child: Row(
                          children: [
                            ShimmerEffect(
                              width: context.screenWidth * 0.38,
                              height: context.screenHeight * 0.25,
                              radius: 15,
                            ),
                          ],
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
    );
  }
}
