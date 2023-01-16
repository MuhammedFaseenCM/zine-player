import 'dart:developer';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';
import 'package:zineplayer/main.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late Color dialogPickerColor;
  late String boxcolor;
  bool loading = true;
  @override
  void initState() {
    barcolorFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Text("Settings"),
              centerTitle: true,
            ),
            body: Column(
              children: [
                ListTile(
                  title: const Text("Dark mode"),
                  trailing: Switch(
                    value: themeManager.themeMode == ThemeMode.dark,
                    onChanged: (newvalue) {
                      themeManager.toggleTheme(newvalue);
                      log("$newvalue");
                    },
                  ),
                ),
                ListTile(
                  title: const Text("Frame color"),
                  trailing: ColorIndicator(
                    width: 44,
                    height: 44,
                    borderRadius: 4,
                    color: dialogPickerColor,
                    onSelectFocus: false,
                    onSelect: () async {
                      final Color colorBeforeDialog = dialogPickerColor;
                      log("$dialogPickerColor");
                      if (!(await colorPickerDialog())) {
                        setState(() {
                          dialogPickerColor = colorBeforeDialog;
                        });
                      }
                    },
                  ),
                )
              ],
            ),
          );
  }

  barcolorFunction() async {
    final colorhive = await Hive.openBox<FrameColor>('colorBox');
    FrameColor? bar = colorhive.getAt(0);

    boxcolor = bar!.color;
    int colorInt = int.parse(
        boxcolor.substring(boxcolor.indexOf("(") + 1, boxcolor.indexOf(")")));
    setState(() {
      dialogPickerColor = Color(colorInt);
      loading = false;
    });
  }

  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);
  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };
  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      color: dialogPickerColor,
      onColorChanged: (Color color) {
        setState(() {
          dialogPickerColor = color;
          log("$color");
        });
        dynamic pickedcolor = FrameColor(color: color.toString());
        pickColor(pickedcolor);
      },
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodyMedium,
      colorCodePrefixStyle: Theme.of(context).textTheme.bodySmall,
      selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      actionsPadding: const EdgeInsets.all(16),
      constraints:
          const BoxConstraints(minHeight: 480, minWidth: 300, maxWidth: 320),
    );
  }
}

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TextTheme(
        subtitle1: TextStyle(
            color: black, fontSize: 15.0, fontWeight: FontWeight.bold)));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TextTheme(
        subtitle1: TextStyle(
            color: white, fontSize: 15.0, fontWeight: FontWeight.bold)));

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  get themeMode => _themeMode;
  toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
