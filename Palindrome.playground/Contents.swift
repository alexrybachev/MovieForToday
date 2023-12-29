import Foundation

extension String {
    var isPalindrome: Bool {
        let arr = Array(self)
        let offset = arr.count % 2 == .zero
        ? arr.count / 2
        : (arr.count - 1) / 2
        return arr.suffix(offset).reversed().elementsEqual(arr.prefix(offset))
    }
}

var example = "tenet"

assert(example.isPalindrome == true)

example = "meow"

assert(example.isPalindrome == false)

example = "bazzab"

assert(example.isPalindrome == true)
