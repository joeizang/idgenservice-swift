import Fluent
import Vapor

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