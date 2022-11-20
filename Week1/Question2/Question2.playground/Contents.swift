import Foundation

func countArrayElements<T:Hashable>(array: [T]) -> [T:Int]{
    var elementCounts: [T: Int] = [:]

    for item in array {
        elementCounts[item] = (elementCounts[item] ?? 0) + 1
    }

    return elementCounts
}

print(countArrayElements(array: [true,true,false,false,true]))
print(countArrayElements(array: ["Swift","CSharp","Swift","JavaScript"]))
print(countArrayElements(array: [2,3,0,7,1,9,9,7]))
