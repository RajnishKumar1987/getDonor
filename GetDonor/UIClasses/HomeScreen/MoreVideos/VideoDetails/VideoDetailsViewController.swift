//
//  VideoDetailsViewController.swift
//  GetDonor
//
//  Created by admin on 05/09/18.
//  Copyright © 2018 GetDonor. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class VideoDetailsViewController: BaseViewController {

    @IBOutlet weak var activityIndicatorPlayer: UIActivityIndicatorView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var constraintsContainerViewBottom: NSLayoutConstraint!
    var model: Video!
    var viewModel = SimilarVideosViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        doInitialConfig()
    }
    
    func doInitialConfig() {
        lblTitle.font = UIFont.fontWithTextStyle(textStyle: .title2)
        playVideoAndLoadSimilar(with: model)
        
    }
    
    func playVideoAndLoadSimilar(with model:Video) {
     
        self.model = model
        lblTitle.text = model.title ?? ""
        let videoId = model.data?.first?.playbackUrl?.components(separatedBy: "/").last
        
        if let playBackId = videoId {
            playerView.load(withVideoId: playBackId, playerVars: ["playsinline":"1"])
            
        }
        
        loadSimilarVideos(with: model.id!)

    }
    
    func loadSimilarVideos(with id: String) {
        
        self.activityIndicator.startAnimating()
        
        viewModel.loadSimilarVideos(by: id) { [weak self](result) in

            self?.activityIndicator.stopAnimating()
            switch (result){
            case .Success:
                self?.tableView.reloadData()
                print("success")
            case .failure(let msg):
                print(msg)
            }
            
            self?.isLoadingNextPageResults(false)
            self?.viewModel.isUserRefreshingList = false

        }
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension VideoDetailsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.vidoeList.count
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard viewModel.canLoadNextPage() else {
            return
        }
        
        let margin: CGFloat = 30
        let heightToLoadNextPage: CGFloat = scrollView.contentSize.height + margin
        let currentPosition: CGFloat = scrollView.contentOffset.y + scrollView.frame.size.height
        
        if (currentPosition >= heightToLoadNextPage) {
            isLoadingNextPageResults(true)
            loadNextPageResults()
        }
        
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
        
        print("state : \(state)")
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        activityIndicatorPlayer.stopAnimating()
        playerView.playVideo()

    }
}

extension VideoDetailsViewController{
    
    func loadNextPageResults() {
        loadSimilarVideos(with: model.id!)
    }
    
    func isLoadingNextPageResults(_ isLoading: Bool) {
        
        viewModel.isLoadingNextPageResults = isLoading
        
        if isLoading {
            constraintsContainerViewBottom.constant = kLoaderViewHeight
            addLoaderViewForNextResults()
            
        }
        else {
            
            self.constraintsContainerViewBottom.constant = 0
            
            let view = self.view.viewWithTag(kLoaderViewTag)
            view?.removeFromSuperview()
        }
        
        self.view.layoutIfNeeded()
    }
    
    
}






