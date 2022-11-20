import Foundation

func sumEvenFibonaccies(lastNumber: Int) -> Int {
    var number1 = 1
    var number2 = 2
    var sumEvenNumbers = 0
    
    while number2 < lastNumber {
        if number2 % 2 == 0 {
            sumEvenNumbers += number2
        }
        
        let sumLastTwoNumbers = number1 + number2
        number1 = number2
        number2 = sumLastTwoNumbers
    }
    
    return sumEvenNumbers
}

print(sumEvenFibonaccies(lastNumber: 4000000))
