import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/blocs/blocs.dart';
import '../../features/community/presentation/blocs/blocs.dart';
import '../dependencies.dart';

class GlobalBlocProviders {
  static final List<BlocProvider> blocProviders = [
    BlocProvider<AuthBlocImpl>.value(value: sl<AuthBlocImpl>()),
    BlocProvider<CommunityBlocImpl>.value(value: sl<CommunityBlocImpl>()),
  ];
}
