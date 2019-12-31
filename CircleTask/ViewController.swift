//
//  ViewController.swift
//  CircleTask
//
//  Created by tarek on 12/29/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var printBtn: UIButton!
    @IBOutlet weak var counterClockWiseBtn: UIButton!
    @IBOutlet weak var clockWisebtn: UIButton!
    
    @IBOutlet weak var inputLbl: UILabel!
    @IBOutlet weak var outputLbl: UILabel!
    @IBOutlet weak var circleImage: UIImageView!
    
    @IBOutlet weak var selectedCharacter: UILabel!
    @IBOutlet weak var numberOfMinimumRotationsLbl: UILabel!
    
    @IBOutlet weak var numberOfUserRotationsLbl: UILabel!
    
    
    
    var inputWord = ""
    var userCharacterIndex = 0
    var character : Character = "a"
    var numberOfUserRotation = 0
    var outputWord = ""
    
    var minimumNumberOfRotations = 0
    var globalIndex = 0
    var clockwiseIndex = 0
    var counterClockwiseIndex = 0
   
    
    
    var alphabetArray : [Character] = ["a" , "b" , "c" , "d" , "e" , "f" , "g" , "h" , "i" , "j" , "k" , "l" , "m" , "n" , "o", "p" , "q" , "r" , "s" , "t" , "u" , "v" , "w" , "x" , "y" , "z"]
    
    
//    var tenWordArray = [
//        "razzmatazz" ,
//        "dizzyingly" ,
//        "puzzlingly" ,
//        "squeezebox" ,
//        "unmuzzling"
//    ]
    
    var tenWordArray = [
        "abc" ,
        "abc" ,
        "abc" ,
        "abc" ,
        "abc"
    ]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reset()
    }
    
    func chooseNextChar(isClockWise : Bool)  {
        
        if isClockWise {
            
            if userCharacterIndex == alphabetArray.count - 1 {
               userCharacterIndex = 0
            }else {
               userCharacterIndex += 1
            }
            
        }else {
            if userCharacterIndex == 0 {
               userCharacterIndex = alphabetArray.count - 1
            }else {
               userCharacterIndex -= 1
            }
        }
        
       character = alphabetArray[userCharacterIndex]
       selectedCharacter.text = "selected Charater :\(character)"
       numberOfUserRotation += 1
       numberOfUserRotationsLbl.text = "number of user rotations : \(numberOfUserRotation)"
    }
    
    
     func checkResult() {
        
        if  outputWord.count == inputWord.count   {
            
            printBtn.isEnabled = false
            counterClockWiseBtn.isEnabled = false
            clockWisebtn.isEnabled = false
            
            
            if outputWord == inputWord && numberOfUserRotation == minimumNumberOfRotations  {
                
                showAlert(title: "won", message: "your rotation number is : \(numberOfUserRotation) and recommeded minimum number of rotation is \(minimumNumberOfRotations)")
            }else {
                showAlert(title: "lost", message: "your rotation number is : \(numberOfUserRotation) and recommeded minimum number  of rotation should be \(minimumNumberOfRotations) or unmatched words")
            }
            
            
        }
    }
    
    
     func showAlert(title : String , message : String ) {
        
       let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let resetAction = UIAlertAction(title: "Reset", style: .destructive) { (_) in
            
            DispatchQueue.main.async {
                self.reset()
            }
        }
        
        alert.addAction(resetAction)
        
        self.present(alert,animated : true)
        
    }
    
   
    
    

    
    
    func reset() {
        
        character = "a"
        numberOfUserRotation = 0
        outputWord = ""
        inputWord = tenWordArray.randomElement()!
        minimumNumberOfRotations = calculateMinimumNumberOfRotation(inputWord: inputWord)
        globalIndex = 0
        
        outputLbl.text = "Output : \(outputWord)"
        inputLbl.text = "Input : \(inputWord)"
        
        selectedCharacter.text = "selected Character :\(character)"
        numberOfMinimumRotationsLbl.text = " minimun number of rotations : \(minimumNumberOfRotations)"
        
        numberOfUserRotationsLbl.text = "number of user rotations : \(numberOfUserRotation)"
        
        self.circleImage.image = #imageLiteral(resourceName: "charsWheel")
        circleImage.transform = CGAffineTransform(rotationAngle: 0)
        
        printBtn.isEnabled = true
        counterClockWiseBtn.isEnabled = true
        clockWisebtn.isEnabled = true
        
    }
    
    
    
    func calculateMinimumNumberOfRotation(inputWord : String) -> Int {
        
       
        var totalRotations = 0
        
        for char in inputWord {
            
            var numOfRotationClockwise = 0
            var numOfRotationCounterClockwise = 0
            
            numOfRotationClockwise = calculateNumberOfRotataionsClockWise(char: char)
            numOfRotationCounterClockwise =  calculateNumberOfRotataionsCounterClockWise(char: char)
            
            if numOfRotationClockwise > numOfRotationCounterClockwise {
                totalRotations += numOfRotationCounterClockwise
                globalIndex = counterClockwiseIndex
            }else if numOfRotationClockwise < numOfRotationCounterClockwise {
                 totalRotations += numOfRotationClockwise
                 globalIndex = clockwiseIndex
            }else {
                 totalRotations += numOfRotationClockwise
                 globalIndex = clockwiseIndex
            }
        }
        
        return totalRotations
    
    }
    
    func calculateNumberOfRotataionsClockWise(char : Character ) -> Int {
        
        var rotation = 0
        clockwiseIndex = globalIndex
        
        
        repeat {
        
            if alphabetArray[clockwiseIndex] == char {
                break
            }
            
            if clockwiseIndex == alphabetArray.count - 1 {
                clockwiseIndex = 0
                 rotation += 1
                if alphabetArray[clockwiseIndex] == char {
                    break
                }
            }
            
            
            clockwiseIndex += 1
            rotation += 1
        }while true
        
        
        
        return rotation
    }
    
    func calculateNumberOfRotataionsCounterClockWise(char : Character ) -> Int {
        
        var rotation = 0
        counterClockwiseIndex = globalIndex
        
        repeat {
            
            if alphabetArray[counterClockwiseIndex] == char {
                break
            }
            
            if counterClockwiseIndex == 0 {
                counterClockwiseIndex = alphabetArray.count - 1
                rotation += 1
                if alphabetArray[counterClockwiseIndex] == char {
                    break
                }
            }
            
            counterClockwiseIndex -= 1
            rotation += 1
        }while true
        
        return rotation
    }
    
    
    
    
    
    
    
    
    @IBAction func clockWiseBtnPressed(_ sender: Any) {
        circleImage.transform = circleImage.transform.rotated(by:  -0.265)
        chooseNextChar(isClockWise: true)
    }
    
    
    
    
    
    @IBAction func counterClockWiseBtnPressed(_ sender: Any) {
         circleImage.transform = circleImage.transform.rotated(by:  0.265)
         chooseNextChar(isClockWise: false)
    }
    
    

    
    @IBAction func PrintBtnPressed(_ sender: Any) {
        
        outputWord += "\(character)"
        
        outputLbl.text = "Output : \(outputWord)"
        
        checkResult()
    }
    
    
    
    
    
    
    

}

