import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../const.dart';
import '../cubit/auth/auth_cubit.dart';
import '../cubit/user/user_cubit.dart';
import '../widgets/customTabBar.dart';
import '../widgets/theme/style.dart';
import 'all_users_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchTextController = TextEditingController();
  final PageController _pageController = PageController(initialPage: 0);

  List<Widget> get pages => [
        AllUsersPage(
          uid: widget.uid,
          query: _searchTextController.text,
        ),
        ProfilePage(
          uid: widget.uid,
        )
      ];

  int _currentPageIndex = 0;

  bool _isSearch = false;

  @override
  void dispose() {
    _searchTextController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserCubit>(context).getUsers();
    _searchTextController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: _isSearch == false ? primaryColor : Colors.transparent,
        title: _isSearch == false
            ? Text("${AppConst.appName}")
            : Container(
                height: 0.0,
                width: 0.0,
              ),
      ),
      body: Container(
        child: Column(
          children: [
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    enabled: true,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        BlocProvider.of<AuthCubit>(context).loggedOut();
                      },
                      child: const Text("logout"),
                    ),
                  ),
                ];
              },
            ),
            _isSearch == false
                ? CustomTabBar(
                    index: _currentPageIndex,
                    tabClickListener: (index) {
                      print(index);
                      _currentPageIndex = index;
                      _pageController.jumpToPage(index);
                    },
                  )
                : Container(
                    width: 0.0,
                    height: 0.0,
                  ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemCount: pages.length,
                itemBuilder: (_, index) {
                  return pages[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
