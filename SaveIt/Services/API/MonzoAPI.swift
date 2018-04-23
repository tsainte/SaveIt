//
//  MonzoAPI.swift
//  SaveIt
//
//  Created by Tiago Bencardino on 06/02/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

import Foundation
import Alamofire

class MonzoAPI: NSObject {

    static let clientId = ConfigurationKeys.shared.monzoClientId
    static let clientSecret = ConfigurationKeys.shared.monzoClientSecret
    static let redirectURI = ConfigurationKeys.shared.monzoRedirectLink

    static let baseURL = "https://api.monzo.com/"

    var token: Token?
    var parser: BankParser
    
    required init(with token: Token?) {
        self.token = token
        self.parser = MonzoParser()
    }
}

// MARK: Authentication and token negociation
/*
 Acquiring an access token is a three-step process:
 
 1. Redirect the user to Monzo to authorise your app
 2. Monzo redirects the user back to your app with an authorization code
 3. Exchange the authorization code for an access token
*/
extension MonzoAPI {

    //1. Redirect user to monzo website
    func requestAuthenticationCode() {
        if let url = URL(string: "https://auth.monzo.com/?client_id=\(MonzoAPI.clientId)&redirect_uri=\(MonzoAPI.redirectURI)&response_type=code&state=") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    //2 and 3. Callback method, from AppDelegate, to exchange the authorization for an access token
    func getAuhenticationToken(from authURL: URL, completeHandler: @escaping (MonzoToken?) -> Void) {
        guard let authUrl = URLComponents(url: authURL, resolvingAgainstBaseURL: true),
            let code = authUrl.queryItems?.first(where: { $0.name == "code" })?.value else {
                return
        }

        let parameters: Parameters = ["grant_type": "authorization_code",
                                      "client_id": MonzoAPI.clientId,
                                      "client_secret": MonzoAPI.clientSecret,
                                      "redirect_uri": MonzoAPI.redirectURI,
                                      "code": code]

        let url = MonzoAPI.baseURL + "oauth2/token"

        Alamofire.request(url, method: .post, parameters: parameters).response { response in
            let decoder = JSONDecoder()
            guard let data = response.data else {
                print("Monzo error: no data")
                return
            }

            do {
                let token = try decoder.decode(MonzoToken.self, from: data)
                print("monzo token: \(token.accessToken)")
                completeHandler(token)
            } catch {
                self.printError(error: error, data: data)
                completeHandler(nil)
            }
        }
    }

    // Refresh token - only for 'confidential' (https://tools.ietf.org/html/rfc6749#section-2.1) users.
    func refreshToken(expiredToken: MonzoToken, completionHandler: @escaping (MonzoToken?) -> Void) {

        let parameters: Parameters = ["grant_type": "refresh_token",
                                      "client_id": MonzoAPI.clientId,
                                      "client_secret": MonzoAPI.clientSecret,
                                      "refresh_token": expiredToken]

        let url = MonzoAPI.baseURL + "oauth2/token"

        Alamofire.request(url, method: .post, parameters: parameters).response { response in
            let decoder = JSONDecoder()
            guard let data = response.data else {
                print("error: no data")
                return
            }

            do {
                let token = try decoder.decode(MonzoToken.self, from: data)
                completionHandler(token)

            } catch {
                self.printError(error: error, data: data)
                completionHandler(nil)
            }
        }
    }

    func printError(error: Error, data: Data) {
        do {
            let parsedError = try parser.parseError(from: data)
            print("Monzo says: \(parsedError.localizedDescription)")
        } catch {
            print("error returned: \(error.localizedDescription)")
        }
    }
}

// MARK: BankAPI protocol implementation

extension MonzoAPI: BankAPI {

    func getAccounts(success: @escaping ([Account]) -> Void,
                     failure: @escaping (BankError) -> Void) {
        guard let token = self.token?.accessToken else { failure(.noToken); return }

        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        let url = MonzoAPI.baseURL + "accounts"

        Alamofire.request(url, headers: headers).response { response in
            guard let data = response.data else { failure(.noData); return }
            do {
                let accounts = try self.parser.parseAccounts(from: data)
                success(accounts)
            } catch {
                self.printError(error: error, data: data)
            }
        }
    }

    func getBalance(account: Account,
                    success: @escaping (Balance) -> Void,
                    failure: @escaping (BankError) -> Void) {
        guard let token = self.token?.accessToken else { failure(.noToken); return }

        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        let parameters: Parameters = ["account_id": account.accountId]
        let url = MonzoAPI.baseURL + "balance"

        Alamofire.request(url, parameters: parameters, headers: headers).response { response in
            guard let data = response.data else { failure(.noData); return }
            do {
                let balance = try self.parser.parseBalance(from: data, account: account)
                success(balance)
            } catch {
                self.printError(error: error, data: data)
            }
        }
    }

    func getTransactions(account: Account,
                         success: @escaping ([Transaction]) -> Void,
                         failure: @escaping (BankError) -> Void) {
        guard let token = self.token?.accessToken else { failure(.noToken); return }

        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        let parameters: Parameters = ["account_id": account.accountId]
        let url = MonzoAPI.baseURL + "transactions"

        Alamofire.request(url,
                          parameters: parameters,
                          headers: headers
        ).response { response in
            guard let data = response.data else { failure(.noData); return }
            do {
                let transactions = try self.parser.parseTransactions(from: data,
                                                                     account: account)
                success(transactions)
            } catch {
                self.printError(error: error, data: data)
            }
        }
    }
}
