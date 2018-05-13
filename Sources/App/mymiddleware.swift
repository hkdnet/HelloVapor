import Vapor

public final class MyMiddleware: Middleware, ServiceType {
    /// See `ServiceType`.
    public static func makeService(for worker: Container) throws -> MyMiddleware {
        return try .default(environment: worker.environment, log: worker.make())
    }
    
    /// Create a default `MyMiddleware`.
    ///
    /// - parameters:
    ///     - environment: The environment to respect when presenting errors.
    ///     - log: Log destination.
    public static func `default`(environment: Environment, log: Logger) -> MyMiddleware {
        return .init()
    }

    public init() {
    }
    
    /// See `Middleware`.
    public func respond(to req: Request, chainingTo next: Responder) throws -> Future<Response> {
        return try next.respond(to: req).map { res in
            if req.http.headers.contains(name: "X-NYA-N") {
                res.http.headers.add(name: "X-NYA-N", value: "RESPONSE")
            }
            return res
        }
    }
}

