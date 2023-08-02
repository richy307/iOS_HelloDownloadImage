//
//  ViewController.swift
//  iOS_HelloDownloadImage
//
//  Created by 王麒翔 on 2023/8/1.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    
    var session: URLSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        session = URLSession(configuration: .default)
        
        // String -> URL -> Data -> UIImage
        let imageAddress:String = "https://inapp.com/wp-content/uploads/elementor/thumbs/swift-01-q05qmwpi08qczw6n86y04p8o0662t41v843uww1xoy.png"
        if let imageURL = URL(string: imageAddress){
            /*
            // dataTask: 文字資料, XML, JSON, string // return data
            let task = session?.dataTask(with: imageURL, completionHandler: {
                // urlResponse:200, 404
                (data, urlResponse, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                
                if let loadedData = data {
                    let loadedImage = UIImage(data: loadedData)
                    DispatchQueue.main.async {
                        self.myImageView.image = loadedImage
                    }
                }
            })
            task?.resume() // 開始下載圖片
            */
            
            // downloadTask: 下載圖片、資料 // return url
            let newTask = session?.downloadTask(with: imageURL, completionHandler: {
                (url, urlResponse, error) in
                if error != nil {
                    let errorCode = (error! as NSError).code // 轉型成 NSError
                    if errorCode == -1009 {
                        print("No Internet Connection") // or alert
                    }else{
                        print(error!.localizedDescription)
                    }
                    return
                }
                
                if let loadedURL = url{
                    do{
                        let loadedImage = UIImage(data: try Data(contentsOf: loadedURL))
                        DispatchQueue.main.async {
                            self.myImageView.image = loadedImage
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            })
            newTask?.resume()
            
            /*
            // global queue 共時佇列
            DispatchQueue.global().async {
                do{
                    let imageData = try Data(contentsOf: imageURL)
                    let downloadImage = UIImage(data: imageData)
                    
                    // main queue 主佇列 更新畫面
                    DispatchQueue.main.async {
                        self.myImageView.image = downloadImage
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
            */
        }
    }

}

