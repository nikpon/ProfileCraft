import Foundation

class CountryCodeService {
    
    static let shared = CountryCodeService()
    
    private var countryCodes: [[String]]?
    
    private init() {}
    
    // MARK:- Methods
    private func convertCountryCodes(completion: ([[String]]?) -> Void) {
        if let countryCodes = countryCodes {
            completion(countryCodes)
            return
        }
        
        guard let url = Bundle.main.url(forResource: "CountryCodes", withExtension: "plist"), let data = try? Data(contentsOf: url) else { return }
        
        let decoder = PropertyListDecoder()
        if let arrayOfCountryCodes = try? decoder.decode([[String]].self, from: data) {
            countryCodes = arrayOfCountryCodes
        }
        
        completion(countryCodes)
    }
    
    func getCountryCodes(completion: (Result<[[String]], PCError>) -> Void) {
        convertCountryCodes { (countryCodes) in
            if let countryCodes = countryCodes {
                completion(.success(countryCodes))
            } else {
                completion(.failure(.unableToGetCountryCodes))
            }
        }
    }
    
    func getCurrentCountryCode(countryName: String) -> String? {
        convertCountryCodes { (_) in }
        guard let countryCodes = countryCodes else { return nil }
        
        for countryCode in countryCodes {
            if countryCode[0] == countryName {
                return countryCode[1]
            }
        }
        return nil
    }
    
}
