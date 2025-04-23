import 'package:flutter/material.dart';
import 'package:wynd/theme/theme.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget buildSkeletonLoading(BuildContext context) {
  return Skeletonizer(
    enabled: true,
    child: Container(
      decoration: getWeatherBackgroundDecoration(context),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: 120, height: 24, color: Colors.white),
                      SizedBox(height: 4),
                      Container(width: 80, height: 20, color: Colors.white),
                    ],
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.white.withOpacity(0.3)),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(width: 100, height: 40, color: Colors.white),
                    SizedBox(height: 2),
                    Container(width: 120, height: 24, color: Colors.white),
                    SizedBox(height: 16),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white.withOpacity(0.3),
                      ),
                      child: Column(
                        children: List.generate(
                          7,
                          (index) => Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 16,
                                        color: Colors.white,
                                      ),
                                      SizedBox(height: 4),
                                      Container(
                                        width: 60,
                                        height: 16,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if (index < 2)
                                Divider(
                                  height: 30,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 24,
                            color: Colors.white,
                          ),
                          SizedBox(height: 20),
                          Column(
                            children: List.generate(
                              3,
                              (index) => Container(
                                margin: EdgeInsets.only(bottom: 16),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 16,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 4),
                                          Container(
                                            width: 80,
                                            height: 16,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 16,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
