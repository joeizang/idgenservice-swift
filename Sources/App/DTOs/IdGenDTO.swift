import Fluent
import Vapor
import ULID
struct IdCreatedDto : Content {
    let serverId: String
    let ulidId: String
    let uuidId: String
    let createdAt: Date
}

struct IdCreateDto : Content {
    let serverId: String
    let serverIp: String
}

extension IdCreateDto {

    func mapToIdGenerated(ulid ulidstring: String) -> IdsGenerated {
        let newId = IdsGenerated(genId: nil, serverName: self.serverId, serverIp: self.serverIp, ulidId: ulidstring, requestedId:""
        )
        return newId
    }
}