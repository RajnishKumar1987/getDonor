//
//  ArticlesViewMOdel.swift
//  GetDonor
//
//  Created by Rajnish kumar on 03/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import Foundation

class ArticlesViewModel {
    
    let apiLoader: APIRequestLoader<ArticlesApiRequest>!
    var model = ArticlesDataModel()
    var isLoadingNextPageResults: Bool = false
    var isUserRefreshingList: Bool = false
    var isSearching = false

    init(loader: APIRequestLoader<ArticlesApiRequest> = APIRequestLoader(apiRequest: ArticlesApiRequest())) {
        self.apiLoader = loader
    }
    
    func getModelForCell(at indexPath: IndexPath) -> ContentDataModel {
        
        return model.articleList[indexPath.row]
    }
    func canLoadNextPage() -> Bool {
        
        if isLoadingNextPageResults || isUserRefreshingList { return false }
        
        if let currentPage = model.currentPage, let totalPages = model.totalPages, currentPage + 1 > totalPages {
            return false
        }
        
        return true
    }
    
    func loadArticles(with result:@escaping(Result<String>)->Void) {
        
        let page = isUserRefreshingList ? 1 : (model.currentPage ?? 0) + 1

        let requestParam = [
                            "type":"\(ContentType.article.rawValue)",
                            "page": "\(page)"]
        
        apiLoader.loadAPIRequest(forFuncion: .getListing, requestData: requestParam) { [weak self](response, error) in
            
            guard let weakSelf = self else {
                result(.failure(error.debugDescription))
                return
            }
            
            if let response = response {
                
                weakSelf.isUserRefreshingList ? weakSelf.model = response :
                    weakSelf.model.addResults(from: response)
                result(.Success)
                
            }
            else{
                result(.failure(error.debugDescription))
            }
        }
        
    }
    
    func serachArticleFor(keyword: String, with result:@escaping(Result<String>)-> Void) {
        
        let page = isUserRefreshingList ? 1 : (model.currentPage ?? 0) + 1
        
        apiLoader.loadAPIRequest(forFuncion: .searchContent(type: .article, page: "\(page)", searchKeyword: keyword), requestData: nil) { [weak self](response, error) in
            
            guard let weakSelf = self else {
                result(.failure(error.debugDescription))
                return
            }
            
            if let response = response {
                
                weakSelf.isUserRefreshingList ? weakSelf.model = response :
                    weakSelf.model.addResults(from: response)
                result(.Success)
                
            }
            else{
                result(.failure(error.debugDescription))
            }
        }
    }
    
}
