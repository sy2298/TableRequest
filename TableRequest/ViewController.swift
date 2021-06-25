//
//  ViewController.swift
//  TableRequest
//
//  Created by 이서영 on 2021/06/24.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    var dummyModel : Dummy?
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(DummyCell.self,
                           forCellReuseIdentifier: DummyCell.identifier)
        return tableView
    }()
    var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        requestMovieAPI()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        //searchBar.delegate = self
    }
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    //network
    func loadImage(urlString:String, completion: @escaping (UIImage?) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        if let hasURL = URL(string:urlString){
        var request = URLRequest(url:hasURL)
        request.httpMethod = "GET"
            session.dataTask(with: request){ data,response,error in
                print((response as! HTTPURLResponse).statusCode)
                if let hasData = data{
                    completion(UIImage(data:hasData))
                    return
                }
                //리턴 클로저에서는 리턴하면 안됨
            }.resume()
            session.finishTasksAndInvalidate()
        }
        completion(nil)
    }
    func requestMovieAPI(){
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        var components = URLComponents(string: "https://randomuser.me/api/?results=20")
//        let term = URLQueryItem(name:"term",value:"marvel")
//        let media = URLQueryItem(name:"media",value: "movie")
//        components?.queryItems = [term,media]
        guard let url = components?.url else{
            return
        }
        var request = URLRequest(url:url)
        request.httpMethod="GET"
        
        let task = session.dataTask(with: request){ data,response,error in
            print( (response as! HTTPURLResponse).statusCode)
            if let hasData = data{
                do{
                    self.dummyModel =  try JSONDecoder().decode(Dummy.self, from: hasData)
                    print(self.dummyModel ?? "No Data")
                    DispatchQueue.main.async{
                    self.tableView.reloadData()
                    }//메인스레드에서 해야함
                }catch{
                    print(error)
                }
            }
        }.resume() //실행
    }
    
    
}
extension ViewController:
    UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dummyModel?.results.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DummyCell",
                                                for: indexPath) as! DummyCell
//        cell.titleLabel.text=self.movieModel?.results[indexPath.row].trackName
//        cell.descriptionLabel.text = self.movieModel?.results[indexPath.row].shortDescription
//        cell.descriptionLabel.numberOfLines=0
//        let currency = self.movieModel?.results[indexPath.row].currency ?? ""
//        let price = self.movieModel?.results[indexPath.row].trackPrice.description ?? ""
//        cell.priceLabel.text = currency + price
        cell.nameLabel.text = self.dummyModel?.results[indexPath.row].name?.first
        cell.phoneLabel.text = self.dummyModel?.results[indexPath.row].email
        if let hasURL =  self.dummyModel?.results[indexPath.row].picture?.thumbnail{
            print(hasURL)
            self.loadImage(urlString: hasURL){image in
                DispatchQueue.main.async{
                    cell.thumbImage.image=image
                   
                }
            }
        }
//        if let dateString = self.movieModel?.results[indexPath.row].releaseDate{
//           let formatter = ISO8601DateFormatter()
//            if let isoDate =  formatter.date(from: dateString){
//           let myFormatter = DateFormatter()
//            myFormatter.dateFormat="yyyy-MM-dd"
//            let dateString = myFormatter.string(from: isoDate)
//                cell.dateLabel.text = dateString
//            }
//        }
        return cell
    }
    
    
}
extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
