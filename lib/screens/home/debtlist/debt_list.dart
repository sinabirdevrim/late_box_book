import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_box_book/blocs/user/bloc.dart';
import 'package:late_box_book/blocs/userdb/bloc.dart';
import 'package:late_box_book/model/user_model.dart';
import 'package:late_box_book/widgets/home/bottomsheet/debt_edit_form.dart';

class DebtList extends StatefulWidget {
  DebtList(PageStorageKey keyStorageHome) : super(key: keyStorageHome);

  @override
  _DebtListState createState() => _DebtListState();
}

class _DebtListState extends State<DebtList> {
  Widget build(BuildContext context) {
    UserFirestoreBloc _userFirestoreBloc =
        BlocProvider.of<UserFirestoreBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("User"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
            ),
            onPressed: () {
              BlocProvider.of<UserBloc>(context).add(UserLogOutEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder(
        bloc: _userFirestoreBloc,
        builder: (context, UserFirestoreState state) {
          if (state is UserListFirestoreState) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.userModelList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8),
                    leading: CircleAvatar(
                      child: Text("1"),
                      radius: 25,
                    ),
                    title: Text(state.userModelList[index].displayName),
                    subtitle: Text("Borç: " +
                        state.userModelList[index].debtModel.value.toString()),
                    trailing: Icon(Icons.more_vert),
                    onTap: () {
                      _showDebtBottomSheet(state.userModelList[index]);
                      debugPrint("onTap $index");
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: Container(child: Text("No User :(")));
          }
        },
      ),
    );
  }

  void _showDebtBottomSheet(UserModel userModel) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return DeptEditForm((amount) {}, userModel.displayName,
              userModel.debtModel.value.toString());
        });
  }
}
