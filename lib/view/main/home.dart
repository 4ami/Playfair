import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:playfair/business/playfair.dart';
import 'package:playfair/shared/routes.dart';
import 'package:playfair/view/main/widgets/action_buttons.dart';
import 'package:playfair/view/main/widgets/loading.dart';
import 'package:playfair/view/main/widgets/table.dart';
import 'widgets/page_design.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: AppRoutes.selectedRouteNotifier,
      builder: (context, index, child) => Scaffold(
        body: AppRoutes.current(),
        appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          title: _title(context),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                    AppRoutes.selectedRoute == 0
                        ? "Playfair Page"
                        : "Team Information",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontFamily: 'Exo'),
                  ),
                ),
              ),
              ListTile(
                onTap: () => Navigator.of(context).pop(),
                title: const Icon(Icons.close),
              ),
              ListTile(
                onTap: () => AppRoutes.go(location: Locations.home),
                leading: const Icon(Icons.home_outlined),
                title: const Text("Home"),
                selected: AppRoutes.selectedRoute == 0 ? true : false,
                selectedColor: Colors.greenAccent[700],
              ),
              ListTile(
                onTap: () => AppRoutes.go(location: Locations.teamInfo),
                leading: const Icon(Icons.person_pin_outlined),
                title: const Text("Team Information"),
                selected: AppRoutes.selectedRoute == 1 ? true : false,
                selectedColor: Colors.greenAccent[700],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _title(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            textAlign: TextAlign.center,
            "Playfair Cipher",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontFamily: 'Exo',
                  color: Colors.grey[800],
                ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Image.asset('assets/shield.png', width: 50),
          ),
        ],
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _playfairKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();
  bool encrypt = false;
  bool choice = false;
  bool isLoading = false;
  bool showGrid = false;
  String gridAlphabet = '';
  @override
  void dispose() {
    _controller.dispose();
    _messageController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ...pageDesign(
            context: context,
            blur: showGrid,
          ),
          _mainBody(context),
          isLoading ? const Loading() : const SizedBox(),
        ],
      ),
    );
  }

  SingleChildScrollView _mainBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50.0, vertical: 50),
                child: Container(
                  height: 200,
                  decoration: _titleDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _secretField(context),
                      !showGrid ? _showGridButton(context) : const SizedBox(),
                      // showGrid ? _processFeilds(context) : const SizedBox(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    showGrid ? _gridTitle(context) : const SizedBox(),
                    showGrid
                        ? EncryptionDecryptionTable(alphabet: gridAlphabet)
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
          (showGrid)
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _action(
                        context: context,
                        onPressed: () => setState(() {
                          encrypt = true;
                          choice ? 0 : choice = true;
                        }),
                        color: Colors.cyan[100]!,
                        text: "Encryption",
                      ),
                      const SizedBox(width: 50),
                      _action(
                        context: context,
                        onPressed: () => setState(() {
                          encrypt = false;
                          choice ? 0 : choice = true;
                        }),
                        color: Colors.redAccent[100]!,
                        text: "Decryption",
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          choice
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      showGrid ? _processFeilds(context) : const SizedBox(),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  SizedBox _action(
      {required BuildContext context,
      required VoidCallback onPressed,
      required Color color,
      required String text}) {
    return SizedBox(
      width: 250,
      child: FloatingActionButton(
        shape: const StadiumBorder(),
        backgroundColor: Colors.white,
        onPressed: onPressed,
        hoverColor: color,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontFamily: 'Exo',
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  Form _processFeilds(BuildContext context) {
    return Form(
      key: _playfairKey,
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width * .9,
        decoration: _titleDecoration().copyWith(
          color: Colors.grey[50],
        ),
        child: Row(
          children: [
            Flexible(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .2),
                    child: TextFormField(
                      validator: (v) {
                        if (v!.isEmpty) return 'Message can not be empty!';
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(v)) {
                          return 'Invalid message!';
                        }
                        return null;
                      },
                      controller: _messageController,
                      decoration: _fieldDecoration(
                        context,
                        'Message',
                        'Enter message to ${encrypt ? 'Encrypt' : 'Decrypt'}: ',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .2),
                    child: TextFormField(
                      controller: _resultController,
                      decoration: _fieldDecoration(
                        context,
                        'Result',
                        '',
                      ).copyWith(enabled: false),
                    ),
                  ),
                ],
              ),
            ),
            ActionButtons(
              onPressed: encrypt ? _encryption : _decryption,
            ),
          ],
        ),
      ),
    );
  }

  void _decryption() {
    if (_playfairKey.currentState!.validate()) {
      Playfair decryption = Playfair(key: gridAlphabet);
      List<String> block = decryption.divideMessage(
        message: _messageController.text.trim(),
      );
      log(block.toString());
      _messageController.text = block.join(' ');
      String decrpted = decryption.decrypt(
        message: block,
        key: gridAlphabet,
      );
      log("decrypted text: $decrpted");
      _resultController.text = decrpted;
    }
  }

  void _encryption() {
    if (_playfairKey.currentState!.validate()) {
      Playfair encryption = Playfair(key: gridAlphabet);
      List<String> block = encryption.divideMessage(
        message: _messageController.text.trim(),
      );
      log(block.toString());
      _messageController.text = block.join(' ');
      String encryptedText = encryption.encrypt(
        message: block,
        key: gridAlphabet,
      );
      log('encrypted text: $encryptedText');
      _resultController.text = encryptedText;
    }
  }

  Padding _gridTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
      child: Text(
        "Encryption / Decryption Grid 5x5",
        style:
            Theme.of(context).textTheme.titleLarge!.copyWith(fontFamily: 'Exo'),
      ),
    );
  }

  Form _secretField(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SizedBox(
          width: 350,
          child: TextFormField(
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontFamily: 'Exo', fontSize: showGrid ? 25 : 16),
            enabled: !showGrid,
            validator: (v) {
              if (v!.isEmpty) return 'Secret Key Required';
              if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(v)) {
                return 'Secret Key Contains Only Alphabet!';
              }
              return null;
            },
            controller: _controller,
            decoration:
                _fieldDecoration(context, 'Secret Key', 'Enter your secret: '),
          ),
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration(
      BuildContext context, String label, String hint) {
    return InputDecoration(
      label: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontFamily: 'Exo'),
      ),
      hintText: hint,
      border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black)),
      focusColor: Colors.black,
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black)),
    );
  }

  Padding _showGridButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 100),
      child: ElevatedButton(
        style: _buttonStyle(),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            //show loading
            setState(() => isLoading = true);
            //get text + remove spaces
            String key = _controller.text.trim();
            key = key.replaceAll(' ', '');
            key = key.toUpperCase();
            log('Secret is: $key');
            //generate Grid Alphabet order from the key.
            Playfair playfair = Playfair(key: key);
            setState(() => gridAlphabet = playfair.gridAlphabet());
            log('Grid Alphabet: $gridAlphabet / ${gridAlphabet.length}');
            //delay then show grid and remove loading
            await Future<void>.delayed(
              const Duration(microseconds: 1000),
            ).whenComplete(() {
              setState(() {
                isLoading = false;
                showGrid = true;
              });
            });
          }
        },
        child: Text(
          "Generate Grid",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold, fontFamily: 'Exo'),
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ButtonStyle(
      backgroundColor: const MaterialStatePropertyAll(Colors.white),
      shadowColor: MaterialStatePropertyAll(Colors.grey[200]),
      overlayColor: MaterialStatePropertyAll(Colors.grey[50]),
      surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent),
    );
  }

  BoxDecoration _titleDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade200,
          blurRadius: 10,
          spreadRadius: 6,
        ),
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 6,
          spreadRadius: 2,
          blurStyle: BlurStyle.inner,
        )
      ],
    );
  }
}
