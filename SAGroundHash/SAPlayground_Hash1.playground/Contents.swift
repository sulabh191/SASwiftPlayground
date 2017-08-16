//: Playground - noun: a place where people can play

import UIKit


extension Character {
    //Get Ascii Value of Char
    var asciiValue:UInt32? {
        return String(self).unicodeScalars.filter{$0.isASCII}.first?.value
    }
}

extension String {
    //Char Char from Ascii Value
    init(unicodeScalar: UnicodeScalar) {
        self.init(Character(unicodeScalar))
    }
    
    
    init?(unicodeCodepoint: Int) {
        if let unicodeScalar = UnicodeScalar(unicodeCodepoint) {
            self.init(unicodeScalar: unicodeScalar)
        } else {
            return nil
        }
    }
    
    
    static func +(lhs: String, rhs: Int) -> String {
        return lhs + String(unicodeCodepoint: rhs)!
    }
    
    
    static func +=(lhs: inout String, rhs: Int) {
        lhs = lhs + rhs
    }
}

extension String {
    ///Get Char at Index from String
    var length: Int {
        return self.characters.count
    }
    
    subscript (i: Int) -> String {
        return self[Range(i ..< i + 1)]
    }
    
    func substring(from: Int) -> String {
        return self[Range(min(from, length) ..< length)]
    }
    
    func substring(to: Int) -> String {
        return self[Range(0 ..< max(0, to))]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return self[Range(start ..< end)]
    }
    
}



//----------------------------------------------------------------------------//

let  strk = "aacncjkvkevkklvkdsjkbvjsdbvjkbsdjkvbjdsbvjkbsvbkjwlnkneilhfleknkeiohlgblehgilkbskdbvjdsbvjkdsbvbbvsbdvjlbsdvjbvjkdbvbsjdbjsbvjbdjbjbjkbjkvbjkbdvjbdjkvbjdbvjdbvjbvjdsbjkvbdsjvbkjsbvadvbjkenevknkenvnekvjksbdjvbjkbjbvbkjvbjdsbvjkbdskjvbdsbvjkdsbkvbsdkjbvkjsbvjsbdjkvbdsbvjkbdsvjbdefghhfehfkehkfhkehflwlfhlwhflkhwfklqwgfkwqgfjkqgfjkwqgdjkgwqjkfgjkwgfjkaj"

print(strk)

//Declare array of fixes size 26 (characters) or you can say it as a hash table
var freq = [Int](repeatElement(0, count: 26))

func hashFunc(char : Character) -> UInt32 {
    guard let ascii = char.asciiValue else {
        return 0
    }
    return ascii - 97 //97 used for ascii value of a
}


func countFre(string:String) {
    
    for i in 0 ... string.characters.count-1 {
        let charAtIndex = string[i].characters.first!
        let index = hashFunc(char: charAtIndex)
        let currentVal = freq[Int(index)]
        freq[Int(index)] = currentVal + 1
        //print("CurrentVal of \(charAtIndex) with index \(index) is \(currentVal)")
        
    }
    
    for charIndex in 0 ..< 26 {
        print(String(unicodeCodepoint: charIndex+97)!,freq[charIndex])
    }
}

countFre(string: strk)