//
//  Swapi_CookUnityTests.swift
//  Swapi-CookUnityTests
//
//  Created by Fernando Putallaz on 25/10/2024.
//

import XCTest
@testable import Swapi_CookUnity

final class Swapi_CookUnityTests: XCTestCase {
    func test_getPeople() async throws {
        let sut = makeSUT()
        
        let sampleData = try! JSONEncoder().encode(makePeopleResponse())
        
        let response = HTTPURLResponse(
            url: URL(string: sut.url)!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        URLSessionMock.mockResponse = (sampleData, response, nil)
        
        let people = try await sut.getPeople()
        
        XCTAssertEqual(people.count, 1)
        XCTAssertEqual(people[0].name, "Mock Luke Skywalker")
        XCTAssertEqual(sut.url, "https://swapi.dev/api/people/?page=2")
        XCTAssertTrue(sut.hasMorePages)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> ApiLoader {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLSessionMock.self]
        let mockSession = URLSession(configuration: config)
        
        return ApiLoader(session: mockSession)
    }
    
    private func makePeopleResponse() -> PeopleResponse {
        PeopleResponse(
            count: 10,
            next: "https://swapi.dev/api/people/?page=2",
            previous: nil,
            results: [People(
                name: "Mock Luke Skywalker",
                height: "172",
                mass: "77",
                hairColor: "blond",
                skinColor: "fair",
                eyeColor: "blue",
                birthYear: "19BBY",
                gender: "male",
                homeworld: "https://swapi.dev/api/planets/1/",
                films: ["https://swapi.dev/api/films/1/"],
                species: [],
                vehicles: ["https://swapi.dev/api/vehicles/14/"],
                starships: ["https://swapi.dev/api/starships/12/"],
                created: "2014-12-09T13:50:51.644000Z",
                edited: "2014-12-20T21:17:56.891000Z",
                url: "https://swapi.dev/api/people/1/"
            )]
        )
    }
}

extension Swapi_CookUnityTests {
    private class URLSessionMock: URLProtocol {
        static var mockResponse: (Data?, URLResponse?, Error?)?
        
        override class func canInit(with request: URLRequest) -> Bool {
            true
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            request
        }
        
        override func startLoading() {
            if let (data, response, error) = URLSessionMock.mockResponse {
                if let data = data {
                    client?.urlProtocol(self, didLoad: data)
                }
                if let response = response {
                    client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                }
                if let error = error {
                    client?.urlProtocol(self, didFailWithError: error)
                } else {
                    client?.urlProtocolDidFinishLoading(self)
                }
            }
        }
        
        override func stopLoading() {}
    }
}

