//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Ernesto Gonzalez on 2/27/17.
//  Copyright © 2017 Ernesto Gonzalez. All rights reserved.
//

import UIKit
import AVFoundation

class CalcVC: UIViewController {

    enum Operation: String {
        case Divide
        case Multiply
        case Subtract
        case Add
        case Empty
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err)
        }
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }

    @IBAction func onClearPressed(_ sender: Any) {
        playSound()
        leftValStr = ""
        rightValStr = ""
        runningNumber = ""
        result = "\(0)"
        currentOperation = .Empty
        outputLbl.text = result
    }
   
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if !runningNumber.isEmpty {
                rightValStr = runningNumber
                runningNumber = ""
                switch currentOperation {
                case .Add:
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                case .Subtract:
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                case .Multiply:
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                case .Divide:
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                default:
                    result = "0"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
        } else {
            leftValStr = runningNumber
            runningNumber = ""
        }
        currentOperation = operation
    }
}

