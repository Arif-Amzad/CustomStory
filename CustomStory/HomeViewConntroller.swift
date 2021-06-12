//
//  HomeViewConntroller.swift
//  CustomStory
//
//  Created by Arif Amzad on 11/6/21.
//

import UIKit



class HomeViewConntroller: UIViewController {
    
    
    @IBOutlet weak var storyView: ActivityStoryView!
    
    var storyProperties = [ActivityStoryView.StoryProperty]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViewDidLoad()
    }
    
    
    private func setupViewDidLoad() {
        loadStoryProperties()
    }
    
    
    private func loadStoryProperties() {
        do {
            if let file = Bundle.main.url(forResource: "Stories", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ActivityStoryView.Stories.self, from: data)

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
}
