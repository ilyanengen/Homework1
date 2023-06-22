//
//  ItemListViewModelTests.swift
//  Homework1Tests
//
//  Created by Ilia Biltuev on 22.06.2023.
//

import XCTest
@testable import Homework1

final class ItemListViewModelTests: XCTestCase {
    func testFetchStrings() {
        let mockItemService = MockItemService(fetchStringsUrl: "")
        let sut = ItemListViewModel(itemService: mockItemService)
        let view = MockItemListView()
        view.viewModel = sut
        sut.view = view
        
        sut.fetchStrings()
        
        XCTAssertEqual(["hi", "all"], view.receivedStrings)
    }
    
    func testFetchStringsError() {
        let mockItemService = MockItemService(fetchStringsUrl: "")
        let sut = ItemListViewModel(itemService: mockItemService)
        let view = MockItemListView()
        view.viewModel = sut
        sut.view = view
        
        mockItemService.isNeedReturnError = true
        sut.fetchStrings()
        
        XCTAssertNotNil(view.receivedError)
    }
    
    func testFetchStringsInvalidUrl() {
        let mockNetworkManager = MockNetworkManager()
        let itemListService = ItemService(networkManager: mockNetworkManager, fetchStringsUrl: "12345")
        let sut = ItemListViewModel(itemService: itemListService)
        let view = MockItemListView()
        view.viewModel = sut
        sut.view = view
        
        sut.fetchStrings()
        
        XCTAssertNotNil(view.receivedError)
    }
    
    func testFetchStringsParsingWithValidUrl() {
        let mockNetworkManager = MockNetworkManager()
        let testResponseString = "hi\nall"
        mockNetworkManager.dataToReturn = testResponseString.data(using: .utf8)
        
        let itemListService = ItemService(networkManager: mockNetworkManager, fetchStringsUrl: API.fetchStringsUrl)
        let sut = ItemListViewModel(itemService: itemListService)
        let view = MockItemListView()
        view.viewModel = sut
        sut.view = view
        
        sut.fetchStrings()
        
        XCTAssertEqual(view.receivedStrings, ["hi", "all"])
    }
    
    func testFetchStringsParsingFailed() {
        let mockNetworkManager = MockNetworkManager()
        let invalidData = Data([0x80, 0x81, 0x82])
        mockNetworkManager.dataToReturn = invalidData
        
        let itemListService = ItemService(networkManager: mockNetworkManager, fetchStringsUrl: API.fetchStringsUrl)
        let sut = ItemListViewModel(itemService: itemListService)
        let view = MockItemListView()
        view.viewModel = sut
        sut.view = view
        
        sut.fetchStrings()
        
        XCTAssertEqual(view.receivedError?.localizedDescription, ItemError.parsingFailed.localizedDescription)
        XCTAssertEqual((view.receivedError as? NSError)?.code, (ItemError.parsingFailed as NSError).code)
    }
}

final class MockItemListView: ItemListViewInterface {
    var viewModel: ItemListViewModelInterface?
    
    var receivedStrings: [String] = []
    var receivedError: Error?
    
    func updateList(items: [String]) {
        receivedStrings = items
    }
    
    func showErrorAlert(error: Error) {
        receivedError = error
    }
}

final class MockItemService: ItemServiceInterface {
    var fetchStringsUrl: String
    
    var isNeedReturnError: Bool = false
    
    init(fetchStringsUrl: String) {
        self.fetchStringsUrl = fetchStringsUrl
    }
    
    func fetchStrings(completion: @escaping(Result<[String], Error>) -> Void) {
        if isNeedReturnError {
            completion(.failure(ItemError.unknown))
        } else {
            completion(.success(["hi", "all"]))
        }
    }
}

final class MockNetworkManager: NetworkManagerInterface {
    var isNeedReturnError: Bool = false
    var dataToReturn: Data?
    
    func dataTask(url: URL, completion: @escaping(Result<Data, Error>) -> Void) {
        if isNeedReturnError {
            completion(.failure(ItemError.unknown))
        } else {
            let data = dataToReturn ?? Data()
            completion(.success(data))
        }
    }
}
