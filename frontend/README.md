# frontend

A new Flutter project.

## App in a box - Where to start
Once you have cloned the repository, you need to take care of the following steps to get the app up and running.

### 1. Update the package name
Right now the package name is `ch.aaap.aiab.playground`. You need to update this to your own package name. You can do this by running the following command in the root of the project:

```bash
flutter pub run change_app_package_name:main ch.your.package.name
```
This script will update the package name in all the necessary files.

#### Enable auto formatting git hook
To enable auto formatting on commit, run the following command:
```bash
git config core.hooksPath .githooks/
```

This will enable auto formatting on commit for the frontend project, if there are any formatting issues, a message will be displayed that tells you to recommit the new files.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

To run the app with the Firebase Emulator Suite for local development, you can set the USE_EMULATOR environment variable to true. This allows you to interact with local instances of Firebase services without affecting the production environment.

To run the app with the emulator, use the following command:

```bash
  flutter run --dart-define=USE_EMULATOR=true
```

## Push Notification Localization for iOS and Android

### iOS setup

1. Create Localizable Strings for Push Notifications
- Open your iOS project in Xcode.
- In the project navigator, select your project and go to Info.
- Under Localizations, add the languages you want to support.
2. Create `Localizable.strings` files:

- Right-click on your project in the navigator and select New File.
- Choose Strings File and name it Localizable.strings.
- Add your Localizable.strings file to the desired localization languages.
- Each language will have its own Localizable.strings file, where you can add key-value pairs for localized push notification messages

```bash
    "TEST_NOTIFICATION_TITLE" = "Test notification title";
    "TEST_NOTIFICATION_SUBTITLE" = "Test notification subtitle";
```
3. Using Localized Strings in Push Notifications:

When sending push notifications, include the localization key (TEST_NOTIFICATION_TITLE, TEST_NOTIFICATION_SUBTITLE, etc.).
iOS will automatically display the notification in the user’s preferred language if the Localizable.strings files are set up properly.

### Android setup

1. Create Resource Directories for Each Language:

- In your Android project, navigate to the res folder.
- Create a values folder for each language using the naming convention values-<language code>. For example:
  - res/values/ (default language)
  - res/values-es/ (Spanish)
  - res/values-fr/ (French)
2. Create strings.xml Files:

- Inside each language-specific values folder, create a strings.xml file.
- Add key-value pairs for localized push notification messages

Example of strings.xml for English (res/values/strings.xml):

```bash
    <resources>
      <string name="TEST_NOTIFICATION_TITLE">Test notification title</string>
      <string name="TEST_NOTIFICATION_SUBTITLE">Test notification subtitle</string>
    </resources>
```

3. Using Localized Strings in Push Notifications:

- When sending push notifications, reference the string resources by their key names (TEST_NOTIFICATION_TITLE, TEST_NOTIFICATION_SUBTITLE).
- Android will automatically display the notification in the language corresponding to the user’s device locale, based on the strings.xml files.

## Animated splash screen

### Android setup

1. Create the Animated Vector Drawable:

- Create an AVD XML file (e.g., avd_anim.xml) in the res/drawable directory.
- You can use free online tools like Shapeshifter to create custom animations from your images and export them as AVD files.
- To convert an image to a vector drawable (XML), you can use the Vector Asset tool in Android Studio.

2. Follow the Icon Size Guidelines:

- Refer to the instructions in the Android Developer documentation for the recommended icon sizes.

3. Create or Update the Theme:

- In res/values/styles.xml, create a new theme or update an existing one to include the splash screen icon. Set the windowSplashScreenAnimatedIcon to point to the newly created AVD file:
xml

```bash
      <item name="android:windowSplashScreenAnimatedIcon">@drawable/avd_anim</item>
```