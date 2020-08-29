import PhoneNumberKit

class PhoneNumberService {
    
    static let shared = PhoneNumberService()
    
    let phoneNumberKit = PhoneNumberKit()
    let formatter = PartialFormatter()
    
    private init() {}
    
    // MARK:- Methods
    func check(phoneNumber: String) -> Bool {
        if let _ = try? phoneNumberKit.parse(phoneNumber) {
            return true
        } else {
            return false
        }
    }
    
    func formatPartial(_ number: String) -> String {
        formatter.formatPartial(number)
    }
    
}
