//
//  ViewController.swift
//  AppCommander
//
//  Created by Hemang on 27/05/18.
//  Copyright © 2018 Hemang Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate func doActionsWithCommand(_ command: AppCommand) {
        //Check if we have a command name. And command name isn't empty.
        if let commandName = command.name, !commandName.isEmpty {
            //Compare the commands.
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
                
            } else if commandName == "showAlert" {
                if let alert = command.alert {
                    self.showAlertWithMessage(alert: alert)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Execute the command which we read from the Firebase Database
        AppCommander.commander.execution = { command in
            self.doActionsWithCommand(command)
        }
    }
    
    //MARK: Command Actions
    fileprivate func forceExit() {
        exit(1)
    }
    
    fileprivate func showAlertWithMessage(alert: String) {
        let alertcontroller = UIAlertController.init(title: alert, message: nil, preferredStyle: .alert)
        let actionCancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        alertcontroller.addAction(actionCancel)
        self.present(alertcontroller, animated: true, completion: nil)
    }
}
