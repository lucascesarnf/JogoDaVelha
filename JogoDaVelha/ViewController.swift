//
//  ViewController.swift
//  JogoDaVelha
//
//  Created by Lucas César  Nogueira Fonseca on 03/07/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var textLabel: UILabel!
  @IBOutlet weak var gameView: UIView!
  @IBAction func back(_ sender: Any) {
    performSegue(withIdentifier: "segueMenu", sender: nil)
  }
  //*** Vars for but ***
  var textString = String()
  var extremities = [1,3,7,9]
  var borders = [2,4,6,8]
  //*******************
  var modGame = Int()
  var stateVector = [0,0,0,0,0,0,0,0,0]
  // 1 = x, 2 = o
  var gamer = 2
  let victory = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
  let trevo = [[1,3,0],[1,5,2],[3,7,6],[5,7,8]]
  let defence = [[0,7,6],[2,7,8]]
  var count = 0
  let fuck = ["Humano imprestável","Tende ganhar de mim humano!","Me ganha na próxima!","Eu sou melhor que você, aceite!","Você nunca vai me vencer","Eu sou o rei desse jogo!","Tenta vencer a próxima","Eu mando aqui","Aceita que doi menos","Mais sorte na próxima","Desiste logo humano","Sai desse jogo, isso não é pra você"]
  //***********************
  @IBAction func selectButton(_ sender: Any) {
    var image:UIImage!
    
    if stateVector[(sender as AnyObject).tag - 1] == 0 {
      
      if gamer == 2 {
        
        image = UIImage(named: "o.png")
        (sender as AnyObject).setBackgroundImage(image, for: .normal)
        gamer = 1
        animate_button_cliked(index: (sender as AnyObject).tag)
        stateVector[(sender as AnyObject).tag - 1] = 2
        count += 1
        
      }else{
        
        image = UIImage(named: "x.png")
        (sender as AnyObject).setBackgroundImage(image, for: .normal)
        gamer = 2
        animate_button_cliked(index: (sender as AnyObject).tag)
        stateVector[(sender as AnyObject).tag - 1] = 1
        count += 1
      }
      wineer()
      if modGame == 2{
        if(count != 9){
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
          self.Bot()
          })
        }
      }
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    print("\n\nModGame\(self.modGame)\n\n")
    self.textLabel.text = textString
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func resetGame (){
    self.gameView.isUserInteractionEnabled = false
    self.stateVector = [0,0,0,0,0,0,0,0,0]
    self.gamer = 2
    self.count = 0
    
    self.animation(index: 1)
  }
  
  func Bot(){
    //Primeira rodada e adversário colocou no meio
    if stateVector[4] == 2 && count == 1{
      let roll = arc4random_uniform(3) // 0...3
      let i = Int(roll)
      let image = UIImage(named: "x.png")
      let tmpButton = self.view.viewWithTag(extremities[i]) as? UIButton
      tmpButton?.setBackgroundImage(image, for: .normal)
      gamer = 2
      animate_button_cliked(index: (extremities[i]))
      stateVector[extremities[i] - 1] = 1
      count += 1
    }else{
      //Primeira rodada e adversário jogou na lateral
      if(stateVector[4] != 2 && count == 1){
        let image = UIImage(named: "x.png")
        let tmpButton = self.view.viewWithTag(5) as? UIButton
        tmpButton?.setBackgroundImage(image, for: .normal)
        gamer = 2
        animate_button_cliked(index: 5)
        stateVector[4] = 1
        count += 1
      }else{
        if(stateVector[4] != 2 && count > 1){
          let image = UIImage(named: "x.png")
          let index: Int = self.findPosition2()
          let tmpButton = self.view.viewWithTag(index + 1) as? UIButton
          tmpButton?.setBackgroundImage(image, for: .normal)
          gamer = 2
          animate_button_cliked(index: index + 1)
          stateVector[index] = 1
          count += 1
        }
      }
      if stateVector[4] == 2 && count > 1{
        let image = UIImage(named: "x.png")
        let index: Int = self.findPosition1()
        let tmpButton = self.view.viewWithTag(index + 1) as? UIButton
        tmpButton?.setBackgroundImage(image, for: .normal)
        gamer = 2
        animate_button_cliked(index: index + 1)
        stateVector[index] = 1
        count += 1
      }
    }
    wineer()
  }
  func wineer(){
    var aux = 0
    for index in victory{
      aux += 1
      if stateVector[index[0]] == stateVector[index[1]] && stateVector[index[1]] ==  stateVector[index[2]] && stateVector[index[0]] != 0 {
        
        self.gameView.isUserInteractionEnabled = false
        //AnimateButtons
        
        //##############
          let tmpButton1 = self.view.viewWithTag(index[0] + 1) as? UIButton
          let tmpButton2 = self.view.viewWithTag(index[1] + 1) as? UIButton
          let tmpButton3 = self.view.viewWithTag(index[2] + 1) as? UIButton
        //##############
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [.curveEaseOut, .autoreverse], animations: {
          
            tmpButton1?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            tmpButton2?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            tmpButton3?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
          
            tmpButton1?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            tmpButton2?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            tmpButton3?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
          
            tmpButton1?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            tmpButton2?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            tmpButton3?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
          
        }, completion: nil)
        
        let winner = (stateVector[index[0]] == 1 ? "2" : "1")
        // create the alert
        var title = ""
        if(modGame == 2){
          if(winner == "2"){
            
            let roll = arc4random_uniform(UInt32(fuck.count))
            title = fuck[Int(roll)]
            
          }else{
            
            title = "Você venceu!"
          }
        }else{
          title = "O jogador  " + winner + " Venceu"
        }
        
        let alert = UIAlertController(title: title, message: "Deseja jogar novar novamente? ", preferredStyle: UIAlertControllerStyle.alert)
       
        //alert.view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.2)
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { action in
          self.resetGame()
        }))
        //alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        let subView = alert.view.subviews.first!
        let alertContentView = subView.subviews.first!
        alertContentView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.7)
        alertContentView.layer.cornerRadius = 10
        alertContentView.alpha = 0.9
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
          self.present(alert, animated: true, completion: nil)
        })
        
      }else{
        
        if(count == 9 &&  aux == 7){
          var title = ""
          if(modGame == 2){
            let roll = arc4random_uniform(UInt32(fuck.count))
            title = fuck[Int(roll)]
          }else{
            title = "Empate!"
          }
          
          let alert = UIAlertController(title: title , message: "Deseja jogar novar novamente? ", preferredStyle: UIAlertControllerStyle.alert)
          
          // add the actions (buttons)
          alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { action in
            self.resetGame()
          }))
          //alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil))
          alert.addAction(UIAlertAction(title: "Voltar", style: UIAlertActionStyle.cancel, handler: { action in
            self.performSegue(withIdentifier: "segueMenu", sender: nil)
          }))
          
          // show the alert
          self.present(alert, animated: true, completion: nil)
        }
      }
    }
  }
  
  //Centro:
  func findPosition1() -> Int {
    
    for index in victory{
      if((stateVector[index[0]] == 1)&&(stateVector[index[1]] == 1)||(stateVector[index[0]] == 1)&&(stateVector[index[2]] == 1)||(stateVector[index[1]] == 1)&&(stateVector[index[2]] == 1)){
        for i in 0...2{
          if(stateVector[index[i]] == 0){
            return index[i]
          }
        }
      }
    }
    for index in victory{
      if((stateVector[index[0]] == 2)&&(stateVector[index[1]] == 2)||(stateVector[index[0]] == 2)&&(stateVector[index[2]] == 2)||(stateVector[index[1]] == 2)&&(stateVector[index[2]] == 2)){
        for i in 0...2{
          if(stateVector[index[i]] == 0){
            return index[i]
          }
        }
      }
    }
    
    for i in 0...3{
      if(stateVector[extremities[i] - 1] == 0){
        return extremities[i] - 1
      }
    }
    for i in 0...8{
      if(stateVector[i] == 0){
        return i
      }
    }
    return 0
  }
  
  //Lateral:
  func findPosition2() -> Int {
    
    for index in victory{
      if((stateVector[index[0]] == 1)&&(stateVector[index[1]] == 1)||(stateVector[index[0]] == 1)&&(stateVector[index[2]] == 1)||(stateVector[index[1]] == 1)&&(stateVector[index[2]] == 1)){
        for i in 0...2{
          if(stateVector[index[i]] == 0){
            return index[i]
          }
        }
      }
    }
    for index in victory{
      if((stateVector[index[0]] == 2)&&(stateVector[index[1]] == 2)||(stateVector[index[0]] == 2)&&(stateVector[index[2]] == 2)||(stateVector[index[1]] == 2)&&(stateVector[index[2]] == 2)){
        for i in 0...2{
          if(stateVector[index[i]] == 0){
            return index[i]
          }
        }
      }
    }
    
    for index in defence{
      if(stateVector[index[0]] == 2 && stateVector[index[1]] == 2 && stateVector[index[2]] == 0){
        return index[2]
      }
    }
    
    for index in trevo{
      if(stateVector[index[0]] == 2 && stateVector[index[1]] == 2 && stateVector[index[2]] == 0){
        return index[2]
      }
    }
    for i in 0...3{
      if(stateVector[borders[i] - 1] == 0){
        return borders[i] - 1
      }
    }
    for i in 0...8{
      if(stateVector[i] == 0){
        return i
      }
    }
    return 0
  }
  
  
  
  //ANIMATIN ALL
  func animation(index : Int){
    if(index<10){
      UIView.animate(withDuration: 0.05, delay: 0, options: [.curveEaseOut], animations: {
        
        let tmpButton = self.view.viewWithTag(index) as? UIButton
        tmpButton?.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        tmpButton?.setBackgroundImage(nil, for: UIControlState.normal)
        tmpButton?.backgroundColor = UIColor.white
        tmpButton?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        
      }, completion: { finished in
        self.animation(index: index + 1)
      })
    }else{
      if(index == 10){
        self.gameView.isUserInteractionEnabled = true
      }
    }
  }
  func animate_button_cliked(index: Int){
   
    UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
      
      let tmpButton = self.view.viewWithTag(index) as? UIButton
      tmpButton?.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
      tmpButton?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
      
    }, completion: nil)
  
  }
  
  //
}

