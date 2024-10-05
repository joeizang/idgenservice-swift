import Fluent
import Vapor

struct CreateId: AsyncMigration {

    func prepare(on database: any Database) async throws {
        try await database.schema("idsgenerated")
            .id()
            .field("serverId", .string, .required)
            .field("serverIp", .string, .required)
            .field("ulidId", .string, .required)
            .field("requestedId", .string, .required)
            .field("createdOn", .datetime, .required)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("idsgenerated").delete()
    }
}