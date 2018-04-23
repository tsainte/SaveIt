//
//  StarlingParserTests.swift
//  SaveItTests
//
//  Created by Tiago Bencardino on 18/04/2018.
//  Copyright © 2018 Buildit. All rights reserved.
//

@testable import SaveIt
import XCTest

enum StarlingParserError: Error {
    case parse(String)
}

class StarlingParserTests: XCTestCase {

    var bundle: Bundle!
    var parser = StarlingParser()

    override func setUp() {
        super.setUp()
        bundle = Bundle(for: type(of: self))
    }

    func account() throws -> Account {
        let data = try self.data(for: "StarlingAccount")
        let accounts = try parser.parseAccounts(from: data)

        guard let account = accounts.last else {
            throw MonzoParserError.parse("Can't parse accounts")
        }

        return account
    }

    func data(for resource: String) throws -> Data {
        guard let path = bundle.url(forResource: resource, withExtension: "json") else {
            throw StarlingParserError.parse("Can't find '\(resource) file")
        }
        let data = try Data(contentsOf: path)

        return data
    }

    func testParseAccountsSuccess() {
        do {
            let data = try self.data(for: "StarlingAccount")
            let accounts = try parser.parseAccounts(from: data)

            XCTAssertEqual(accounts.count, 1, "Wrong number of accounts")
            XCTAssertEqual(accounts.last?.accountId, "12344321", "wrong account id")
            XCTAssertEqual(accounts.last?.sortCode, "102030", "wrong sort code")
            XCTAssertEqual(accounts.last?.accountNumber, "42424242", "wrong account number")
        } catch {
            XCTAssertNil(error, "Error while parsing monzo account")
        }
    }

    func testParseBalanceSuccess() {
        do {
            let data = try self.data(for: "StarlingBalance")
            let balance = try parser.parseBalance(from: data, account: account())

            XCTAssertEqual(balance.amount, 105.50, "Wrong balance")
            XCTAssertEqual(balance.currency, "GBP", "Wrong currency")
        } catch {
            XCTAssertNil(error, "Error while parsing monzo balance")
        }
    }

    func testParseTransactionsSuccess() {
        do {
            let data = try self.data(for: "StarlingTransactions")
            let transactions = try parser.parseTransactions(from: data, account: account())

            XCTAssertEqual(transactions.count, 5, "Wrong number of transactions")
            XCTAssertEqual(transactions[1].amount, 6.00, "wrong amount")
            XCTAssertEqual(transactions[1].name, "el chino oo o", "wrong name")
        } catch {
            XCTAssertNil(error, "Error while parsing monzo transaction")
        }
    }
}
