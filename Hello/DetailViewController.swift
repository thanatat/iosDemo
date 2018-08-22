//
//  DetailViewController.swift
//  Hello
//
//  Created by Thanatat Boorapan on 22/8/18.
//  Copyright © 2018 Thanatat Boorapan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var lblMessage: UILabel!
    var message = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblMessage.text = self.message
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
