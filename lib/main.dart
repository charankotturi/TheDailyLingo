// import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:thedailylingo/rest_client.dart';
import 'package:thedailylingo/verification_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Daily Lingo',
      navigatorObservers: [ChuckerFlutter.navigatorObserver],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'The Daily Lingo'),
      onGenerateRoute: (settings) {
        if (settings.name == '/verify-email') {
          final args = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return VerificationPage(emailId: args);
            },
          );
        }
        return null;
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _emailController = TextEditingController();

  String errorMsg = "";

  void showErrorMessage(String errorMsg) {
    setState(() {
      this.errorMsg = errorMsg;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> onSubscribeClick() async {
    showErrorMessage("Loading...");

    final response = await verifyEmailIdRequest(_emailController.value.text);

    if (response.statusCode == 200) {
      showErrorMessage("");
      openVerifyEmailPage();
    } else {
      showErrorMessage("Something went wrong please try again!");
    }
  }

  void openVerifyEmailPage() {
    FocusScope.of(context).unfocus();

    Navigator.pushNamed(
      context,
      '/verify-email',
      arguments: _emailController.value.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 70.0, left: 20.0, right: 20.0, bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.title,
                  style: Theme.of(context).textTheme.headlineLarge),
              Expanded(child: Container()),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.all(20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: onSubscribeClick,
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Subscribe',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ),
              ),
              Text(
                errorMsg,
                style: const TextStyle(color: Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }
}
