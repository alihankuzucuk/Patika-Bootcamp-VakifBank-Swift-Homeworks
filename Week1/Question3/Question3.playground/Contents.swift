import Foundation

var pyramidFloor = 3

func makePyramid(_ pyramidFloor: Int) -> String {
    var pyramidText: String = ""
    
    for i in 1...pyramidFloor {
        pyramidText += String(repeating: "*", count: i)
        pyramidText += "\n"
    }
    
    return pyramidText
}

print(makePyramid(pyramidFloor), terminator: "")
