//
//  MonzoParserTests.swift
//  SaveItTests
//
//  Created by Tiago Bencardino on 18/04/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

@testable import SaveIt
import XCTest

enum MonzoParserError: Error {
    case parse(String)
}

class MonzoParserTests: XCTestCase {

    var bundle: Bundle!
    var parser = MonzoParser()

    override func setUp() {
        super.setUp()
        bundle = Bundle(for: type(of: self))
    }

    func account() throws -> Account {
        let data = try self.data(for: "MonzoAccount")
        let accounts = try parser.parseAccounts(from: data)

        guard let account = accounts.last else {
            throw MonzoParserError.parse("Can't parse accounts")
        }

        return account
    }

    func data(for resource: String) throws -> Data {
        guard let path = bundle.url(forResource: resource, withExtension: "json") else {
            throw MonzoParserError.parse("Can't find '\(resource) file")
        }
        let data = try Data(contentsOf: path)

        return data
    }

    func testParseAccountsSuccess() {
        do {
            let data = try self.data(for: "MonzoAccount")
            let accounts = try parser.parseAccounts(from: data)

            XCTAssertEqual(accounts.count, 2, "Wrong number of accounts")
            XCTAssertEqual(accounts.last?.accountId, "acc_4321", "wrong account id")
            XCTAssertEqual(accounts.last?.sortCode, "102030", "wrong sort code")
            XCTAssertEqual(accounts.last?.accountNumber, "12344321", "wrong account number")
        } catch {
            XCTAssertNil(error, "Error while parsing monzo account")
        }
    }

    func testParseBalanceSuccess() {
        do {
            let data = try self.data(for: "MonzoBalance")
            let balance = try parser.parseBalance(from: data, account: account())

            XCTAssertEqual(balance.amount, 16.82, "Wrong balance")
            XCTAssertEqual(balance.currency, "GBP", "Wrong currency")
        } catch {
            XCTAssertNil(error, "Error while parsing monzo balance")
        }
    }

    func testParseTransactionsSuccess() {
        do {
            let data = try self.data(for: "MonzoTransactions")
            let transactions = try parser.parseTransactions(from: data, account: account())

            XCTAssertEqual(transactions.count, 5, "Wrong number of transactions")
            XCTAssertEqual(transactions.last?.amount, 100.00, "wrong amount")
            XCTAssertEqual(transactions.last?.name, "HSBC 2 Monzo", "wrong name")
        } catch {
            XCTAssertNil(error, "Error while parsing monzo transaction")
        }
    }
}
