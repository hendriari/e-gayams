import 'package:flutter/material.dart';
import 'package:kkn_siwalan/src/utils/adapt_size.dart';
import 'package:kkn_siwalan/src/utils/colors.dart';

TabBar tabBarWidget({
  required BuildContext context,
  required TabController tabController,
}) {
  return TabBar(
      isScrollable: true,
      controller: tabController,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(fontSize: AdaptSize.pixel14),
      unselectedLabelColor: MyColor.neutral600,
      labelColor: MyColor.primary300,
      indicatorColor: MyColor.neutral900,
      padding: EdgeInsets.zero,
      labelPadding: EdgeInsets.only(
        left: AdaptSize.pixel3,
        right: AdaptSize.pixel3,
      ),
      tabs: [
        Container(
          padding: EdgeInsets.all(AdaptSize.pixel8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: MyColor.primary300,
            ),
          ),
          child: const Tab(
            text: 'Semua Produk',
          ),
        ),
        Container(
          padding: EdgeInsets.all(AdaptSize.pixel8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: MyColor.primary300,
            ),
          ),
          child: const Tab(
            text: 'Kelurahan Siwalan',
          ),
        ),
        Container(
          padding: EdgeInsets.all(AdaptSize.pixel8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: MyColor.primary300,
            ),
          ),
          child: const Tab(
            text: 'Kelurahan Gayamsari',
          ),
        ),
        Container(
          padding: EdgeInsets.all(AdaptSize.pixel8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: MyColor.primary300,
            ),
          ),
          child: const Tab(
            text: 'Kelurahan Sambirejo',
          ),
        ),
        Container(
          padding: EdgeInsets.all(AdaptSize.pixel8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: MyColor.primary300,
            ),
          ),
          child: const Tab(
            text: 'Kelurahan Pandean Lamper',
          ),
        ),
        Container(
          padding: EdgeInsets.all(AdaptSize.pixel8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: MyColor.primary300,
            ),
          ),
          child: const Tab(
            text: 'Kelurahan Sawah Besar',
          ),
        ),
        Container(
          padding: EdgeInsets.all(AdaptSize.pixel8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: MyColor.primary300,
            ),
          ),
          child: const Tab(
            text: 'Kelurahan Tambakrejo',
          ),
        ),
        Container(
          padding: EdgeInsets.all(AdaptSize.pixel8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: MyColor.primary300,
            ),
          ),
          child: const Tab(
            text: 'Kelurahan Kaligawe',
          ),
        ),
      ],
    );
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: MyColor.neutral900,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
  }
}