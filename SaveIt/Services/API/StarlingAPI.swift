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
    static let baseURL = "https://api.starlingbank.com/api/v1/"

    var token: Token?
    var parser: BankParser

    required init(with token: Token?) {
        self.token = token
        self.parser = StarlingParser()
    }
}

extension StarlingAPI {
    func addDeveloperToken(completeHandling: @escaping (Token) -> Void) {
        let token = Token(starlingToken: StarlingAPI.developerToken)
        completeHandling(token)
    }
}

// MARK: BankAPI protocol implementation

extension StarlingAPI: BankAPI {

    func getAccounts(success: @escaping ([Account]) -> Void,
                     failure: @escaping (BankError) -> Void) {
        guard let token = self.token?.accessToken else { failure(.noToken); return }

        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        let url = StarlingAPI.baseURL + "accounts"

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
        let url = StarlingAPI.baseURL + "accounts/balance"

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
        let url = StarlingAPI.baseURL + "transactions"

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
