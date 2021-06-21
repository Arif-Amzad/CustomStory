//
//  HomeViewConntroller.swift
//  CustomStory
//
//  Created by Arif Amzad on 11/6/21.
//

import UIKit



class HomeViewConntroller: UIViewController {
    
    
    @IBOutlet weak var storyView: ActivityStoryView!
    
    var storyProperties = [StoryProperty]()
    var stories:IGStories?
   // var storyProperty: StoryProperty!
    var story: Story!
    var storyArray = [Story]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViewDidLoad()
    }
    
    
    private func setupViewDidLoad() {
        
        //Modify some appearance
        self.storyView.avatarBorderColor = .systemBlue
        self.storyView.avatarBorderWidth = 3.0
        self.storyView.showBlurEffectOnFullScreenView = false
        
        
        //fetch stories data from your sources(ex: Api call) and put them in "self.storyView.storyProperties" array
        self.loadStoryProperties()
        fetchStories()
    }
    
    
    private func loadStoryProperties() {
        do {
            if let file = Bundle.main.url(forResource: "Stories", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Stories.self, from: data)

                self.storyView.storyProperties = jsonData.stories
                
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                if let object = json as? [String: Any] {
//                    // json is a dictionary
//                    print(object)
//                } else if let object = json as? [Any] {
//                    // json is an array
//                    print(object)
//                } else {
//                    print("JSON is invalid")
//                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchStories() {
        Api.shared.getStories(withPageNo: 1, pageSize: 100){ (success,error,stories) in
            DispatchQueue.main.async { [self] in
                
                if success {
                    storyProperties.removeAll()
                if let stories = stories {
                    print(stories.stories[0].user.name)
                    self.stories = stories
                    let totalStories = stories.stories
                    for eachStory in totalStories {
                        let avatar = eachStory.user.picture
                    
                      let userName = eachStory.user.name
                        let lastUpdate = eachStory.lastUpdated
                        
                        if let snaps = eachStory.snaps {
                            storyArray.removeAll()
                            for eachSnap in snaps {
                                let imageUrl = eachSnap.url
                                let story = Story(image: imageUrl)
                                storyArray.append(story)
                            }
                           
                            
                           // print(storyProperty)
                        }
                        let storyProperty = StoryProperty(last_updated: lastUpdate, title: userName, avatar: avatar, story: storyArray)
                        storyProperties.append(storyProperty)
                        
                    }
                    
                    print(storyProperties.debugDescription)
                    print(error)
                }
                    self.storyView.storyProperties = storyProperties
            }
        }
        }
    }
    
}
