//
//  AppCommanderExtensions.swift
//  AppCommander
//
//  Created by Hemang on 28/05/18.
//  Copyright © 2018 Hemang Shah. All rights reserved.
//

import UIKit

public extension Bundle {
    public var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    public var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
