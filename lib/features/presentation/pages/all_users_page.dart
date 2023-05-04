import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../cubit/user/user_cubit.dart';
import '../widgets/single_item_user_widget.dart';

class AllUsersPage extends StatefulWidget {
  const AllUsersPage({
    super.key,
    this.query,
    required this.uid,
  });

  final String uid;
  final String? query;

  @override
  State<AllUsersPage> createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserLoaded) {
            final users = userState.users
                .where((element) => element.uid != widget.uid)
                .toList();

            final filteredUsers = users
                .where((user) =>
                    user.name.startsWith(widget.query!) ||
                    user.name.startsWith(widget.query!.toLowerCase()))
                .toList();
            return Column(
              children: [
                Expanded(
                    child: filteredUsers.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "No Users Found yet",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.2)),
                                )
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: filteredUsers.length,
                            itemBuilder: (_, index) {
                              return SingleItemStoriesStatusWidget(
                                user: filteredUsers[index],
                              );
                            },
                          ))
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
