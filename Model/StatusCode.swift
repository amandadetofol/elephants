import Foundation

enum StatusCode: Int {
    
    case success200 = 200
    case partialContent206 = 206
    case invalidRequest = 400
    case unauthorized = 401
    case invalidData = 422
    case internalError = 500
    
    public var returnedSuccess: Bool {
        switch self {
        case .success200, .partialContent206:
            return true
        default:
            return false
        }
    }
    
}
