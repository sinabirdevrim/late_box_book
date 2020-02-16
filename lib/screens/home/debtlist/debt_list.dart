import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_box_book/blocs/user/bloc.dart';
import 'package:late_box_book/blocs/userdb/bloc.dart';
import 'package:late_box_book/customwidget/platform_specific_alert_dialog.dart';
import 'package:late_box_book/model/user_model.dart';
import 'package:late_box_book/widgets/home/bottomsheet/debt_edit_form.dart';
import 'package:late_box_book/widgets/home/user_team_manager.dart';
import 'package:late_box_book/widgets/login/bottomsheet/forgot_password_bottom_sheet.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DebtList extends StatefulWidget {
  DebtList(PageStorageKey keyStorageHome) : super(key: keyStorageHome);

  @override
  _DebtListState createState() => _DebtListState();
}

class _DebtListState extends State<DebtList> {
  UserFirestoreBloc _userFirestoreBloc;

  @override
  void initState() {
    super.initState();
    _userFirestoreBloc = BlocProvider.of<UserFirestoreBloc>(context);
  }

  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _userFirestoreBloc,
        builder: (context, UserFirestoreState state) {
          return Scaffold(
            appBar: AppBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Home Page',
                  ),
                  Text(
                    state.teamName,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      fontFamily: "Varela",
                    ),
                  ),
                ],
              ),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                  ),
                  onPressed: () {
                    PlatformSpecificAlertDialog(
                      header: "User",
                      title: "Log Out Or Change Team?",
                      doneText: 'Log Out',
                      donel2Text: "Change Team",
                      onDialogClick: (isDone) {
                        if (isDone) {
                          BlocProvider.of<UserBloc>(context)
                              .add(UserLogOutEvent());
                        } else {
                          UserTeamManager().showUserTeamBottomSheet(
                              true, context, _userFirestoreBloc);
                        }
                      },
                    ).show(context);

                    //
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: mainBody(state, context),
            ),
          );
        });
  }

  Widget mainBody(UserFirestoreState state, BuildContext context) {
    if (state is UserListFirestoreState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Case",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              inherit: true,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              colorCard("Total Debt", state.totalDebt.toDouble(), context,
                  Color(0xFF17ead9)),
              colorCard("Payment Debt", state.totalPayment.toDouble(), context,
                  Color(0xFF6078ea)),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Payment Percent",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              inherit: true,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width - 32,
            lineHeight: 20.0,
            animation: true,
            animateFromLastPercent: true,
            percent: state.percent <= 100 ? state.percent / 100 : 1.0,
            center: Text(
              state.percent.toString() + "%",
              style: new TextStyle(fontSize: 12.0, color: Colors.white),
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            backgroundColor: Colors.grey.shade300,
            progressColor: Color(0xFF1b52ff),
          ),
          SizedBox(
            height: 20,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Teams",
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
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: state.userModelList.length,
              itemBuilder: (BuildContext context, int index) {
                var data = state.userModelList[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(data.photoUrl),
                      radius: 25,
                    ),
                    title: Text(data.displayName),
                    subtitle: Text(
                        "${data.debtModel.updatedAt.day}/${data.debtModel.updatedAt.month}/${data.debtModel.updatedAt.year}"),
                    trailing: Text(
                      (data.debtModel.totalDept - data.debtModel.totalPayment)
                              .toString() +
                          " TL",
                      style: TextStyle(
                          color: (data.debtModel.totalDept -
                                      data.debtModel.totalPayment) >
                                  0
                              ? Colors.red
                              : Colors.green),
                    ),
                    onTap: () {
                      _showDebtBottomSheet(data);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else if (state is UserEmptyFirestoreState) {
      return Center(child: Container(child: Text("No User :(")));
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  void _showDebtBottomSheet(UserModel userModel) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: DeptEditForm(
                (amount, payment) {
                  _userFirestoreBloc.add(UserFirestoreUpdateDebtEvent(
                      int.parse(amount), int.parse(payment), userModel.uid));
                  Navigator.pop(context);
                },
                userModel.displayName,
                userModel.debtModel.totalDept.toString(),
                userModel.debtModel.totalPayment.toString(),
              ),
            ),
          );
        });
  }
}
Widget colorCard(
    String text, double amount, BuildContext context, Color color) {
  final _media = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.all(15),
    height: 85,
    width: _media.width / 2 - 25,
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 16,
              spreadRadius: 0.2,
              offset: Offset(0, 8)),
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          amount.toString() + " TL",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ),
  );
}
