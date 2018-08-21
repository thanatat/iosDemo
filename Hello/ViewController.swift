//
//  ViewController.swift
//  Hello
//
//  Created by Thanatat Boorapan on 20/8/18.
//  Copyright © 2018 Thanatat Boorapan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var isLightTheme = true
    
    @IBOutlet weak var lblHello: UILabel!
    @IBOutlet weak var txtName: UITextField!
    
    @IBAction func SayHiPressed(_ sender: Any) {
        self.lblHello.text = "Hello \(self.txtName.text!)"
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if isLightTheme == true {
            isLightTheme = false
            for eachView in view.subviews {
                view.backgroundColor = UIColor.black
                if let lable = eachView as? UILabel {
                    lable.textColor = UIColor.white
                }
            }
        } else {
            isLightTheme = true
            for eachView in view.subviews {
                view.backgroundColor = UIColor.white
                if let lable = eachView as? UILabel {
                    lable.textColor = UIColor.black
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblHello.text = "Hi"
        print("Change")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

