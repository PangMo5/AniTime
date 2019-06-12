//
//  OrganizationViewModel.swift
//  AniTime
//
//  Created by Shirou on 2019/06/10.
//  Copyright © 2019 ShirouCo. All rights reserved.
//

import SwiftUI
import Combine
import SwifterSwift

class ScheduleViewModel: BindableObject {
    let didChange = PassthroughSubject<Void, Never>()
    private var cancellables: [AnyCancellable] = []
    
    let segmentItemTitleList: [String] = ["일", "월", "화", "수", "목", "금", "토", "기타"]
    
    // MARK: Input
    var selection = 0 {
        didSet {
            didChangeCurrentIndex.send(selection)
        }
    }
    
    private let didChangeCurrentIndex = PassthroughSubject<Int, Never>()
    
    private let responseSubject = PassthroughSubject<[Anime], Never>()
    
    // MARK: Output
    private(set) var animeList = [Anime]() {
        didSet { didChange.send(()) }
    }
    
    
    private let apiService: APIServiceType
    init(apiService: APIServiceType = APIService()) {
        self.apiService = apiService
        
        bindData()
        bindViews()
    }
    
    
    private func bindData() {
        
        let responsePublisher = didChangeCurrentIndex
            .print()
            .flatMap { [apiService] index in
                apiService.response(from: AnimeListRequest(), querys: ["w": index.string])
                    .print()
                    .catch { _ in
                        return Publishers.Empty<[Anime], Never>()
                }
        }
        
        let responseStream = responsePublisher
            .subscribe(responseSubject)
        
        cancellables += [responseStream]
    }
    
    private func bindViews() {
        let animeListStream = responseSubject
            .assign(to: \.animeList, on: self)
        
        cancellables += [animeListStream]
    }
}


