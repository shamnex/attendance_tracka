library serializers;

import 'package:attendance_tracka/src/features/app/bloc/app_state.dart';
import 'package:attendance_tracka/src/features/app/model/app_mode.dart';
import 'package:attendance_tracka/src/features/app/model/app_theme.dart';
import 'package:attendance_tracka/src/features/app/model/meetup_model.dart';
import 'package:attendance_tracka/src/features/app/model/user_model.dart';
import 'package:attendance_tracka/flavor/flavor.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/bloc/participants/participants_bloc_state.dart';
import 'package:attendance_tracka/src/features/home/screens/organiser/bloc/volunteers/bloc.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_collection/built_collection.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  AppState,
  AppMode,
  User,
  Flavor,
  AppTheme,
  User,
  VolunteersState,
  ParticipantsState,
  UserType,
])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
