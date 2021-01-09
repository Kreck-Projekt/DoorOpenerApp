import 'package:flutter/material.dart';
import 'package:raspberry_pi_door_opener/frontend/screens/set_password.dart';
import 'package:raspberry_pi_door_opener/utils/localizations/app_localizations.dart';
import 'package:raspberry_pi_door_opener/utils/other/data_manager.dart';
import 'package:raspberry_pi_door_opener/utils/other/ip_validator.dart';

class FirstStart extends StatefulWidget {
  @override
  _FirstStartState createState() => _FirstStartState();
}

class _FirstStartState extends State<FirstStart> {
  final _formKey = GlobalKey<FormState>();
  final ipController = TextEditingController();
  final portController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)
                        .translate('first_start_welcome'),
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)
                        .translate('first_start_explanation'),
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontSize: 20, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                  // SizedBox(height: 10,),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            style: Theme.of(context).textTheme.bodyText1,
                            controller: ipController,
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String value) {
                              return ipValidator(value, context);
                            },
                            decoration: InputDecoration(
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              labelText: AppLocalizations.of(context)
                                  .translate('first_start_ip_label'),
                              hintStyle: Theme.of(context).textTheme.bodyText1,
                              hintText: AppLocalizations.of(context)
                                  .translate('first_start_ip_hint'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            style: Theme.of(context).textTheme.bodyText1,
                            controller: portController,
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return AppLocalizations.of(context)
                                    .translate('first_start_port_validate');
                              } else
                                return null;
                            },
                            decoration: InputDecoration(
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              labelText: AppLocalizations.of(context)
                                  .translate('first_start_port_label'),
                              hintStyle: Theme.of(context).textTheme.bodyText1,
                              hintText: AppLocalizations.of(context)
                                  .translate('first_start_port_hint'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.tealAccent,
        onPressed: () {
          print(_formKey.currentState.validate());
          if (_formKey.currentState.validate()) {
            String ipAddress = ipController.text.toString();
            int port =  int.parse(portController.text.toString());
            print('IP-Address: $ipAddress');
            print('Port: $port');
            DataManager().safeIP(ipAddress);
            DataManager().safePort(port);
            Navigator.of(context).pop(MaterialPage(child: SetPassword()));
          } else
            return ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 3),
                backgroundColor: Colors.redAccent,
                content: Text(
                  AppLocalizations.of(context)
                      .translate('first_start_snackbar_message'),
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            );
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
