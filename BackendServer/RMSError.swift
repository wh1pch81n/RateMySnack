import Foundation

enum RMSErrorDomain : String {
    case Backend = "RMSBackendErrorDomain"
    static let backend = RMSErrorDomain.Backend.rawValue
}

extension NSError {
    convenience init(domain: RMSErrorDomain, code: Int) {
        self.init(domain: domain.rawValue, code: code, userInfo: nil)
    }
}