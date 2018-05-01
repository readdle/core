@testable import Async
import XCTest

final class AsyncTests: XCTestCase {
    let worker: Worker = EmbeddedEventLoop()
    func testVariadicMap() throws {
        let futureA = Future.map(on: worker) { "a" }
        let futureB = Future.map(on: worker) { "b" }
        let futureAB = map(to: String.self, futureA, futureB) { a, b in
            return "\(a)\(b)"
        }
        try XCTAssertEqual(futureAB.wait(), "ab")
    }

    func testFlatten() throws {
        let loop = EmbeddedEventLoop()
        let a = loop.newPromise(String.self)
        let b = loop.newPromise(String.self)
        let arr: [Future<String>] = [a.futureResult, b.futureResult]
        let flat = arr.flatten(on: loop)
        a.succeed(result: "a")
        b.succeed(result: "b")
        try XCTAssertEqual(flat.wait(), ["a", "b"])
    }

    func testFlattenStackOVerflow() throws {
        let loop = EmbeddedEventLoop()
        var arr: [Future<Int>] = []
        let count = 1<<12
        for i in 0..<count {
            arr.append(loop.newSucceededFuture(result: i))
        }
        try XCTAssertEqual(arr.flatten(on: loop).wait().count, count)
    }
    
    static let allTests = [
        ("testVariadicMap", testVariadicMap),
        ("testFlatten", testFlatten),
        ("testFlattenStackOVerflow", testFlattenStackOVerflow),
    ]
}
