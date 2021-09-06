import Foundation
import Presentation

public final class RequiredFieldValidation: Validation, Equatable {
    private let fieldName: String
    private let fieldLabel: String
    
    public init(fieldName: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
    }
    
    public func validate(data: [String : Any]?) -> String? {
        if (data?[fieldName] as? Int) != nil {
            return nil
        } else if (data?[fieldName] as? Double) != nil {
            return nil
        } else if (data?[fieldName] as? [AnyObject]) != nil {
            return nil
        } else {
            guard let fieldValue = data?[fieldName] as? String, !fieldValue.isEmpty else { return "O campo \(fieldLabel) é obrigatório" }
            return nil
        }
    }
    
    public static func == (lhs: RequiredFieldValidation, rhs: RequiredFieldValidation) -> Bool {
        return lhs.fieldLabel == rhs.fieldLabel && lhs.fieldName == rhs.fieldName
    }
}
