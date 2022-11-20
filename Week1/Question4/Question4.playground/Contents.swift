import Foundation

var pyramidFloor = 3

func makePyramid(_ pyramidFloor: Int) -> String {
    var pyramidText: String = ""
    
    for i in stride(from: 1, through: pyramidFloor, by: +1) {
        pyramidText += String(repeating: " ", count: pyramidFloor-i)
        pyramidText += String(repeating: "* ", count: i)
        pyramidText += "\n"
    }
    
    return pyramidText
}

print(makePyramid(pyramidFloor), terminator: "")
