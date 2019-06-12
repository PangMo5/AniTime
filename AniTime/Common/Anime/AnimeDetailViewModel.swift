//
//  AnimeDetailViewModel.swift
//  AniTime
//
//  Created by Shirou on 2019/06/11.
//  Copyright © 2019 ShirouCo. All rights reserved.
//

import SwiftUI
import Combine
import SwifterSwift

class AnimeDetailViewModel: BindableObject {
    let didChange = PassthroughSubject<Void, Never>()
    private var cancellables: [AnyCancellable] = []
    
    // MARK: Input
    var id = 0 {
        didSet {
            onAppearWithID.send(id)
        }
    }
    
    private let onAppearWithID = PassthroughSubject<Int, Never>()
    
    private let responseSubject = PassthroughSubject<[Subtitle], Never>()
    
    // MARK: Output
    private(set) var subtitleList = [Subtitle]() {
        didSet { didChange.send(()) }
    }
    
    
    private let apiService: APIServiceType
    let anime: Anime
    
    init(anime: Anime, apiService: APIServiceType = APIService()) {
        self.apiService = apiService
        self.anime = anime
        
        
        bindData()
        bindViews()
    }
    
    
    private func bindData() {
        
        let responsePublisher = onAppearWithID
            .print()
            .flatMap { [apiService] id in
                apiService.response(from: SubtitleListRequest(), querys: ["i": id.string])
                    .print()
                    .catch { _ in
                        return Publishers.Empty<[Subtitle], Never>()
                }
        }
        
        let responseStream = responsePublisher
            .subscribe(responseSubject)
        
        cancellables += [responseStream]
    }
    
    private func bindViews() {
        let animeListStream = responseSubject
            .assign(to: \.subtitleList, on: self)
        
        cancellables += [animeListStream]
    }
}


