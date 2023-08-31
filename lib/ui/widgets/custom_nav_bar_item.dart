import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

CustomNavigationBarItem CustomNavBarItem(
    selectedTitle, badgeShow, badgeCount, icon, item_title) {
  return CustomNavigationBarItem(
      title: Text(
        '$item_title',
        style: subTitleTextStleBottomItems,
      ),
      // showBadge: badgeShow,
      selectedTitle: Text(
        selectedTitle,
        style: SelectedsubTitleTextStleBottomItems,
      ),
      // badgeCount: badgeCount,
      icon: icon);
}
