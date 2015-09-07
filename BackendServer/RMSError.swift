import Foundation

enum RMSErrorDomain : String {
    case Backend = "RMSBackendErrorDomain"
}

extension NSError {
    convenience init(domain: RMSErrorDomain, code: Int) {
        self.init(domain: domain.rawValue, code: code, userInfo: nil)
    }
}