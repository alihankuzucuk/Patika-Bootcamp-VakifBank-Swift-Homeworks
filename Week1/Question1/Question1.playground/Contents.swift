import Foundation

extension String {
    func trimmingAllSpaces(using characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        return components(separatedBy: characterSet).joined()
    }
}

func palindromeChecker(_ text: String) -> String {
    return text.trimmingAllSpaces().lowercased() == String(text.trimmingAllSpaces().lowercased().reversed()) ? "\"\(text)\" is a palindrome" : "\"\(text)\" is not a palindrome"
}

print(palindromeChecker("taco cat taco cat"))
print(palindromeChecker("Sir I demand I am a maid named Iris"))
print(palindromeChecker("Socorram me subi no onibus em marrocos"))
print(palindromeChecker("palindrome"))
print(palindromeChecker("madam"))
print(palindromeChecker("swift"))
print(palindromeChecker("level"))
