import 'package:attendance_tracka/flavor/flavor.dart';
import 'package:attendance_tracka/src/features/app/bloc/app_bloc.dart';
import 'package:attendance_tracka/src/features/app/screens/app.dart';

import 'package:attendance_tracka/src/service_locator.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';

import 'src/features/auth/bloc/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await di.init(Flavor.development);
  BlocSupervisor.delegate = di.sl.get<HydratedBlocDelegate>();
  runApp(
    MultiProvider(
      providers: [
        BlocProvider<AppBloc>(create: (_) => di.sl.get<AppBloc>()),
        BlocProvider<AuthBloc>(create: (_) => di.sl.get<AuthBloc>()..add(BeginAuthentication())),
      ],
      child: const App(),
    ),
  );
}
