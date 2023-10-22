


import 'Utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Global.init();
  if (Platform.isAndroid || Platform.isIOS) {
    await Permission.storage.status.then(
      (status) async {
        if (status.isDenied) {
          await Permission.storage.request();
        }
      },
    );
    await Permission.notification.status.then(
      (status) async {
        if (status.isDenied) {
          await Permission.notification.request();
        }
      },
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppPages.allBlocProviders(context)],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: AppPages.generateRouteSettings,
      ),
    );
  }
}
