//
//  AppCommanderKeys.swift
//  AppCommander
//
//  Created by Hemang on 28/05/18.
//  Copyright © 2018 Hemang Shah. All rights reserved.
//

import Foundation

public struct AppCommanderKeys {
    
    public struct command {
        public static var kAppCommand = "appCommand"
    }
    
    public struct commandKeys {
        public static var kCommandName = "name"
        public static var kCommandPriority = "priority"
        public static var kCommandPrivateKey = "privateKey"
        public static var kForceExecute = "forceExecute"
        public static var kPlatform = "platform"
        public static var kVersion = "version"
        public static var kToDate = "toDate"
        public static var kIgnoreMe = "ignoreMe"
        public static var kAfterSeconds = "afterSeconds"
        public static var kReExecute = "reExecute"
        
        //Will be added in future releases.
        public static var kAlert = "alert"
        public static var kOnDevices = "onDevices"
        public static var kAppLanguage = "appLanguage"
        public static var kRegion = "region"
        public static var kBatteryLevel = "batteryLevel"
    }
    
    public struct stroageKeys {
        public static var kStoreKey = "AppCommanderStore"
    }
}
