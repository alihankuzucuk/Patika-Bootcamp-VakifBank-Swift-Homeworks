import Foundation

func sumMultiplesOf3And5(_ lastNumber: Int) -> Int {
    var totalSum: Int = 0
    
    for i in 1...(lastNumber-1){
        if (i % 3 == 0 || i % 5 == 0) {
            totalSum += i
        }
    }
    
    return totalSum
}

print(sumMultiplesOf3And5(1000))
