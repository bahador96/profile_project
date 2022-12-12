import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile_app/constants/constants.dart';

import 'package:profile_app/widgets/skill_item.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      theme: (_themeMode == ThemeMode.dark)
          ? MyAppThemeConfig.dark().getTheme(_locale.languageCode)
          : MyAppThemeConfig.light().getTheme(_locale.languageCode),
      home: MyHomePage(
        toggleThemeMode: () {
          setState(() {
            if (_themeMode == ThemeMode.dark) {
              _themeMode = ThemeMode.light;
            } else {
              _themeMode = ThemeMode.dark;
            }
          });
        },
        selectedLanguageChanged: (Language newSelectedLanguageByUser) {
          setState(() {
            _locale = newSelectedLanguageByUser == Language.en
                ? const Locale('en')
                : const Locale('fa');
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(Language language) selectedLanguageChanged;

  const MyHomePage({
    super.key,
    required this.toggleThemeMode,
    required this.selectedLanguageChanged,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum SkillType {
  photoshop,
  xd,
  illustrator,
  aftereffect,
  lighrtroom,
}

enum Language {
  en,
  fa,
}

class _MyHomePageState extends State<MyHomePage> {
  SkillType _skill = SkillType.photoshop;
  Language _language = Language.en;

  void _updateSelectedSkill(SkillType skillType) {
    widget.selectedLanguageChanged(_language);
    setState(() {
      _skill = skillType;
    });
  }

  void _updateSelectedLanguage(Language language) {
    widget.selectedLanguageChanged(language);
    setState(() {
      _language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    var obscureText = true;
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.profileTitle),
        actions: [
          const Icon(
            CupertinoIcons.chat_bubble,
          ),
          InkWell(
            onTap: widget.toggleThemeMode,
            child: const Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
              child: Icon(
                CupertinoIcons.ellipsis_vertical,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/profile_image.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localization.name,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(height: 2),
                        Text(localization.job),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.location,
                              size: 14,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              localization.location,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    CupertinoIcons.heart,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 60, 16),
              child: Text(
                localization.summary,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(localization.selectedLanguage),
                  CupertinoSlidingSegmentedControl<Language>(
                    groupValue: _language,
                    thumbColor: Colors.blueAccent.shade700,
                    children: {
                      Language.en: Text(
                        localization.enLanguage,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Language.fa: Text(
                        localization.faLanguage,
                        style: const TextStyle(fontSize: 14),
                      ),
                    },
                    onValueChanged: (value) {
                      if (value != null) {
                        _updateSelectedLanguage(value);
                      }
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    localization.skills,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    CupertinoIcons.chevron_down,
                    size: 12,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                direction: Axis.horizontal,
                children: [
                  Skill(
                    type: SkillType.photoshop,
                    title: 'Photoshop',
                    imagePath: 'assets/images/app_icon_01.png',
                    shadowColor: Colors.blue,
                    isActive: _skill == SkillType.photoshop,
                    onTap: () {
                      _updateSelectedSkill(SkillType.photoshop);
                    },
                  ),
                  Skill(
                    type: SkillType.xd,
                    title: 'Adobe Xd',
                    imagePath: 'assets/images/app_icon_05.png',
                    shadowColor: Colors.blue,
                    isActive: _skill == SkillType.xd,
                    onTap: () {
                      _updateSelectedSkill(SkillType.xd);
                    },
                  ),
                  Skill(
                    type: SkillType.illustrator,
                    title: 'Illustrator',
                    imagePath: 'assets/images/app_icon_04.png',
                    shadowColor: Colors.pink,
                    isActive: _skill == SkillType.illustrator,
                    onTap: () {
                      _updateSelectedSkill(SkillType.illustrator);
                    },
                  ),
                  Skill(
                    type: SkillType.aftereffect,
                    title: 'After Effect',
                    imagePath: 'assets/images/app_icon_03.png',
                    shadowColor: Colors.orange,
                    isActive: _skill == SkillType.aftereffect,
                    onTap: () {
                      _updateSelectedSkill(SkillType.aftereffect);
                    },
                  ),
                  Skill(
                    type: SkillType.lighrtroom,
                    title: 'Lighrtroom',
                    imagePath: 'assets/images/app_icon_02.png',
                    shadowColor: Colors.blue.shade700,
                    isActive: _skill == SkillType.lighrtroom,
                    onTap: () {
                      _updateSelectedSkill(SkillType.lighrtroom);
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localization.personalInformation,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      labelText: localization.email,
                      prefixIcon: const Icon(CupertinoIcons.at),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      labelText: localization.password,
                      prefixIcon: const Icon(CupertinoIcons.lock),
                      suffixIcon: const Icon(Icons.visibility),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(localization.save),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
