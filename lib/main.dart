import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/dependencies.dart' as di;
import 'firebase_options.dart';
import 'reddit_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  di.setup();

  runApp(const RedditApp());
}
