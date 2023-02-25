import 'package:flutter/material.dart';

import 'core/dependencies.dart' as di;
import 'reddit_app.dart';

void main() {
  di.setup();

  runApp(const RedditApp());
}
