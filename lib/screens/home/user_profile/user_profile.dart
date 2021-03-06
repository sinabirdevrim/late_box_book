import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:late_box_book/blocs/profile/bloc.dart';
import 'package:late_box_book/blocs/userdb/bloc.dart';
import 'package:toast/toast.dart';

class UserProfile extends StatefulWidget {
  UserProfile(PageStorageKey keyStorageHome) : super(key: keyStorageHome);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File _profilePhoto;
  ProfileBloc _profileBloc;
  UserFirestoreBloc _userFirestoreBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _userFirestoreBloc = BlocProvider.of<UserFirestoreBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16.0),
      child: BlocBuilder(
          bloc: _profileBloc,
          builder: (_, ProfileState state) {
            if (state is InitialProfileState ||
                state is ProfileUpdateUserState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 40),
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundImage: _profilePhoto != null
                          ? FileImage(_profilePhoto)
                          : NetworkImage(
                              state.mUserModel.photoUrl,
                            ),
                      radius: 50,
                    ),
                    onTap: () {
                      _onGallery();
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    state.mUserModel.displayName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    state.mUserModel.email,
                    style: TextStyle(),
                  ),
                  SizedBox(height: 25),
                  buildUserDebtInfos(state),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Your Teams",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Varela",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  buildTeamListView(state),
                ],
              );
            } else {
              return Text("Loading");
            }
          }),
    ));
  }

  Padding buildUserDebtInfos(ProfileState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                state.teamCount.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Team",
                style: TextStyle(),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                state.totalDept.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Total Debt",
                style: TextStyle(),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                state.totalPaymnet.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Total Payment",
                style: TextStyle(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Expanded buildTeamListView(ProfileState state) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        itemCount: state.userDebts.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: ListTile(
              title: Text("Team Name: " + state.userDebts[index].team),
              subtitle: Text("The remaining amount : " +
                  (state.userDebts[index].totalDebt -
                          state.userDebts[index].totalPayment)
                      .toString() +
                  " ${state.userDebts[index].currencyType!=null?state.userDebts[index].currencyType:"TL"}"),
              onTap: () {
                _userFirestoreBloc.add(
                    UserFirestoreGetUsereEvent(state.userDebts[index].team));
                Toast.show(
                    "Your team has been changed to ${state.userDebts[index].team}",
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM);
              },
            ),
          );
        },
      ),
    );
  }

  void _onGallery() async {
    var _photo = await ImagePicker.pickImage(source: ImageSource.gallery);
    _profileBloc.add(ProfileUpdateImageEvent(_photo));
    setState(() {
      _profilePhoto = _photo;
    });
  }
}
