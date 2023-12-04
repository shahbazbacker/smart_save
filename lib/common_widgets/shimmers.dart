import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key, this.height, this.itemCount});

  final double? height;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    log('shimmer build');
    int offset = 0;
    int time = 1000;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: itemCount ?? 9,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;

          // log(time.toString());

          return Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey.shade300,
            period: Duration(milliseconds: time),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              height: height ?? 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),

              // color: Colors.grey,
            ),
          );
        },
      ),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  const ShimmerLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // double containerWidth = MediaQuery.of(context).size.width - 150;
    // double containerHeight = 15;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 12,
              width: MediaQuery.of(context).size.width / 1.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),

              // color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////
class ShimmerBox extends StatelessWidget {
  final double? height;
  const ShimmerBox({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    // int offset = 0;
    int time = 1000;

    return SizedBox(
        height: height ?? MediaQuery.of(context).size.height / 3,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Shimmer.fromColors(
              highlightColor: Colors.white,
              baseColor: Colors.grey.shade300,
              period: Duration(milliseconds: time),
              child: const ShimmerBoxLayout(),
            )));
  }
}

class ShimmerBoxLayout extends StatelessWidget {
  const ShimmerBoxLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // double containerWidth = MediaQuery.of(context).size.width - 150;
    // double containerHeight = 15;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 1.2,
            // color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

class ShimmerHorizontalList extends StatelessWidget {
  const ShimmerHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 1000;

    return SizedBox(
      height: 50,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: 9,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;

          // log(time.toString());

          return Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey.shade300,
            period: Duration(milliseconds: time),
            child: const ShimmerHorizontalLayout(),
          );
        },
      ),
    );
  }
}

class ShimmerGridView extends StatelessWidget {
  const ShimmerGridView({super.key});

  @override
  Widget build(BuildContext context) {
    int time = 1000;
    final size = MediaQuery.of(context).size;

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
      ),
      itemCount: 8,
      itemBuilder: (_, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 12,
                offset: Offset(0, 0),
                spreadRadius: 5,
              )
            ],
          ),
          child: Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey.shade300,
            period: Duration(milliseconds: time),
            child: SizedBox(
              // margin: const EdgeInsets.symmetric(horizontal: .001),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                height: size.height * 0.20,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ShimmerHorizontalLayout extends StatelessWidget {
  const ShimmerHorizontalLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // double containerWidth = MediaQuery.of(context).size.width - 150;
    // double containerHeight = 15;

    return SizedBox(
      // margin: const EdgeInsets.symmetric(horizontal: .001),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              right: 15.0,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
            height: 50,
            width: 130,
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ShimmerCalenderTable extends StatelessWidget {
  ShimmerCalenderTable({
    super.key,
  });

  int time = 1000;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade300,
      period: Duration(milliseconds: time),
      child: SizedBox(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 3,
        ),
      ),
    );
  }
}

class ShimmerHzlList extends StatelessWidget {
  const ShimmerHzlList({super.key});

  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 1000;

    return SizedBox(
      height: MediaQuery.of(context).size.height / 22,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 9,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;

          // log(time.toString());

          // log(time.toString());

          return Shimmer.fromColors(
            highlightColor: Colors.white,
            baseColor: Colors.grey.shade300,
            period: Duration(milliseconds: time),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                // height: MediaQuery.of(context).size.height ,
                width: MediaQuery.of(context).size.width / 5.5,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ShimmerButton extends StatefulWidget {
  const ShimmerButton({
    super.key,
  });

  @override
  State<ShimmerButton> createState() => _ShimmerButtonState();
}

class _ShimmerButtonState extends State<ShimmerButton> {
  int time = 1000;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade300,
      period: Duration(milliseconds: time),
      child: SizedBox(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 14,
        ),
      ),
    );
  }
}
/////////////////////////////////////

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 1000;

    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.6,
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;

          // log(time.toString());

          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey.shade300,
                period: Duration(milliseconds: time),
                child: const NotificationShimmerLayout(),
              ));
        },
      ),
    );
  }
}

class NotificationShimmerLayout extends StatelessWidget {
  const NotificationShimmerLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size.width;
    // double containerWidth = MediaQuery.of(context).size.width - 150;
    // double containerHeight = 15;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: mediaHeight / 12,
            width: mediaWidth / 1.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),

            // color: Colors.grey,
          ),
          // Container(
          //   height: mediaHeight/15,
          //   width: mediaWidth/7,
          //   color: Colors.amber,
          // )
        ],
      ),
    );
  }
}
