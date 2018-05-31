//
//  AppCommand.swift
//  AppCommander
//
//  Created by Hemang on 27/05/18.
//  Copyright © 2018 Hemang Shah. All rights reserved.
//

import Foundation

public class AppCommand {
    
    ///This will represent a command name (an action) which will be performed at the app side. This can be anything as long as it's up to you to set or even modified it later. We'll keep track of each command using its `privateKey` so it doesn't matter which will be the `name`. This is just for (you) the developer for conditions checking and identifications of commands with friendly name. Make sure, you will have the same command name in your firebase and in your app.
    private(set) internal var name: String? = nil
    
    ///Priority can be any value from -1 to 1. The possible values can be -1 (low), 0 (normal), 1 (high). Helpful to decide to execute a command based on the value of `priority`.
    private(set) internal var priority: Int? = nil
    
    ///This will include a unique key to individual commands. This will be used to identify if a particular command has already executed or not. `forceExecute` will  be ignored. To execute a command with the same private key make sure to add `reExecute` and set it to `true`.
    private(set) internal var privateKey: String? = nil
    
    ///This key indicates --- no matter what will be the conditions sets for the command - it will execute. Requires an unique `commandPrivateKey`.
    private(set) internal var forceExecute: Bool = false
    
    ///This key indicates that this command will execute on a particular platform. For example: iOS or Android.
    private(set) internal var platform: String? = nil
    
    ///This key indicates the value of the app version. So if we specified 1.0.0 and the current app version is not matching to it --- the command will not execute. However, if you set, forceExecute = true, version will get ignored.
    private(set) internal var version: String? = nil
    
    ///It will execute a command if it's before the given date/time at the client side. Timestamp should be in milliseconds.
    private(set) internal var toDate: TimeInterval? = nil
    
    ///It will completely ignores any commands with this key.
    private(set) internal var ignoreMe: Bool = false
    
    ///The value will be in seconds. It will indicates that a command will execute after this much of time.
    private(set) internal var afterSeconds: Int? = nil
    
    ///It will reExecute a command with the same private key. `forceExecute` will be ignored if same private key used for multiple commands meaning a command will not execute with the same private key and has not given `reExecute` key.
    private(set) internal var reExecute: Bool = false
    
    //MARK: Init
    public init(withCommand commandResult: [String: Any]) {
        if let commandName = commandResult[AppCommanderKeys.commandKeys.kCommandName] as? String {
            self.name = commandName
        }
        if let commandPriority = commandResult[AppCommanderKeys.commandKeys.kCommandPriority] as? Int {
            self.priority = commandPriority
        }
        if let commandPrivateKey = commandResult[AppCommanderKeys.commandKeys.kCommandPrivateKey] as? String {
            self.privateKey = commandPrivateKey
        }
        if let commandForceExecute = commandResult[AppCommanderKeys.commandKeys.kForceExecute] as? Bool {
            self.forceExecute = commandForceExecute
        }
        if let commandPlatform = commandResult[AppCommanderKeys.commandKeys.kPlatform] as? String {
            self.platform = commandPlatform
        }
        if let commandVersion = commandResult[AppCommanderKeys.commandKeys.kVersion] as? String {
            self.version  = commandVersion
        }
        if let commandToDate = commandResult[AppCommanderKeys.commandKeys.kToDate] as? TimeInterval {
            self.toDate = commandToDate
        }
        if let commandIgnoreMe = commandResult[AppCommanderKeys.commandKeys.kIgnoreMe] as? Bool {
            self.ignoreMe = commandIgnoreMe
        }
        if let commandAfterSeconds = commandResult[AppCommanderKeys.commandKeys.kAfterSeconds] as? Int {
            self.afterSeconds = commandAfterSeconds
        }
        if let commandReExecute = commandResult[AppCommanderKeys.commandKeys.kReExecute] as? Bool {
            self.reExecute = commandReExecute
        }
    }
}
