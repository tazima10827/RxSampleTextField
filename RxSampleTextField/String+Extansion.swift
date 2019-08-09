import UIKit
import Foundation

extension String {
    // 半角英数字を判定する関数
    func isAlphanumeric() -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[a-zA-Z0-9]+").evaluate(with: self)
    }
    
    //3文字以上れ同じ文字が連続しているかの判定をする関数
    func isCharacterString(text:String) -> Bool {
        if text.count == 0 { return false}
        var sameCharacterCount = 0
        var characterArray:[Character] = []
        for index in text.description {
            characterArray.append(index)
        }
        for i in 1..<text.count {
            if characterArray[i-1] == characterArray[i]{
                sameCharacterCount += 1
            }else{
                sameCharacterCount = 0
            }
        }
        return sameCharacterCount >= 2
    }
}
