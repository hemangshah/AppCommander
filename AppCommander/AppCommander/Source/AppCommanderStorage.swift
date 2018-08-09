//
//  AppCommanderStorageHelper.swift
//  AppCommander
//
//  Created by Hemang on 27/05/18.
//  Copyright © 2018 Hemang Shah. All rights reserved.
//

import UIKit

public class AppCommanderStorage {
    
    public static let storage = AppCommanderStorage()
    
    fileprivate var storageDefaults = UserDefaults.standard
    fileprivate var storeKey = StroageKeys.kStoreKey
    
    //MARK: Save
    internal func save(_ command: AppCommand) {
        let result = self.executedBefore(command)
        if !result.executed {
            var existingKeys = Array.init(result.storedKeys)
            if let commandPrivateKey = command.privateKey {
                existingKeys.append(commandPrivateKey)
            }
            self.storageDefaults.set(existingKeys, forKey: storeKey)
            self.storageDefaults.synchronize()
        }
    }
    
    //MARK: Validator
    internal func executedBefore(_ command: AppCommand) -> (executed: Bool, storedKeys: [String], privateKey: String) {
        if let storedKeys = self.storageDefaults.object(forKey: storeKey) as? [String] {
            if let privateKey = command.privateKey {
                if storedKeys.contains(privateKey) {
                    return (true, storedKeys, privateKey)
                }
            }
        }
        return (false, [], "")
    }
    
    //MARK: Clean
    internal func clean() {
        if let _ = self.storageDefaults.object(forKey: storeKey) as? [String] {
            self.storageDefaults.removeObject(forKey: storeKey)
        }
    }
}
