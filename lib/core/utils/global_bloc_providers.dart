import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../dependencies.dart';

class GlobalBlocProviders {
  static final List<BlocProvider> blocProviders = [
    BlocProvider<AuthBloc>.value(value: sl<AuthBloc>()),
    BlocProvider<CommunityListBloc>.value(value: sl<CommunityListBloc>()),
  ];
}
