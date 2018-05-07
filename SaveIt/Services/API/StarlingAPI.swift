//
//  StarlingAPI.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 06/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Alamofire

class StarlingAPI: NSObject {

    static let developerToken = ConfigurationKeys.shared.starlingToken

    static let productionBaseURL = "https://api.starlingbank.com"
    static let productionAuthBaseURL = "https://oauth.starlingbank.com"

    static let sandboxBaseURL = "https://api-sandbox.starlingbank.com"
    static let sandboxAuthBaseURL = "https://oauth-sandbox.starlingbank.com"

    static let clientId = ConfigurationKeys.shared.starlingClientId
    static let clientSecret = ConfigurationKeys.shared.starlingClientSecret
    static let redirectURI = ConfigurationKeys.shared.starlingRedirectURI

    var token: Token?
    var parser: BankParser

    var baseURL: String
    var authBaseURL: String

    required init(at environment: BankEnvironment, token: Token?) {
        self.token = token
        self.parser = StarlingParser()

        self.baseURL = environment == .sandbox ? StarlingAPI.sandboxBaseURL : StarlingAPI.productionBaseURL
        self.authBaseURL = environment == .sandbox  ? StarlingAPI.sandboxAuthBaseURL : StarlingAPI.productionAuthBaseURL
    }
}

// MARK: - OAuth2 protocol implementation
extension StarlingAPI: OAuth2 {

    func requestAuthenticationCode() {
        if let url = URL(string: "\(authBaseURL)/?" +
            "client_id=\(StarlingAPI.clientId)&" +
            "redirect_uri=\(StarlingAPI.redirectURI)&" +
            "response_type=code&" +
            "state=") {
            UIApplication.shared.openEmbed(url: url)
        }
    }

    func extractAuthenticationToken(from authURL: URL, completeHandler: @escaping (Token?) -> Void) {
        guard let authUrl = URLComponents(url: authURL, resolvingAgainstBaseURL: true),
            let code = authUrl.queryItems?.first(where: { $0.name == "code" })?.value else {
                return
        }
        requestAccessToken(for: code, completeHandler: completeHandler)
    }

    func requestAccessToken(for authenticationToken: String, completeHandler: @escaping (Token?) -> Void) {
        let parameters: Parameters = ["grant_type": "authorization_code",
                                      "client_id": StarlingAPI.clientId,
                                      "client_secret": StarlingAPI.clientSecret,
                                      "redirect_uri": StarlingAPI.redirectURI,
                                      "code": authenticationToken]

        let url = "\(baseURL)/oauth/access-token"

        Alamofire.request(url, method: .post, parameters: parameters).response { response in
            let decoder = JSONDecoder()
            guard let data = response.data else { return }

            do {
                let starlingToken = try decoder.decode(StarlingToken.self, from: data)
                print("starling token: \(starlingToken.accessToken)")
                let token = Token(starlingToken: starlingToken)
                completeHandler(token)
            } catch {
                completeHandler(nil)
            }
        }
    }
}

// MARK: - Override login by using developer token
extension StarlingAPI {
    func addDeveloperToken(completeHandling: @escaping (Token) -> Void) {
        let token = Token(starlingDeveloperToken: StarlingAPI.developerToken)
        completeHandling(token)
    }
}

// MARK: - BankAPI protocol implementation

extension StarlingAPI: BankAPI {

    func getAccounts(success: @escaping ([Account]) -> Void,
                     failure: @escaping (BankError) -> Void) {
        guard let token = self.token?.accessToken else { failure(.noToken); return }

        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        let url = "\(baseURL)/api/v1/accounts"

        Alamofire.request(url, headers: headers).response { response in
            guard let data = response.data else { failure(.noData); return }
            do {
                let account = try self.parser.parseAccounts(from: data)
                success(account)
            } catch {
                failure(.error(localizedDescription: error.localizedDescription))
            }
        }
    }

    func getBalance(account: Account,
                    success: @escaping (Balance) -> Void,
                    failure: @escaping (BankError) -> Void) {
        guard let token = self.token?.accessToken else { failure(.noToken); return }

        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        let url = "\(baseURL)/api/v1/accounts/balance"

        Alamofire.request(url, headers: headers).response { response in
            guard let data = response.data else { failure(.noData); return }
            do {
                let balance = try self.parser.parseBalance(from: data, account: account)
                success(balance)
            } catch {
                failure(.error(localizedDescription: error.localizedDescription))
            }
        }
    }

    func getTransactions(account: Account,
                         success: @escaping ([Transaction]) -> Void,
                         failure: @escaping (BankError) -> Void) {
        guard let token = self.token?.accessToken else { failure(.noToken); return }

        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        let url = "\(baseURL)/api/v1/transactions"

        Alamofire.request(url, headers: headers).response { response in
            guard let data = response.data else { failure(.noData); return }
            do {
                let transactions = try self.parser.parseTransactions(from: data, account: account)
                success(transactions)
            } catch {
                failure(.error(localizedDescription: error.localizedDescription))
            }
        }
    }
}
