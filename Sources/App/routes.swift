import Vapor
import Fluent
import FluentMySQL
/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get { req in
        return "homesite here ;)"
    }
    
    router.get("animals") { req  in
        return Animal.query(on: req).all()}
    
    router.post(Animal.self, at: "animal"){(req,animal) in
      return animal.save(on: req)
    }
//    // Example of configuring a controller
//    let todoController = TodoController()
//    router.get("todos", use: todoController.index)
//    router.post("todos", use: todoController.create)
//    router.delete("todos", Animal.parameter, use: todoController.delete)
}
