//
//  VideoDetailsViewController.swift
//  GetDonor
//
//  Created by Rajnish kumar on 05/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import AVFoundation

class VideoDetailsViewController: BaseViewController {

    @IBOutlet weak var activityIndicatorPlayer: UIActivityIndicatorView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var model: ContentDataModel!
    var viewModel = SimilarVideosViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Videos"
        playerView.delegate = self
        showLoader(onViewController: self)
        configureNavigationBarButton(buttonType: .share)
        doInitialConfig()
    }
    
    override func presentActivityViewController() {
        let model = ShareDataModel(title: self.model.title, image: self.model.image, shareURL: self.model.s_url)
        showShareActivity(model: model)
    }

    func doInitialConfig() {
    
        tableview.estimatedRowHeight = 100
        tableview.rowHeight = UITableViewAutomaticDimension
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title2)
        playVideoAndLoadSimilar(with: model)
        
    }
    
    
    func playVideoAndLoadSimilar(with model:ContentDataModel) {
     
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback, with: .duckOthers)
        } catch {
            print("AVAudioSession cannot be set: \(error)")
        }

        self.model = model
        lblTitle.text = model.title ?? ""
        let youtubeId = model.data?.first?.youtubeId?.components(separatedBy: "/").last
        
        if let playBackId = youtubeId {
            playerView.load(withVideoId: playBackId, playerVars: ["playsinline":"1"])
        }
        loadSimilarVideos(with: model.id!)

    }
    
    func loadSimilarVideos(with id: String) {
                
        viewModel.loadSimilarVideos(by: id) { [weak self](result) in
            self?.removeLoader(fromViewController: self!)
            self?.isLoadingNextPageResult(false)
            self?.viewModel.isUserRefreshingList = false
            self?.activityIndicator.stopAnimating()
            switch (result){
            case .Success:
                self?.tableview.reloadData()
                print("success")
            case .failure(let msg):
                print(msg)
            }

        }
    }
    
}

extension VideoDetailsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.vidoeList.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.model.vidoeList.count - 1 {
            if viewModel.canLoadNextPage(){
                isLoadingNextPageResult(true)
                viewModel.isLoadingNextPageResults = true
                loadSimilarVideos(with: model.id!)
                
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SimilarVideosTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
        cell.configCell(with: viewModel.getModelForCell(at: indexPath))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel.isUserRefreshingList = true
        playVideoAndLoadSimilar(with: viewModel.getModelForCell(at: indexPath))
    }
    
}

extension VideoDetailsViewController: YTPlayerViewDelegate{
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .playing:
            activityIndicatorPlayer.stopAnimating()
        case .buffering:
            activityIndicatorPlayer.startAnimating()
        case .unstarted:
            activityIndicatorPlayer.stopAnimating()

        default:
            activityIndicatorPlayer.stopAnimating()
        }
}
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        activityIndicatorPlayer.stopAnimating()
        playerView.playVideo()

    }
}








