import FluentMySQL
import Foundation
import Vapor


/// A single entry of a Animal list.
final class Animal: MySQLModel {
    var id: Int?
    var type: String
    var name: String
    var age: Int
    var owner: String?
    
    
    
}

/// Allows `a dynamic migration.
extension Animal: MySQLMigration { }

/// Allows  to be encoded to and decoded from HTTP messages.
extension Animal: Content { }

///// Allows `Animal` to be used as a dynamic parameter in route definitions.
//extension Animal: Parameter { }
