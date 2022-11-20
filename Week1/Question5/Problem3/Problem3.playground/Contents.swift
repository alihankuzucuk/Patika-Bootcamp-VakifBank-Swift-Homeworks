import Foundation

func largestPrimeFactor(lastNumber: Int) -> Int {
    var largestPrimeFactor = 0
    var number = lastNumber
    
    for factor in 2...number {
        while (number % factor == 0){
            largestPrimeFactor = factor
            number /= factor
        }
    }
    
    return largestPrimeFactor
}

print(largestPrimeFactor(lastNumber: 600851475143))
// It may take some time to run for big numbers
