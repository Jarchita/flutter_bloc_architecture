part of persistent_bottom_nav_bar;

class BottomNavStyle9 extends StatelessWidget {
  final NavBarEssentials? navBarEssentials;

  BottomNavStyle9({
    Key? key,
    this.navBarEssentials = const NavBarEssentials(items: null),
  });

  Widget _buildItem(
          PersistentBottomNavBarItem item, bool isSelected, double? height) =>
      navBarEssentials!.navBarHeight == 0
          ? SizedBox.shrink()
          : AnimatedContainer(
              width: isSelected ? 110 : 50,
              height: height! / 1.5,
              duration: navBarEssentials!.itemAnimationProperties?.duration ??
                  Duration(milliseconds: 400),
              curve: navBarEssentials!.itemAnimationProperties?.curve ??
                  Curves.ease,
              padding: EdgeInsets.symmetric(
                  vertical: item.contentPadding,
                  horizontal: item.contentPadding),
              decoration: BoxDecoration(
                color: isSelected
                    ? item.activeColorPrimary.withOpacity(0.15)
                    : navBarEssentials!.backgroundColor!.withOpacity(0.0),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Container(
                alignment: Alignment.center,
                height: height / 1.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconTheme(
                        data: IconThemeData(
                            size: item.iconSize,
                            color: isSelected
                                ? (item.activeColorSecondary == null
                                    ? item.activeColorPrimary
                                    : item.activeColorSecondary)
                                : item.inactiveColorPrimary == null
                                    ? item.activeColorPrimary
                                    : item.inactiveColorPrimary),
                        child: isSelected
                            ? item.icon
                            : item.inactiveIcon ?? item.icon,
                      ),
                    ),
                    item.title == null
                        ? SizedBox.shrink()
                        : isSelected
                            ? Flexible(
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: FittedBox(
                                    child: Text(
                                      item.title!,
                                      style: item.textStyle != null
                                          ? (item.textStyle!.apply(
                                              color: isSelected
                                                  ? (item.activeColorSecondary ==
                                                          null
                                                      ? item.activeColorPrimary
                                                      : item
                                                          .activeColorSecondary)
                                                  : item.inactiveColorPrimary))
                                          : TextStyle(
                                              color:
                                                  (item.activeColorSecondary ==
                                                          null
                                                      ? item.activeColorPrimary
                                                      : item
                                                          .activeColorSecondary),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.0),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox.shrink()
                  ],
                ),
              ),
            );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: navBarEssentials!.navBarHeight,
      padding: EdgeInsets.only(
          top: navBarEssentials!.padding?.top ??
              navBarEssentials!.navBarHeight! * 0.15,
          left: navBarEssentials!.padding?.left ??
              MediaQuery.of(context).size.width * 0.01,
          right: navBarEssentials!.padding?.right ??
              MediaQuery.of(context).size.width * 0.01,
          bottom: navBarEssentials!.padding?.bottom ??
              navBarEssentials!.navBarHeight! * 0.15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: navBarEssentials!.items!.map((item) {
          int index = navBarEssentials!.items!.indexOf(item);
          return Flexible(
            flex: navBarEssentials!.selectedIndex == index ? 2 : 1,
            child: GestureDetector(
              onTap: () {
                if (navBarEssentials!.items![index].onPressed != null) {
                  navBarEssentials!.items![index]
                      .onPressed!(navBarEssentials!.selectedScreenBuildContext);
                } else {
                  navBarEssentials!.onItemSelected!(index);
                }
              },
              child: Container(
                color: Colors.transparent,
                child: _buildItem(
                    item,
                    navBarEssentials!.selectedIndex == index,
                    navBarEssentials!.navBarHeight),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
