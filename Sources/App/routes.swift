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
    
    router.get("animal"){ req -> Future<Animal> in
        let id = try req.query.get(Int.self, at: "id")
        return Animal.find(id, on: req).unwrap(or: Abort.init(.notFound))
    }
    
    router.delete("animal", Int.parameter) { req -> Future<String> in
        
        let id = try req.parameters.next(Int.self)
        return Animal.find(id, on: req).flatMap { maybeAnimal in
            
            guard let animal = maybeAnimal else {
                throw Abort(.notFound)
            }
            
            return animal.delete(on: req).map {
                return "Deleted animal: \(animal.name)"
            }
        }
    }
    
    
//    // Example of configuring a controller
//    let todoController = TodoController()
//    router.get("todos", use: todoController.index)
//    router.post("todos", use: todoController.create)
//    router.delete("todos", Animal.parameter, use: todoController.delete)
}
