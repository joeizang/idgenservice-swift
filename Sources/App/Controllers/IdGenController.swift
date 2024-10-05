import Foundation
import Vapor
import ULID

struct IdGenController : RouteCollection {

    func boot(routes: any RoutesBuilder) throws {
        let idGroup = routes.grouped("idgen")

        idGroup.post(use: self.generateId)
        idGroup.get(use: self.getAllIds)
    }

    @Sendable 
    func generateId(req: Request) async throws -> HTTPStatus {
        let payload = try req.content.decode(IdCreateDto.self)
        guard !payload.serverId.isEmpty && !payload.serverIp.isEmpty else {
            return .badRequest
        }
        let ulid = ULID(timestamp: Date()).ulidString
        let newEntity = payload.mapToIdGenerated(ulid: ulid)
        let t = ULID(ulidString: ulid)!.ulid
        let uuid = UUID(uuid: t)
        newEntity.requestedId = uuid.uuidString
        try await newEntity.save(on: req.db)
        let saved = try await IdsGenerated.query(on: req.db).all()
        dump(saved)
        return .ok
    }

    @Sendable
    func getAllIds(req: Request) async throws -> [IdCreatedDto] {
        let result = try await IdsGenerated.query(on: req.db).all()
            .map { $0.mapToIdCreatedDto() }
        return result
    }
}