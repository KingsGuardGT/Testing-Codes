import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testing/sidebar/sidebar_notifier.dart';

import '../data/drawer_images.dart';
import '../model/drawer_model.dart';

class SidebarWidget extends ConsumerWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sidebarState = ref.watch(sidebarNotifierProvider);
    final sidebarNotifier = ref.watch(sidebarNotifierProvider.notifier);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: sidebarState.isCollapsed ? MediaQuery.of(context).size.width * 0.05 : MediaQuery.of(context).size.width * 0.2,
      child: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 24).add(MediaQuery.of(context).padding),
                width: double.infinity,
                color: Colors.white,
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

  Widget buildList(BuildContext context, {required bool isCollapsed, required List<DrawerImages> items, int indexOffset = 0}) {
    return ListView.separated(
      padding: isCollapsed ? EdgeInsets.zero : const EdgeInsets.all(16),
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
  }

  void selectItem(BuildContext context, int index) {
    // Implement navigation logic here
  }

  Widget buildMenuItem(BuildContext context, {required bool isCollapsed, required String text, String? imagePath, VoidCallback? onClicked}) {
    const color = Colors.black;
    final leading = SizedBox(
      width: isCollapsed ? 20 : 30,
      child: imagePath != null ? Image.asset(imagePath, width: 20, height: 20) : null,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onClicked,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: isCollapsed ? 4 : 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              leading,
              if (!isCollapsed) const SizedBox(width: 8),
              if (!isCollapsed)
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    text,
                    style: const TextStyle(color: color, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCollapseIcon(BuildContext context, SidebarNotifier sidebarNotifier, bool isCollapsed) {
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
          onTap: sidebarNotifier.toggleIsCollapsed,
          child: SizedBox(
            width: width,
            height: size,
            child: Image.asset('lib/images/Avatar.png'),
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context, bool isCollapsed) {
    final leading = Padding(
      padding: EdgeInsets.only(left: isCollapsed ? 0 : 16),
      child: Image.asset(
        'lib/images/Vector1.png',
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
        mainAxisSize: MainAxisSize.min,
        children: [
          leading,
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Header Title',
              style: TextStyle(fontSize: 18, color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}