//
//  MenuViewController.swift
//  JogoDaVelha
//
//  Created by Lucas César  Nogueira Fonseca on 04/07/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func one_x_one(_ sender: Any) {
    performSegue(withIdentifier: "segueMain", sender: sender)
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "segueMain" {
      if let mainViewController = segue.destination as? ViewController {
        if let senderButton =  sender as? UIButton{
          
          if senderButton.tag == 1{
            mainViewController.modGame = 1
            mainViewController.textString = "Player vs Player"
          }else{
            mainViewController.modGame = 2
             mainViewController.textString = "Tente vencer o Thomas"
          }
          
        }
      }
    }
  }
  
}
