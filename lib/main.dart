import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibtikar_task/modules/popular_people/popular_people_screen.dart';
import 'package:ibtikar_task/shared/di/di.dart';

import 'shared/network/cubit/cubit.dart';
import 'shared/network/cubit/states.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkCubit>(
          create: (BuildContext context) => di<NetworkCubit>(),
        ),
      ],
      child: BlocListener<NetworkCubit, NetworkStates>(
        listenWhen: (previous, current) {
            return previous.runtimeType != current.runtimeType;
        },
        listener: (context, state) {
          switch (state.runtimeType) {
            case UnauthenticatedState:
              // Nav to login for example
              return;
            case SocketErrorState:
              // Nav to no internet screen
              break;
            case ClientErrorState:
              break;
            case ServerErrorState:
              break;
            case ErrorState:
              break;
            default:
          }
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.teal,
            ),
            home: const PopularPeopleScreen(),
          ),
        ),
      ),
    );
  }
}
