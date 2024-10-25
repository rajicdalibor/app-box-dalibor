# App in a box
📱🎁 Where you take your mobile app experience to the next level.

## Phase 1
This template can be used to create a new mobile experience for a Start-up in a box project.

The developer can create a new repository with this template and change the necessary configuration details and have the new mobile app up and running in _no-time_ against a dedicated preconfigured backend system.

### Steps

1. Install `flutter` cli; recommended `fvm` - flutter version manager

2. Create a new Flutter app called `frontend` inside the project repository:

```bash
mkdir 3ap-app-in-a-box
cd 3ap-app-in-a-box
git init  
fvm flutter create --platforms=ios,android frontend
```

if this project has been used as template, you don't need to create the project but you have to run this:

```bash
fvm flutter pub get
```

3. Update the package name:

Right now the package name is `ch.aaap.aiab.playground`. You need to update this to your own package name. You can do this by running the following command in the root of the project:

```bash
cd 3ap-app-in-a-box
cd ./frontend
fvm flutter pub run change_app_package_name:main ch.your.package.name
```
This script will update the package name in all the necessary files.

4. Install `firebase` cli

5. Create a new Firebase project with the id `aaap-app-in-a-box` and configure it in the `/backend` directory (choose the project id based on your project):
```bash
cd 3ap-app-in-a-box
mkdir backend
cd ./backend

firebase projects:create -o 57744860469 -n "3ap-app-in-a-box"  aaap-app-in-a-box
firebase use aaap-app-in-a-box

firebase init functions
# add the language typescript

firabase init hosting
# follow the instructions
```

6. Link the project to a billing account and enable certain Apis (through the firebase/gcp console or through gcloud cli):
- firestore and cloud storage (firestore needs to be in production mode)
- artifact registry
- cloud build
- eventarc
- cloud run admin

```bash
firebase init firestore
firebase init storage
```

7. Install `flutterfire` cli

8. Configure your new Flutter app with the Firebase backend 
 (change the bundle name and Firebase project id to the one set in the previous steps):
```bash
flutterfire configure --project=aaap-app-in-a-box -i ch.aaap.aiab.playground -a ch.aaap.aiab.playground
```

9. Update the service account with appropriate roles in GCP:
```bash
API Keys Viewer
Cloud Functions Developer
Cloud Functions Admin
Cloud Run Viewer
Cloud Scheduler Admin
Firebase Authentication Admin
Firebase Develop Admin
Firebase Hosting Admin
Secret Manager Viewer
Service Account User
```
10. Add your app icons and splash screen for iOS.
First create an app icon 1024x1024 png. 
  a. iOS - On your Mac install the `Icon Set Creator`, run it and add the high resolution icon. Drag the created contents to the `frontend/ios/Runner/Assets.xcassets/AppIcon.appiconset`.
     Otherwise, just add a single scale app icon in both Light, Dark and Tinted versions.
  b. Android - Open the `frontend/android` directory in Android Studio and change the Project view to the Android view. Follow the instructions [found here](https://developer.android.com/studio/write/create-app-icons#access).
11. To add the splash screen, please follow the individual platform recommendations.
To have the proper iOS Splash screen is to create 3 assets with different sizes:
    1. 292x639px (LaunchImage.png)
    2. 1125x2436px (LaunchImage@2x.png)
    3. 1242x2688px (LaunchImage@3x.png)

Otherwise, just add a single scale Launch image and use the highest resolution #3. 

12. Follow these steps:
    1. Make sure to remove any constraints on the `LaunchScreen.storyboard > View`. 
    2. Set the `View` attribute _Content Mode_ to _Aspect Fill_.
    3. Select the `LaunchScreen.storyboard > View > Image View`.
    4. Stretch the image over the screen.
    5. Uncheck the _Clips to Bounds_ attribute. 
    6. Recenter the image if necessary.
    7. Set the Content Mode to _Aspect Fill_.

Here is a good video on [how to create an iOS splash screen](https://www.youtube.com/watch?v=NTYcU_pGD_Q).

13. To enable address search using google maps api you need enable the api your firebase project on GCP
Visit `https://console.cloud.google.com/apis/library?project=YOUR-PROJECT-ID`
Search for Places API and enable it. Afterwards you need to create API key and place it in dev.json file env variable `GOOGLE_MAPS_API_KEY`

14. The Firebase Cloud Messaging (FCM) should be enabled by default. To use push notifications with Android, there isn't anything special. However, the Apple Push Notifications
 require a bit more work. There is an extensive guide in Confluence in the Developer Community (DevCo) space.

15. To run the Flutter app use following command `fvm flutter run --dart-define-from-file=config/dev.json`

## Phase 2
Instead of just templating a new repository, App in a box becomes a tool to generate your new mobile app project, supply and configure the backend system.

## Phase 3
...
