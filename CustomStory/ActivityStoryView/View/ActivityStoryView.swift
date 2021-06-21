//
//  ActivityStoryView.swift
//  CustomStory
//
//  Created by Arif Amzad on 11/6/21.
//

import UIKit
import Kingfisher





//protocol ActivityStoryViewDelegate {
//    func tappedOnStoryAt(indexPath: IndexPath, fullScreenViewController: StoryFullScreenViewer)
//}


@IBDesignable
class ActivityStoryView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    private let storyViewNibName = "ActivityStoryView"
    private let storyCollectionnViewCellID = "StoryCollectionnViewCell"
    
    
    public var storyProperties = [StoryProperty]()
    public var avatarBorderColor = UIColor.systemBlue
    public var avatarBorderWidth = 3.0
    public var showBlurEffectOnFullScreenView = true
    //public var delegate: ActivityStoryViewDelegate?
    
    private let storyFullScreenViewer = UIStoryboard(name: "StoryView", bundle: nil).instantiateViewController(identifier: "StoryFullScreenViewer") as! StoryFullScreenViewer
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed(storyViewNibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        //contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        initCollectionView()
    }
    
    private func initCollectionView() {
        let nib = UINib(nibName: storyCollectionnViewCellID, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: storyCollectionnViewCellID)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func getCurrentViewController() -> UIViewController? {
        
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil
     }
    
    private func proceedToFullView(indexPath: IndexPath) {
        let destinationVC = self.storyFullScreenViewer
//        destinationVC.topTitleText = storyProperties[indexPath.item].title
//        destinationVC.avatarImageSrc = storyProperties[indexPath.item].avatar
//        destinationVC.storyImageSrc = storyProperties[indexPath.item].story
        destinationVC.storyProperties = storyProperties
        destinationVC.currentViewingStoryIndex = indexPath.item
        destinationVC.showBlurEffectOnFullScreenView = self.showBlurEffectOnFullScreenView
        
        let currentController = getCurrentViewController()
        currentController?.present(destinationVC, animated: true, completion: nil)

    }



}


extension ActivityStoryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storyProperties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.storyCollectionnViewCellID, for: indexPath) as? StoryCollectionnViewCell else {
            fatalError("can't dequeue StoryCollectionnViewCell")
        }
//        let avatarImageName = self.storyProperties[indexPath.item].avatar
//        let storyImageName = self.storyProperties[indexPath.item].story[0].image
//        cell.avatarImageView.kf.indicatorType = .activity
//        cell.avatarImageView.kf.setImage(with: URL(string: avatarImageName), placeholder: nil , options: nil) { (_) in
//
//        }
//        cell.storyImageView.kf.indicatorType = .activity
//        cell.storyImageView.kf.setImage(with: URL(string: storyImageName), placeholder: nil , options: nil) { (_) in
//        }
        cell.avatarImageView.image = UIImage(named: self.storyProperties[indexPath.item].avatar)
        cell.storyImageView.image = UIImage(named: self.storyProperties[indexPath.item].story[0].image)
        cell.avatarImageView.layer.borderColor = self.avatarBorderColor.cgColor
        cell.avatarImageView.layer.borderWidth = CGFloat(self.avatarBorderWidth)
        
        return cell
    }
}

extension ActivityStoryView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.delegate?.tappedOnStoryAt(indexPath: indexPath, fullScreenViewController: storyFullScreenViewer)
        //print("tapped on: \(indexPath.item)")
        
        self.proceedToFullView(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? StoryCollectionnViewCell {
                cell.transform = .init(scaleX: 0.80, y: 0.80)
                //cell.contentView.backgroundColor = UIColor.systemBlue
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? StoryCollectionnViewCell {
                cell.transform = .identity
                //cell.contentView.backgroundColor = .clear
            }
        }
    }
}

extension ActivityStoryView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellHeight = self.contentView.frame.size.height
        return CGSize(width: cellHeight*(2.0/3.4), height: cellHeight)
    }

    
}


