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
    
    @IBOutlet weak var numberOfRotations: UILabel!
    
    
    
    var minimumNumberOfRotations = 0
    var inputWord = ""
    var index = 0
    var character : Character = "a"
    var rotation = 0
    var outputWord = ""
    var result = ""
    
    
    var biggerIndex = 0
    var clockwiseIndex = 0
    var counterClockwiseIndex = 0
   
    
    
    var alphabetArray : [Character] = ["a" , "b" , "c" , "d" , "e" , "f" , "g" , "h" , "i" , "j" , "k" , "l" , "m" , "n" , "o", "p" , "q" , "r" , "s" , "t" , "u" , "v" , "w" , "x" , "y" , "z"]
    
    
    var tenWordArray = [
        "razzmatazz" ,
        "dizzyingly" ,
        "puzzlingly" ,
        "squeezebox" ,
        "unmuzzling"
    ]
    
    
//    var tenWordArray = [
//        "abc" ,
//        "abc" ,
//        "abc" ,
//        "abc" ,
//        "abc"
//    ]
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reset()
    }
    
    func chooseNextChar(isClockWise : Bool)  {
        
        if isClockWise {
            
            if index == alphabetArray.count - 1 {
               index = 0
            }else {
               index += 1
            }
            
        }else {
            if index == 0 {
               index = alphabetArray.count - 1
            }else {
               index -= 1
            }
        }
        
       character = alphabetArray[index]
       selectedCharacter.text = "selected Charater :\(character)"
       rotation += 1
       numberOfRotations.text = "number of rotations : \(rotation)"
    }
    
    
     func checkResult() {
        
        if  outputWord.count == inputWord.count   {
            
            printBtn.isEnabled = false
            counterClockWiseBtn.isEnabled = false
            clockWisebtn.isEnabled = false
            
            
            if outputWord == inputWord {
                
                showAlert(title: "won", message: "your rotation number is : \(rotation)")
            }else {
                showAlert(title: "lost", message: "your rotation number is : \(rotation)")
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
        rotation = 0
        outputWord = ""
        
        outputLbl.text = "Output : \(outputWord)"
        inputWord = tenWordArray.randomElement()!
        minimumNumberOfRotations = calculateMinimumNumberOfRotation(inputWord: inputWord)
        inputLbl.text = "Input : \(inputWord)"
        selectedCharacter.text = "selected Character :\(character)"
        numberOfRotations.text = " minimun number of rotations : \(minimumNumberOfRotations)"
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
                biggerIndex = counterClockwiseIndex
            }else if numOfRotationClockwise < numOfRotationCounterClockwise {
                 totalRotations += numOfRotationClockwise
                 biggerIndex = clockwiseIndex
            }else {
                 totalRotations += numOfRotationClockwise
                 biggerIndex = clockwiseIndex
            }
        }
        
        return totalRotations
    
    }
    
    func calculateNumberOfRotataionsClockWise(char : Character ) -> Int {
        
        var rotation = 0
        clockwiseIndex = biggerIndex
        
        
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
        counterClockwiseIndex = biggerIndex
        
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

