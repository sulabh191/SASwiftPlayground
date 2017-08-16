//SAPlayground -- https://github.com/sulabh191
//THIS IS BASIC ATM MACHINE program to operate various functions on it
//Classes --
// 1. - ATMMachine , 2. - PinValidator , 3. - UserAccount , 4. -ATMBalance
//Enum for operations - enum operation

import UIKit

//Define ATM Operations in Enum
enum operation : Int {
    
    case withDraw = 1
    case deposit = 2
    case balance = 3
    case exit = 4
}

//Class to Validate User ATM Card Pin
class PinValidator {
    
    var pin:Int
    
    init(pin:Int) {
        self.pin = pin
    }
    
    //Can Add Logic to Validate with Pin storage server
    var isValidPin : Bool {
        return true
    }
}

//Class UserAccount associated with each user , to fetch,reduce , add account balance
// Added Default Balance
class UserAccount {
    
    var balance : Int
    
    init() {
        self.balance = 2000
    }
    
    func reduceBalance(amount:Int, success : (Bool) -> Void) {
        if amount < balance {
            print("User Balance is Valid for this transaction--")
            balance = balance - amount
            print("Remaining User Balance \(balance)")
            success(true)
        } else {
            print("Low balance!!")
            success(false)
        }
    }
    
    func addAmount(amount:Int) {
        
        balance += amount
        print("Added Amount \(amount) to UserAccount")
        
    }
}


//Class ATMBalance associated with ATM Machine , to fetch,reduce , add ATM Machine balance
// Added Default Balance
class ATMBalance {
    
    var balance : Int
    
    init() {
        self.balance = 10000
    }
    
    func reduceBalance(amount:Int) {
        if amount < balance {
            balance = balance - amount
        }
    }
    
    func addAmount(amount:Int) {
        balance += amount
    }
}


//ATM Machine Class -
//Communicate with UserAccount and ATMBalance Class for various operations
class ATMMachine {
    
    private var validator:PinValidator
    var userOperation:operation = .withDraw
    
    var userAccount: UserAccount?
    let atmBalance = ATMBalance()
    
    init(pin:Int) {
        
        self.validator = PinValidator(pin: pin)
        validatePin()
        
    }
    
    private func validatePin() {
        if validator.isValidPin {
            print("PIN VALIDATED")
            userAccount = UserAccount()
        }
    }
    
    func performOperation(opr:operation) {
        
        let atmBalance = ATMBalance()
        
        switch opr {
        case .withDraw:
            //enter Amount
            print("WithDraw Selected")
            let selectedAmount = 450
            if atmBalance.balance > selectedAmount {
                userAccount?.reduceBalance(amount: selectedAmount) { success in
                    if success == true {
                        //disburse amount from ATM machine
                        atmBalance.reduceBalance(amount: selectedAmount)
                        print("Take Cash!!")
                    }
                    
                }
            }
            
            
        case .deposit:
            
            userAccount?.addAmount(amount: 500)
            
        case .balance:
            if let account = userAccount {
                print("Available Balance:\(account.balance)")
            } else {
                print("Operation Not Allowed")
            }
            
        case .exit:
            
            userAccount = nil
            
        }
        
    }
    
    
    
}

//-------------------------------------------------//
//Initialize ATM Machine and perform Operations
let atm  = ATMMachine(pin: 1234)
atm.performOperation(opr: .withDraw)
atm.performOperation(opr: .balance)
atm.performOperation(opr: .deposit)
atm.performOperation(opr: .exit)
atm.performOperation(opr: .balance)
