import FluentMySQL

import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentMySQLProvider())
    
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database

    let mysqlConfig = MySQLDatabaseConfig(
        hostname: "db4free.net",
        port: 3306,
        username: "my_shop",
        password: "xxxx",
        database: "my_shop"
    )
    services.register(mysqlConfig)
    var migrations = MigrationConfig()
    migrations.add(model: Animal.self, database: .mysql)
    services.register(migrations)
    
}
