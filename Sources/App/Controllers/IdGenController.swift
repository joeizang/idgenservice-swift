import Foundation
import Vapor
import ULID

struct IdGenController : RouteCollection {

    func boot(routes: any RoutesBuilder) throws {
        let idGroup = routes.grouped("idgen")

        idGroup.post(use: self.generateId)
    }

    @Sendable 
    func generateId(req: Request) async throws -> HTTPStatus {
        var payload = try req.content.decode(IdCreateDto.self)
        dump(payload)
        return .ok
    }
}