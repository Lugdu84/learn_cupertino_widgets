import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Mariage { married, single, pacs, sectional }

Map<Mariage, String> mariageString = <Mariage, String>{
  Mariage.married: "Marié",
  Mariage.pacs: "Pacsé",
  Mariage.sectional: "En coupe",
  Mariage.single: "Célibataire"
};

class AdaptivePage extends StatefulWidget {
  final TargetPlatform platform;

  const AdaptivePage({Key? key, required this.platform}) : super(key: key);

  @override
  AdaptivePageState createState() => AdaptivePageState();
}

class AdaptivePageState extends State<AdaptivePage> {
  bool loveFlutter = true;
  bool switchValue = true;
  double minValue = 0;
  double maxValue = 100;
  double currentValue = 25;
  String text = "";
  List<String> animals = ["Chien", "Chat", "Lion", "Ours", "Chameau"];
  int selectedIndex = 0;
  int selectedAnimals = 0;
  Mariage selectedSegemented = Mariage.single;

  @override
  Widget build(BuildContext context) {
    return scaffold();
  }

  bool isIOS() => widget.platform == TargetPlatform.iOS;

  Widget scaffold() {
    return (isIOS())
        ? CupertinoPageScaffold(navigationBar: navBar(), child: body())
        : Scaffold(
            appBar: appBar(),
            body: body(),
          );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("Notre design sous android"),
    );
  }

  CupertinoNavigationBar navBar() {
    return const CupertinoNavigationBar(
      middle: Text("Notre design sous iOS"),
      backgroundColor: Colors.red,
    );
  }

  Widget body() {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 10)),
        button(),
        const Divider(),
        switchRow(),
        const Divider(),
        sliderColumn(),
        const Divider(),
        myTextField(),
        Text(text),
        const Divider(),
        fab(),
        const Divider(),
        pickerAnimals(),
        const Divider(),
        myFirstSegmented(),
        mysSegmented()
      ],
    );
  }

  Widget button() {
    return (isIOS())
        ? CupertinoButton(
            onPressed: () => handlerPressedButton(),
            color: Colors.red,
            child: textButton(),
          )
        : ElevatedButton(
            onPressed: () => handlerPressedButton(), child: textButton());
  }

  Text textButton() {
    return Text(loveFlutter ? "I love flutter" : "I prefer swiftUI");
  }

  handlerPressedButton() {
    setState(() {
      loveFlutter = !loveFlutter;
    });
  }

  Row switchRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(switchValue ? "Je suis vrai" : "Je suis faux"),
        switchAdaptive()
      ],
    );
  }

  Widget switchAdaptive() {
    return (isIOS())
        ? CupertinoSwitch(value: switchValue, onChanged: onSwitchChange)
        : Switch(value: switchValue, onChanged: onSwitchChange);
  }

  onSwitchChange(bool newValue) {
    setState(() {
      switchValue = newValue;
    });
  }

  Widget sliderColumn() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text("Valeur du slider : ${currentValue.toInt()}"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(minValue.toInt().toString()),
                Expanded(child: slider()),
                Text(maxValue.toInt().toString()),
              ],
            )
          ],
        ));
  }

  Widget slider() {
    return (isIOS())
        ? CupertinoSlider(
            min: minValue,
            max: maxValue,
            value: currentValue,
            onChanged: onChangeSlider)
        : Slider(
            min: minValue,
            max: maxValue,
            value: currentValue,
            onChanged: onChangeSlider);
  }

  onChangeSlider(double newValue) {
    setState(() {
      currentValue = newValue;
    });
  }

  Widget myTextField() {
    return (isIOS())
        ? CupertinoTextField(
            onSubmitted: submittedText,
            placeholder: "Entrez quelque chose",
          )
        : TextField(
            onSubmitted: submittedText,
            decoration: const InputDecoration(hintText: "Entrez quelque chose"),
          );
  }

  submittedText(String newValue) {
    setState(() {
      text = newValue;
    });
  }

  Widget actionSheet() {
    return CupertinoActionSheet(
      title: const Text("Notre ActionSheet"),
      message: const Text("Notre message"),
      actions: [
        CupertinoActionSheetAction(
          onPressed: close,
          isDefaultAction: true,
          child: const Text("Oui"),
        ),
        CupertinoActionSheetAction(
          onPressed: close,
          isDestructiveAction: true,
          child: const Text("Non"),
        ),
        CupertinoActionSheetAction(
          onPressed: close,
          child: const Text("Peut-être"),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: close,
        child: const Text("Annuler"),
      ),
    );
  }

  FloatingActionButton fab() {
    return FloatingActionButton(
        child: const Icon(Icons.apartment),
        onPressed: () {
          if (isIOS()) {
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext ctx) {
                  return actionSheet();
                });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Pas implémenté sur iOS")));
          }
        });
  }

  void close() {
    Navigator.of(context).pop();
  }

  Row pickerAnimals() {
    return Row(
      children: [
        Text("Votre animal préféré est ${animals[selectedIndex]}"),
        isIOS()
            ? CupertinoButton(
                child: const Text("test"),
                onPressed: () {
                  _showDialog(CupertinoPicker(
                      magnification: 1.22,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: 30,
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      children: List<Widget>.generate(animals.length, (index) {
                        return Center(
                          child: Text(animals[index]),
                        );
                      })));
                })
            : Container()
      ],
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 150,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  CupertinoSegmentedControl myFirstSegmented() {
    return CupertinoSegmentedControl(
        selectedColor: Colors.red,
        unselectedColor: Colors.green,
        pressedColor: Colors.blueAccent,
        children: segmentedMap(),
        onValueChanged: (index) {
          selectedAnimals = index as int;
        });
  }

  CupertinoSlidingSegmentedControl mysSegmented() {
    return CupertinoSlidingSegmentedControl(
        backgroundColor: Colors.grey,
        thumbColor: Colors.green,
        groupValue: selectedSegemented,
        children: const <Mariage, Widget>{
          Mariage.married: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Marié',
              style: TextStyle(color: CupertinoColors.white),
            ),
          ),
          Mariage.single: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Célibataire',
              style: TextStyle(color: CupertinoColors.white),
            ),
          ),
          Mariage.pacs: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Pacsé',
              style: TextStyle(color: CupertinoColors.white),
            ),
          ),
          Mariage.sectional: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'En coupe',
              style: TextStyle(color: CupertinoColors.white),
            ),
          ),
        },
        onValueChanged: (dynamic value) {
          setState(() {
            selectedSegemented = value;
          });
        });
  }

  Map<int, Widget> segmentedMap() {
    Map<int, Widget> newMap = {};
    for (var x = 0; x < animals.length; x++) {
      newMap[x] = Text(
        animals[x],
        style: const TextStyle(color: Colors.white),
      );
    }
    return newMap;
  }
}
