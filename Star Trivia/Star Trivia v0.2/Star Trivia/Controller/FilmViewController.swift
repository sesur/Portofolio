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
    
    @IBOutlet weak var previewButtonLabel: FadeButtonAnimation!
    @IBOutlet weak var nextButtonLabel: FadeButtonAnimation!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var crowlTextViewLabel: UITextView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    var personProtocol: Person?
    
    let api = FilmAPI()
    var filmsArray = [String]()
    var currentFilm = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filmsArray = personProtocol?.filmUrls ?? []
        nextButtonLabel.isEnabled = filmsArray.count > 1
        previewButtonLabel.isEnabled = false
        
        spinner.startAnimating()
        guard let firstFilm = filmsArray.first else {return}
        getFilms(url: firstFilm)
        
    }
    
    private func getFilms(url: String){
        spinner.startAnimating()
        api.getFilm(url: url) { (film) in
            self.spinner.stopAnimating()
            self.setupViews(film: film)
        }
    }
    
    private func setupViews(film: Film?){
        guard let film = film else {return}
        titleLabel.text = film.title
        producerLabel.text = film.producer
        directorLabel.text = film.producer
        episodeLabel.text = String(film.episode)
        releasedLabel.text = film.releaseDate
        let stripped = film.crawl.replacingOccurrences(of: "\n", with: " ")
        crowlTextViewLabel.text = stripped.replacingOccurrences(of: "\r", with: "") 
    }
    
    @IBAction func previewButtonPressed(_ sender: Any) {
        currentFilm -= 1
        setupButtons()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        currentFilm += 1
        setupButtons()
    }
    
    private func setupButtons() {
        nextButtonLabel.isEnabled = currentFilm == filmsArray.count - 1 ? false : true
        previewButtonLabel.isEnabled = currentFilm == 0 ? false: true
        getFilms(url: filmsArray[currentFilm])
    }
    
    
}
