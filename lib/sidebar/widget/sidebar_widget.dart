import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/drawer_images.dart';
import '../model/drawer_model.dart';
import '../sidebar_notifier.dart';
import 'package:testing/notifier/responsive_utils.dart';

class SidebarWidget extends ConsumerWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final safeArea = EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);
    final sidebarState = ref.watch(sidebarNotifierProvider);
    final sidebarNotifier = ref.read(sidebarNotifierProvider.notifier);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: sidebarState.isCollapsed ? MediaQuery.of(context).size.width * 0.05 : MediaQuery.of(context).size.width * 0.2,
      child: Drawer(
        child: Container(
          color: Colors.white, // Set the drawer background to white
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24).add(safeArea),
                width: double.infinity,
                color: Colors.white, // Set the header background to white
                child: buildHeader(context, sidebarState.isCollapsed),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildList(context, items: itemsFirst, isCollapsed: sidebarState.isCollapsed),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              buildCollapseIcon(context, sidebarNotifier, sidebarState.isCollapsed),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, {
    required bool isCollapsed,
    required List<DrawerImages> items,
    int indexOffset = 0,
  }) =>
      ListView.separated(
        padding: isCollapsed ? EdgeInsets.zero : padding,
        shrinkWrap: true,
        primary: false,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = items[index];

          return buildMenuItem(
            context,
            isCollapsed: isCollapsed,
            text: item.title,
            imagePath: item.imagePath,
            onClicked: () => selectItem(context, indexOffset + index),
          );
        },
      );

  void selectItem(BuildContext context, int index) {
    navigateTo(page) =>
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => page,
        ));
  }

  Widget buildMenuItem(BuildContext context, {
    required bool isCollapsed,
    required String text,
    String? imagePath,
    VoidCallback? onClicked,
  }) {
    const color = Colors.black;

    final leading = SizedBox(
      width: isCollapsed ? 20 : 30, // Adjusted size
      child: imagePath != null ? Image.asset(imagePath, width: 20, height: 20) : null, // Adjusted size
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onClicked,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: isCollapsed ? 4 : 8),
          child: Row(
            mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              leading,
              if (!isCollapsed) const SizedBox(width: 8),
              if (!isCollapsed)
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: color,
                      fontSize: ResponsiveUtils.fontSize(context), // Adjust font size based on screen size
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCollapseIcon(BuildContext context,
      SidebarNotifier sidebarNotifier, bool isCollapsed) {
    const double size = 52;
    final alignment = isCollapsed ? Alignment.center : Alignment.centerRight;
    final margin = isCollapsed ? null : const EdgeInsets.only(right: 16);
    final width = isCollapsed ? double.infinity : size;

    return Container(
      alignment: alignment,
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: SizedBox(
            width: width,
            height: size,
            child: Image.asset('lib/images/Avatar.png'), // Use Avatar.png
          ),
          onTap: () {
            sidebarNotifier.toggleIsCollapsed();
          },
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context, bool isCollapsed) {
    final leading = Padding(
      padding: EdgeInsets.only(left: isCollapsed ? 0 : 16),
      child: Image.asset(
        headerItem.imagePath!,
        width: isCollapsed ? 30 : 40,
        height: isCollapsed ? 30 : 40,
        fit: BoxFit.contain,
      ),
    );

    return isCollapsed
        ? leading
        : SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          leading,
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              headerItem.title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}