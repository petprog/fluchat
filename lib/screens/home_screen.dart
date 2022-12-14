import 'package:chatter/pages/pages.dart';
import 'package:chatter/screens/screens.dart';
import 'package:chatter/theme.dart';
import 'package:flutter/material.dart';
import 'package:chatter/app.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final pages = const [
    {
      'title': 'Messages',
      'page': MessagesPage(),
    },
    {
      'title': 'Notifications',
      'page': NotificationsPage(),
    },
    {
      'title': 'Calls',
      'page': CallsPage(),
    },
    {
      'title': 'Contacts',
      'page': ContactsPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: pageIndex,
      builder: (BuildContext context, int value, _) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: Theme.of(context).iconTheme,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              pages[value]['title'] as String,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: Hero(
                  tag: 'hero-profile-picture',
                  child: Avatar.small(
                    url: context.currentUserImage,
                    onTap: () {
                      Navigator.of(context).push(ProfileScreen.route);
                    },
                  ),
                ),
              ),
            ],
            leadingWidth: 54,
            leading: Align(
              alignment: Alignment.centerRight,
              child: IconBackground(
                  icon: Icons.search,
                  onTap: () {
                    print('');
                  }),
            ),
          ),
          body: pages[value]['page'] as Widget,
          bottomNavigationBar: _BottomNavigationBar(
            onItemSelected: (index) {
              pageIndex.value = index;
            },
          ),
        );
      },
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({Key? key, required this.onItemSelected})
      : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;
  void handleItemSelected(int index) {
    setState(
      () {
        selectedIndex = index;
      },
    );
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      elevation: 0,
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 8,
            right: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigatioBarItem(
                index: 0,
                label: 'Messages',
                icon: Icons.chat,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 0),
              ),
              _NavigatioBarItem(
                index: 1,
                label: 'Notifications',
                icon: Icons.notifications,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: GlowingActionButton(
                    color: AppColors.secondary,
                    icon: Icons.add,
                    onPressed: () {
                      print('TODO: ');
                    }),
              ),
              _NavigatioBarItem(
                index: 2,
                label: 'Calls',
                icon: Icons.call,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 2),
              ),
              _NavigatioBarItem(
                index: 3,
                label: 'Contacts',
                icon: Icons.people,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigatioBarItem extends StatelessWidget {
  const _NavigatioBarItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.index,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  final ValueChanged<int> onTap;

  final String label;
  final IconData icon;
  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              label,
              style: isSelected
                  ? const TextStyle(
                      fontSize: 11,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    )
                  : const TextStyle(
                      fontSize: 11,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
