import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../data/remote/data_sources/storage_provider.dart';
import '../../data/remote_data_source/models/user_model.dart';
import '../../domain/entities/user_entity.dart';
import '../cubit/user/user_cubit.dart';
import '../widgets/theme/style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.uid,
  });

  final String uid;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController? _nameController;
  TextEditingController? _statusController;
  TextEditingController? _emailController;
  TextEditingController? _numController;

  File? _image;
  String? _profileUrl;
  String? _username;
  String? _phoneNumber;
  final picker = ImagePicker();

  void dispose() {
    _nameController!.dispose();
    _statusController!.dispose();
    _emailController!.dispose();
    _numController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _nameController = TextEditingController(text: "");
    _statusController = TextEditingController(text: "");
    _emailController = TextEditingController(text: "");
    _numController = TextEditingController(text: "");
    super.initState();
  }

  Future getImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          StorageProviderRemoteDataSource.uploadFile(file: _image!)
              .then((value) {
            print("profileUrl");
            setState(() {
              _profileUrl = value;
            });
          });
        } else {
          print('No image selected.');
        }
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          return _profileWidget(userState.users);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _profileWidget(List<UserEntity> users) {
    final user = users.firstWhere((user) => user.uid == widget.uid,
        orElse: () => UserModel());
    _nameController!.value = TextEditingValue(text: "${user.name}");
    _emailController!.value = TextEditingValue(text: "${user.email}");

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                  color: color747480,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Remove profile photo',
              style: TextStyle(
                  color: greenColor, fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 28,
            ),
            Container(
              margin: EdgeInsets.only(left: 22, right: 22),
              height: 47,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: color747480.withOpacity(.2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                controller: _nameController,
                onChanged: (textData) {
                  _username = textData;
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  hintText: 'username',
                  hintStyle:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 22, right: 22),
              height: 47,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: color747480.withOpacity(.2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: AbsorbPointer(
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Colors.grey,
                    ),
                    hintText: 'email',
                    hintStyle:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 22, right: 22),
              height: 47,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: color747480.withOpacity(.2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                controller: _statusController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.stadium,
                    color: Colors.grey,
                  ),
                  hintText: 'status',
                  hintStyle: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            const Divider(
              thickness: 1,
              endIndent: 15,
              indent: 15,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                _updateProfile();
              },
              child: Container(
                  margin: const EdgeInsets.only(left: 22, right: 22),
                  alignment: Alignment.center,
                  height: 44,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void _updateProfile() {
    BlocProvider.of<UserCubit>(context).getUpdateUser(
      user: UserEntity(
        uid: widget.uid,
        name: _nameController!.text,
      ),
    );
  }
}
