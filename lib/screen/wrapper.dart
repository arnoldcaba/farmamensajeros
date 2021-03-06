import 'package:farmamensajeros/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    // retunr auth or home
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}