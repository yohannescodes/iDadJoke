//
//  ViewController.swift
//  iDadJoke
//
//  Created by Yohannes Haile on 9/13/22.
//

import UIKit

class DadJokeViewController: UIViewController {
    
    @IBOutlet weak var setupLabel: UILabel!
    @IBOutlet weak var punchlineLabel: UILabel!
    @IBOutlet weak var laughBtn: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func makeMeLaughTapped(){
        fetchDadJoke()
    }
    
    func fetchDadJoke(){
        Networking.shared.getDadJoke { result in
            switch(result){
            case .success(let dadjoke):
                print(dadjoke.success)
                DispatchQueue.main.async {
                    self.setupLabel.text = dadjoke.body[0].setup
                    self.punchlineLabel.text = dadjoke.body[0].punchline
                    self.laughBtn.setTitle("\"Another One\"", for: .normal)
                }
            case .failure(let error):
                print(error)
                if(error == .responseProblem){
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Whoops", message: "It seems like you are not connected to the internet. Please try again!", preferredStyle: .alert)
                        let tryAgain = UIAlertAction(title: "Try Again", style: .default) { _ in
                            alert.resignFirstResponder()
                            self.fetchDadJoke()
                        }
                        alert.addAction(tryAgain)
                        self.present(alert, animated: true)
                    }
                }else if(error == .decodingProblem){
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Sorry", message: "John wants you to smile exactly 50 times a day 😕.", preferredStyle: .alert)
                        let notEnough = UIAlertAction(title: "That's not enough 😭.", style: .default) { _ in
                            alert.resignFirstResponder()
                        }
                        alert.addAction(notEnough)
                        self.present(alert, animated: true)
                }
            }
        }
    }
}
}
