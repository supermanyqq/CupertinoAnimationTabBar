import 'package:flutter/cupertino.dart';
import 'ScaleAnimatedIcon.dart';

const double _kTabBarHeight = 50.0;

class CupertinoAnimationTabBar extends CupertinoTabBar {
  CupertinoAnimationTabBar({
    Key key,
    @required List<BottomNavigationBarItem> items,
    ValueChanged<int> onTap,
    int currentIndex = 0,
    Color backgroundColor = CupertinoColors.white,
    Color activeColor = const Color(0xFFFC5968),
    Color inactiveColor = CupertinoColors.inactiveGray,
    double iconSize = 24.0,
  }) : super(
            key: key,
            items: items,
            onTap: onTap,
            currentIndex: currentIndex,
            backgroundColor: backgroundColor,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            iconSize: iconSize);

  @override
  Widget build(BuildContext context) {
    final double bottomSafeArea = MediaQuery.of(context).padding.bottom;

    return SizedBox(
        height: _kTabBarHeight + bottomSafeArea,
        child: Container(
          color: backgroundColor,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomSafeArea),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _generateTabBarItems()),
          ),
        ));
  }

  @override
  CupertinoTabBar copyWith(
      {Key key,
      List<BottomNavigationBarItem> items,
      Color backgroundColor,
      Color activeColor,
      Color inactiveColor,
      double iconSize,
      Border border,
      int currentIndex,
      onTap}) {
    return CupertinoAnimationTabBar(
      key: key ?? this.key,
      items: items ?? this.items,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      iconSize: iconSize ?? this.iconSize,
      currentIndex: currentIndex ?? this.currentIndex,
      onTap: onTap ?? this.onTap,
    );
  }

  List<Widget> _generateTabBarItems() {
    final List<Widget> result = <Widget>[];
    final double _itemContainerHeight = iconSize + 16;

    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      final bool isActive = currentIndex == i;
      result.add(
        GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap == null
                ? null
                : () {
                    _tapTabBarItemAt(index: i);
                  },
            child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: isActive ? 130 : 50,
                height: _itemContainerHeight,
                decoration: BoxDecoration(
                  color: isActive
                      ? activeColor.withOpacity(0.2)
                      : CupertinoColors.white,
                  borderRadius: BorderRadius.circular(_itemContainerHeight / 2),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: IconTheme(
                            data: IconThemeData(size: iconSize),
                            child: isActive
                                ? ScaleAnimatedIcon(
                                    icon: item.activeIcon,
                                  )
                                : item.icon,
                          )),
                      if (isActive)
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            item.label,
                            style: TextStyle(color: activeColor),
                          ),
                        )
                    ],
                  ),
                ))),
      );
    }
    return result;
  }

  void _tapTabBarItemAt({@required int index}) {
    onTap(index);
  }
}
