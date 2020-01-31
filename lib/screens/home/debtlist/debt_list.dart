import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:late_box_book/blocs/user/bloc.dart';
import 'package:late_box_book/blocs/userdb/bloc.dart';
import 'package:late_box_book/model/user_model.dart';
import 'package:late_box_book/widgets/home/bottomsheet/debt_edit_form.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Home"),
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
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Case",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      inherit: true,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      colorCard("Total Debt", state.totalDebt.toDouble(),
                          context, Color(0xFF17ead9)),
                      colorCard("Payment Debt", state.totalPayment.toDouble(),
                          context, Color(0xFF6078ea)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Payment Percent",
                    style: TextStyle(
                      fontSize: 24,
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
                    percent: state.percent / 100,
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
                  Text(
                    "Teams",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      inherit: true,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
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
                            subtitle: Text("The remaining amount : " +
                                (state.userModelList[index].debtModel
                                            .totalDept -
                                        state.userModelList[index].debtModel
                                            .totalPayment)
                                    .toString() +" TL"),
                            trailing: Icon(Icons.more_vert),
                            onTap: () {
                              _showDebtBottomSheet(state.userModelList[index]);
                              debugPrint("onTap $index");
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
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
          return DeptEditForm(
            (amount, payment) {
              _userFirestoreBloc.add(UserFirestoreUpdateDebtEvent(
                  int.parse(amount), int.parse(payment), userModel.uid));
            },
            userModel.displayName,
            userModel.debtModel.totalDept.toString(),
            userModel.debtModel.totalPayment.toString(),
          );
        });
  }
}

Widget colorCard(
    String text, double amount, BuildContext context, Color color) {
  final _media = MediaQuery.of(context).size;
  return Container(
    padding: EdgeInsets.all(15),
    height: 90,
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
