//
//  Router.swift
//  zenigame
//
//  Created by Kaoru Tsutsumishita on 2017/06/13.
//  Copyright © 2017年 Anime Consortium Japan. All rights reserved.
//

import Alamofire
import OHHTTPStubs
import Foundation

enum Router: URLRequestConvertible {
    static let domain = "876tvlivepfapi-dev.channel.or.jp"
    static let dir = "/app/api1"
    static let baseURLString = "https://\(Router.domain)\(Router.dir)"

    case getToken(String)
    case getUserInfo(String)
    case getProgram(String)
    case setProgram(String, String, String, Int, String?, Int?, Int?, Int?)
    case updateProgram(String, String, String?, String, Int, Int?, Int?, Int?)
    case deleteProgram(String, String)
    case getProgramCast(String)
    case getProgramInfo(String)
    case setProgramInfo(String, String, String?, Int, Int?, String?, Int?, Int?, Int?, Int)
    case setProgramSoon(String, String)
    case setChannel(String, String, String?, String?, String?)

    var method: HTTPMethod {
        switch self {
        case .getToken,
             .getUserInfo,
             .getProgram,
             .setProgram,
             .updateProgram,
             .deleteProgram,
             .getProgramCast,
             .getProgramInfo,
             .setProgramInfo,
             .setProgramSoon,
             .setChannel:
            return .post
        }
    }

    var path: String {
        switch self {
        case .getToken(_):
            return "/getToken"
        case .getUserInfo(_):
            return "/getUserInfo"
        case .getProgram(_):
            return "/getProgram"
        case .setProgram(_, _, _, _, _, _, _, _):
            return "/setProgram"
        case .updateProgram(_, _, _, _, _, _, _, _):
            return "/updateProgram"
        case .deleteProgram(_, _):
            return "/deleteProgram"
        case .getProgramCast(_):
            return "/getProgramCast"
        case .getProgramInfo(_):
            return "/getProgramInfo"
        case .setProgramInfo(_, _, _, _, _, _, _, _, _, _):
            return "/setProgramInfo"
        case .setProgramSoon(_, _):
            return "/setProgramSoon"
        case .setChannel(_, _, _, _, _):
            return "/setChannel"
        }
    }

    var mockPath: String {
        return "\(Router.dir)\(path)"
    }

    func mock() -> Router {
        stub(condition: isHost(Router.domain) && isPath(self.mockPath)) { _ in
            return OHHTTPStubsResponse(
                // swiftlint:disable:next force_unwrapping
                fileAtPath: OHPathForFileInBundle("\(self.path.substring(from: self.path.index(after: self.path.startIndex))).json", Bundle.main)!,
                statusCode: 200,
                headers: ["Content-Type": "application/json"]
            )
        }

        return self
    }

    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        var payload: [String: Any] = [:]

        switch self {
        case .getToken(let code):
            payload["code"] = code
        case .getUserInfo(let accessToken):
            payload["acces_token"] = accessToken
        case .getProgram(let accessToken):
            payload["acces_token"] = accessToken
        case .setProgram(let accessToken, let channelID, let startDate, let duration, let title, let openRange, let type, let notice):
            payload["acces_token"] = accessToken
            payload["channelid"] = channelID
            payload["startdate"] = startDate
            payload["duration"] = duration

            if let v = title {
                payload["title"] = v
            }
            if let v = openRange {
                payload["openrange"] = v
            }
            if let v = type {
                payload["type"] = v
            }
            if let v = notice {
                payload["notice"] = v
            }
        case .updateProgram(let accessToken, let programID, let title, let startDate, let duration, let openRange, let type, let notice):
            payload["acces_token"] = accessToken
            payload["programid"] = programID
            payload["startdate"] = startDate
            payload["duration"] = duration

            if let v = title {
                payload["title"] = v
            }
            if let v = openRange {
                payload["openrange"] = v
            }
            if let v = type {
                payload["type"] = v
            }
            if let v = notice {
                payload["notice"] = v
            }
        case .deleteProgram(let accessToken, let programID):
            payload["acces_token"] = accessToken
            payload["programid"] = programID
        case .getProgramCast(let accessToken):
            payload["acces_token"] = accessToken
        case .getProgramInfo(let accessToken):
            payload["acces_token"] = accessToken
        case .setProgramInfo(let accessToken, let channelID, let title, let timing, let openRange, let text, let type, let newList, let notice, let duration):
            payload["acces_token"] = accessToken
            payload["channelid"] = channelID
            payload["timing"] = timing
            payload["duration"] = duration

            if let v = title {
                payload["title"] = v
            }
            if let v = openRange {
                payload["openrange"] = v
            }
            if let v = text {
                payload["text"] = v
            }
            if let v = type {
                payload["type"] = v
            }
            if let v = newList {
                payload["newlist"] = v
            }
            if let v = notice {
                payload["notice"] = v
            }
        case .setProgramSoon(let accessToken, let channelID):
            payload["acces_token"] = accessToken
            payload["channelid"] = channelID
        case .setChannel(let accessToken, let channelID, let title, let doc, let image):
            payload["acces_token"] = accessToken
            payload["channelid"] = channelID

            if let v = title {
                payload["title"] = v
            }
            if let v = doc {
                payload["doc"] = v
            }
            if let v = image {
                payload["image"] = v
            }
        }

        return try URLEncoding.default.encode(urlRequest, with: payload)
    }

}
