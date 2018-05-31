//
//  AppCommander.swift
//  AppCommander
//
//  Created by Hemang on 27/05/18.
//  Copyright © 2018 Hemang Shah. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseDatabase

public class AppCommander {
    
    //Singleton.
    public static let commander = AppCommander()
    
    //Database Reference
    fileprivate lazy var appCommanderDBReference: DatabaseReference = {
        let ref = Database.database().reference().child("AppCommander")
        return ref
    }()
    
    //Helper to execute a command.
    internal var execution: (AppCommand) -> Void = { arg in }

    //MARK: Init
    private init() {
        //Configuring the Firebase for communications.
        FirebaseApp.configure()
    }
    
    //MARK: Config
    internal func config() {
        //Initializing the databse reference.
        _ = appCommanderDBReference
        
        //Start reading.
        self.read()
    }
    
    //MARK: Command Validation
    fileprivate func validate(_ command: AppCommand) -> Bool {
        //This function will validates a command before execute it.
        
        //`privateKey` is must for any command this will help to uniquely identify individual commands to be execute.
        //If `privateKey` is missing we have to throw an error.
        if let commandPrivateKey = command.privateKey, commandPrivateKey.isEmpty {
            fatalError("`privateKey` key is missing in the command.")
        }
        
        //If a command have a `ignoreMe` set to `true` it will invalidates the particular command and it will not execute.
        //Helpful in cases, while you're making changes to a command in your Firebase Dashboard and don't want AppCommander
        // to keep reading and execute a command. Once a command is ready to execute you can simply remove this key or make it `false`.
        if command.ignoreMe {
            return false
        }
        
        //If a command is executed earlier it should not re-execute. However, we have added a key named `reExecute` if you have
        //set it to `true` it will re-execute a command with the same `privatKey`.
        if AppCommanderStorage.storage.executedBefore(command).executed {
            if command.reExecute {
                return true
            } else {
                return false
            }
        } else {
            //A command is not executed before save it.
            AppCommanderStorage.storage.save(command)
        }
        
        //`forceExecute` will always execute (if `privateKey` is unique) no matter what will be the platform, version and date set.
        //Helpful to overcome any conditions set for a command.
        if !command.forceExecute {
            //Will check if the platform is `ios` or not.
            if let platform = command.platform {
                if platform.lowercased() != "ios" {
                    return false
                }
            }
            
            //Will check for the app version.
            if let version = command.version {
                let appVersion = Bundle.main.releaseVersionNumber ?? ""
                if version != appVersion {
                    return false
                }
            }
            
            //Will check for the date. Will not execute if current date is less then the set date.
            if let toDateInterval = command.toDate {
                let maxDate = Date.init(timeIntervalSince1970: toDateInterval)
                let today = Date()
                if today < maxDate {
                    return false
                }
            }
        }

        return true
    }
    
    //MARK: Read
    fileprivate func read() {
        self.appCommanderDBReference.observe(.value, with: { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                if let appCommand = value[AppCommanderKeys.command.kAppCommand] as? [String : Any] {
                    let command = AppCommand.init(withCommand: appCommand)
                    if self.validate(command) {
                        self.execution(command)
                    }
                }
            }
        }) { (error) in
            print("------------------------AppCommander|Error|Firebase------------------------")
            print(error)
            print("---------------------------------------------------------------------------")
        }
    }
}
