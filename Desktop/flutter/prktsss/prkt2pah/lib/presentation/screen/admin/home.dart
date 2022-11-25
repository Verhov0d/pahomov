import 'package:flutter/material.dart';
import 'package:prkt2pah/presentation/screen/admin/user/user_screen.dart';
import 'package:prkt2pah/presentation/widgets/drawer_admin.dart';

import 'main/main.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key, this.index = 0}) : super(key: key);
  final int index;
  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int index = 0;

  List<String> appbarTitle = [
    'Главная',
    'Пользователи',
  ];

  List<Widget> content = [
    const Main(),
    UserScreen(),
  ];

  List<String> actionNavigatorList = ['', 'add_user'];

  @override
  void initState() {
    super.initState();
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerAdmin(
        index: (index, title) {
          setState(() {
            this.index = index;
          });
        },
        titleItem: appbarTitle,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: content[index],
      ),
    );
  }
}