//
//  ViewController.swift
//  iOS_HelloDownloadImage
//
//  Created by 王麒翔 on 2023/8/1.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // String -> URL -> Data -> UIImage
        let imageAddress:String = "https://cdn3.macworld.co.uk/cmsdata/features/3523633/swift_1200home_thumb800.jpg"
        if let imageURL = URL(string: imageAddress){
            do{
                let imageData = try Data(contentsOf: imageURL)
                myImageView.image = UIImage(data: imageData)
            }catch{
                print(error.localizedDescription)
            }
        }
    }


}

