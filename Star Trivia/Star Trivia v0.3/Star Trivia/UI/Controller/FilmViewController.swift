//
//  FilmViewController.swift
//  Star Trivia
//
//  Created by Sergiu on 3/15/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import UIKit

class FilmViewController: UIViewController, PersonProtocol, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    
    @IBOutlet weak var previewFilm: FadeButtonAnimation!
    @IBOutlet weak var nextFilm: FadeButtonAnimation!
    @IBOutlet weak var released: UILabel!
    @IBOutlet weak var producer: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var episode: UILabel!
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var crowl: UITextView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    var person: Person?
    
    let api = FilmAPI()
    var filmsArray = [String]()
    var currentFilm = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmsArray = person?.filmUrls ?? []
        nextFilm.isEnabled = filmsArray.count > 1
        previewFilm.isEnabled = false
        
        spinner.startAnimating()
        guard let firstFilm = filmsArray.first else {return}
        fetchFilmsFrom(url: firstFilm)
        
    }
    
    private func fetchFilmsFrom(url: String){
        spinner.startAnimating()
        api.getFilm(url: url) { (result) in
            switch result {
            case .success(let film): self.updateDetailsFor(film)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    private func updateDetailsFor(_ film: Film?){
        spinner.stopAnimating()
        
        guard let film = film else {return}
        filmTitle.text = film.title
        producer.text = film.producer
        director.text = film.producer
        episode.text = String(film.episode)
        released.text = film.releaseDate
        let stripped = film.crawl.replacingOccurrences(of: "\n", with: " ")
        crowl.text = stripped.replacingOccurrences(of: "\r", with: "") 
    }
    
    @IBAction func pressPreviewButton(_ sender: Any) {
        currentFilm -= 1
        setupButtons()
    }
    
    @IBAction func pressNextButton(_ sender: Any) {
        currentFilm += 1
        setupButtons()
    }
    
    private func setupButtons() {
        nextFilm.isEnabled = currentFilm == filmsArray.count - 1 ? false : true
        previewFilm.isEnabled = currentFilm == 0 ? false: true
        fetchFilmsFrom(url: filmsArray[currentFilm])
    }
    
    
}
