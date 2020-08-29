import Foundation

class RandomCodeService {
    
    static let shared = RandomCodeService()
    
    private init() {}
    
    func generateRandomPinCode() -> String {
        var str = ""
        for _ in 0..<6 {
            let int = Int.random(in: 0..<9)
            str += String(int)
        }
        return str
    }
    
}
