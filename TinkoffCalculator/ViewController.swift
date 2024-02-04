//
//  ViewController.swift
//  TinkoffCalculator
//
//  Created by Yato on 02.02.2024.
//  Copyright © 2024 Kirill Prilepskij. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let buttonText = sender.currentTitle else {return }
        print (buttonText)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("KKKKKKK")
        
    }


}

