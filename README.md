# AppCommander
👮A commander for your iOS apps – Control your apps even after it gets released.

![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)
![Platform](https://img.shields.io/badge/Platforms-iOS-red.svg)
![Swift 4.x](https://img.shields.io/badge/Swift-4.x-blue.svg)

1. [Overview](#overview)
2. [Features](#features)
3. [Installation](#installation)
4. [Usage](#usage)
5. [ToDos](#todos)
6. [Credits](#credits)
7. [Thanks](#thank-you)
8. [License](#license)
9. [Notice](#notice)

## Overview

There are times when it will be require for you to let *all of your logged-in users will get logged out*, or maybe *presented with some view controller displaying new terms and conditions to use your app*, or maybe, you *want to show a message to your users (not via push notifications)*, or you simply *want to lock your app for a particular time*?

There can be just too many cases which will be require you to do but the main question is how it's possible to an already released app? Yes, you can create your own APIs which will do such things for you. But what if you don't want to use your own APIs to take care about it, or you want those actions to get performed so quick that you can't depend on your own APIs.

This is why I have written **AppCommander**. It will comminicate to your Firebase RealTime Database and will help you to perform an action as quickly as possible.

**AppCommander** will only follow your instructions which you will give through various commands available and will only call the actions which you have written in advance before it will get released on the AppStore. Isn't it cool?

What AppCommander needs you to do? 

- Think about the possible actions you want to do.
- Setup Firebase RealTime Database.
- Setup your app so it can communicate with the Firebase. Read the installations. Points: 1...4
- Setup AppCommander. Point: 5
- Read the Usage to see the usage of the AppCommander. Points: 1...4
- Write the actions which you want to perform by the AppCommander.

## Features

1. Easy setup and configurations.
2. Handling the apps from your Firebase account. Even free account works well.
3. Multiple filter options.

## Installation

**[1]** Goto https://console.firebase.google.com/<br>
- Choose Add Project<br>
- Add Your Project Details and Click on the "Create Project" button.<br>
- You should see the "Your project is ready". Click on the "Contiue" button.<br>

**[2]** Welcome to Firebase. Get started here.<br>
- Choose Add Firebase to iOS app. Click on the "iOS" button.<br>
- Add the same BundleId as in your Project. Provide other details and click on the "REGISTER APP" button.<br>
- Download `GoogleService-Info.plist` file and add it to your project. This is very important for the Firebase integration.

**[3]** You are now in "Overview" screen in your Firebase Dashboard.<br>
- In left panel, click on "Database" option.<br>
- Choose "Realtime Database" and click on the "GET STARTED" button.<br>
- Start in locked mode. This is important, you should know how to manage the authenticaltion with Firebase.<br>
- In Database, "Data" should be selected. <br>
- Click on "add child" [+] button.<br>
- In name, make sure you give "AppCommander" and the value should be a JSON. Sample is added [here](https://github.com/hemangshah/AppCommander/blob/master/AppCommander/AppCommander/Source/AppCommanderSampleJSON.txt). Add the keys as per the requirements.<br>
- Hit enter to add it into the Database.<br>
- Goto "RULES" tab next to the "DATA" tab.<br>
- For testing, set `.read` to `true`.

**[4]** Install Firebase Database to your project using CocoaPods. This is the command: `pod Firebase/Database`. **Note**: You can also install it manually. Or with the sample project you only need to do `pod install` since it has already included a podfile.

**[5]** Add all the files from `AppCommander/Source` folder to your Project.

> You can read the [CHANGELOG](https://github.com/hemangshah/AppCommander/blob/master/CHANGELOG.md) file for a particular release.

## Usage

1.  **Config** `AppCommander` in `AppDelegate.swift`.
````swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.        
        AppCommander.commander.config()        
        return true
}
````
    
2. Listen to commands from the `AppCommander` anywhere in your project. The suitabel place is in `AppDelegate` only after configuring the `AppCommander`.
````swift
AppCommander.commander.execution = { command in
   let commandName = command.name ?? ""
   if !commandName.isEmpty {
      if commandName == "forceExit" {
         self.forceExit()
      }
   }
}
````

3. Write an action to handle the received command.
````swift
fileprivate func forceExit() {
    exit(1)
}
````

4. Done! ✅

<hr>

## ToDo[s]

- [ ] Add more filter options.
- [ ] CocoaPods support.
- [ ] Create a video to represent Firebase configuration.
- [ ] Create a video to represent AppCommander usage.

You can [watch](https://github.com/hemangshah/AppCommander/subscription) to <b>AppCommander</b> to see continuous updates. Stay tuned.

<b>Have an idea for improvements of this class?
Please open an [issue](https://github.com/hemangshah/AppCommander/issues/new).</b>

## Credits

<b>[Hemang Shah](https://about.me/hemang.shah)</b>

**You can shoot me an [email](http://www.google.com/recaptcha/mailhide/d?k=01IzGihUsyfigse2G9z80rBw==&c=vU7vyAaau8BctOAIJFwHVbKfgtIqQ4QLJaL73yhnB3k=) to contact.**
   
## Thank You!!

See the [contributions](https://github.com/hemangshah/AppCommander/blob/master/CONTRIBUTIONS.md) for details.

## License

The MIT License (MIT)

> Read the [LICENSE](https://github.com/hemangshah/AppCommander/blob/master/LICENSE) file for details.

## Notice

- `AppCommander` and their developer(s) and contributors will not take any liability and responsibility for any of the development you do, actions or code or logic you write, results or issues or erros you may face, lost of data you may make by using `AppCommander` in any of your work which is for your personal or employers or clients. Meaning, if you use `AppCommander` classes(files), you're (and your team members are) fully responsible.
