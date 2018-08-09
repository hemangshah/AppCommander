//
//  ViewController.swift
//  AppCommander
//
//  Created by Hemang on 27/05/18.
//  Copyright © 2018 Hemang Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Execute the command which we read from the Firebase Database
        AppCommander.commander.execution = { command in
            //Check if we have a command name.
            let commandName = command.name ?? ""
            //If command name isn't empty.
            if !commandName.isEmpty {
                //Compare the command.
                if commandName == "forceExit" {
                    //If afterSeconds available, execute the command after this time.
                    if let commandAfterSeconds = command.afterSeconds {
                        let afterSeconds = Double(commandAfterSeconds)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + afterSeconds, execute: {
                            self.forceExit()
                        })
                    } else {
                        //Else, execute the command now.
                        self.forceExit()
                    }
                }
            }
        }
    }
    
    //MARK: Commands
    fileprivate func forceExit() {
        exit(1)
    }
}
