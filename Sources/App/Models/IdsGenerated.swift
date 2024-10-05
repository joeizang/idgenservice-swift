import Fluent
import Vapor

final class IdsGenerated: Model {
    static let schema: String = "idsgenerated"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "serverId")
    var serverName: String

    @Field(key: "serverIp")
    var serverIp: String

    @Field(key: "ulidId")
    var ulidId: String

    @Field(key: "requestedId")
    var requestedId: String

    @Timestamp(key: "createdOn", on: .create)
    var createdOn: Date?

    init(){}

    init(
        genId: UUID?,
        serverName: String,
        serverIp: String,
        ulidId: String,
        requestedId: String
    ) {
        self.id = genId ?? UUID()
        self.serverName = serverName
        self.serverIp = serverIp
        self.ulidId = ulidId
        self.requestedId = requestedId
    }
    // use extensions to map to dtos
}

extension IdsGenerated {
    func mapToIdCreatedDto() -> IdCreatedDto {
        return IdCreatedDto(serverId: self.serverName, ulidId: self.ulidId, uuidId: self.requestedId, 
            createdAt: self.createdOn ?? Date())
    }
}