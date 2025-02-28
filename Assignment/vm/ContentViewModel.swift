//
//  ContentViewModel.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation


class ContentViewModel : ObservableObject {
    
    private let apiService = ApiService()
    @Published var navigateDetail: DeviceData? = nil
    @Published var data: [DeviceData]? = []
    private let userDefaults: UserDefaults = UserDefaults.standard
    
}

// MARK: - Data
extension ContentViewModel {
    
    func fetchAPI() {
        apiService.fetchDeviceDetails(completion: { item in
            DispatchQueue.main.async { [weak self] in
                self?.data = item
                self?.setDataIntoUserDefaults(using: item)
            }
        })
    }

    
    func getCachedData() {
        if let deviceData = getDataFromUserDefaults() {
            data = deviceData
            return
        }
    }
}

// MARK: - Navigations
extension ContentViewModel {
    
    func navigateToDetail(navigateDetail: DeviceData) {
        self.navigateDetail = navigateDetail
    }
}


// MARK: - LocalCache
extension ContentViewModel {
    
    private func setDataIntoUserDefaults(using data: [DeviceData]) {
        let jsonEncoder = JSONEncoder()
        let encodedData = try? jsonEncoder.encode(data)
        userDefaults.set(encodedData, forKey: "DevicesList")
    }
    
    
    private func getDataFromUserDefaults() -> [DeviceData]? {
        guard let encodedData = userDefaults.data(forKey: "DevicesList") else { return nil }
        let jsonDecoder = JSONDecoder()
        return try? jsonDecoder.decode([DeviceData].self, from: encodedData)
    }
}
