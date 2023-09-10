//
//  ViewController.swift
//  trabalho_ios_01
//
//  Created by BRUNO MOREIRA BATISTA on 06/09/23.
//

import UIKit

class ViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var characterList: [RickAndMortyCharacter] = []
    let service: RickAndMortyService
    
    init() {
        self.service = RickAndMortyService()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurreView()
        configureTableView()
        
        // Do any additional setup after loading the view.
//        self.view.backgroundColor = .blue
        
//        self.service.fetchCharacterList(
//            completion: { [weak self] result in
//                switch result {
//                case let .success(characterList):
//                    print(characterList)
//                    self?.characterList = characterList
//                    DispatchQueue.main.async {
//                        self?.tableView.reloadData()
//                    }
//                case let .failure(error) :
//                    print(error)
//                    self?.characterList = []
//                    DispatchQueue.main.async {
//                        self?.tableView.reloadData()
//                    }
//                }
//
//            }
//        )
        
        Task {
            do {
                self.characterList = try await self.service.fetchCharacterList()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                self.characterList = []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: UI Methods
extension ViewController {
    func configurreView() {
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(
            RickAndMortyCharacterTableViewCell.self,
            forCellReuseIdentifier: RickAndMortyCharacterTableViewCell.reuseIdentitier)
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterList.count
    }
}

//MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RickAndMortyCharacterTableViewCell.reuseIdentitier,
            for: indexPath) as? RickAndMortyCharacterTableViewCell else {
            return UITableViewCell()
        }
        let character = characterList[indexPath.row]
        cell.configure(with: character)
        
//        let clickRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tableViewClick))
//
//        cell.profileImage.isUserInteractionEnabled = true
//        cell.profileImage.addGestureRecognizer(clickRecognizer)
        
        return cell
    }
    
    @objc func tableViewClick(sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: tableView)
        let indexPath = self.tableView.indexPathForRow(at: tapLocation)
        let position = indexPath?.row ?? 0
        let item = characterList[position]
        
        //self.presentViewController(DetailsController(), animated: false, completion: nil)
        self.present(DetailsController(), animated: false, completion: nil)
        self.navigationController?.popViewController(animated: true)
        //self.present(DetailsController(), animated: false)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let position = indexPath.row
        let item = characterList[position]
        
        let details = DetailsController()
        details.char = item
        details.modalPresentationStyle = .fullScreen
        
        self.present(details, animated: false, completion: nil)
    }
}
