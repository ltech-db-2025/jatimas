part of '../page.dart';

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({super.key, required this.choice, this.index});
  final int? index;
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => _menuGridClick(index ?? 0),
        child: Card(
            elevation: 0,
            color: Colors.transparent,
            child: Center(
              child: badges.Badge(
                  showBadge: choice.bedge,
                  position: badges.BadgePosition.topEnd(top: 0, end: 3),
                  badgeAnimation: const badges.BadgeAnimation.fade(
                    animationDuration: Duration(milliseconds: 300),
                  ),
                  badgeContent: Text(choice.notif.toString(), style: const TextStyle(color: Colors.white), textScaler: const TextScaler.linear(0.6)),
                  child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Expanded(child: Container(width: 48.0, height: 48, color: choice.aktif ? Colors.transparent : Colors.grey, child: choice.icon)),
                    AutoSizeText(choice.title, wrapWords: false, maxLines: 1, minFontSize: 8, textScaleFactor: 0.6, style: TextStyle(color: choice.aktif ? Colors.black : Colors.grey)),
                  ])),
            )));
  }
}
