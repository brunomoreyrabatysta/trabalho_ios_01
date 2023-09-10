//
//  DetailsController.swift
//  trabalho_ios_01
//
//  Created by BRUNO MOREIRA BATISTA on 10/09/23.
//

import UIKit

final class DetailsController: UIViewController {
    static var reuseIdentitier: String = "DetailsController"

    public let profileImage = UIImageView()
    public let nameLabel = UILabel()
    public let statusLabel = UILabel()
    public var char = RickAndMortyCharacter(id: 0, name: "", status: "", imageURL: nil)

    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .gray
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override func viewDidLoad() {
        
        var character = RickAndMortyCharacter(id: 1, name:"Earth (C-137)", status: "Alive", imageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
        
        super.viewDidLoad()
        setupViews(character: char)
        // Do any additional setup after loading the view.
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: UI Methods
extension DetailsController {
    func setupViews(character: RickAndMortyCharacter) {
        view.backgroundColor = .white
        configureView()
        configureContentView()
        
//        ImageManager.shared.loadImage(from: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")) { image in
//            self.profileImage.image = image
//        }
//        nameLabel.text = "Earth (C-137)"
//        statusLabel.text = "Alive"
        
        ImageManager.shared.loadImage(from: character.imageURL) { image in
            self.profileImage.image = image
        }
        nameLabel.text = character.name
        statusLabel.text = character.status
        
        configureClique()
    }
    
    func configureView() {
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }
    
    func configureContentView() {
        contentView.addArrangedSubview(profileImage)
        contentView.addArrangedSubview(nameLabel)
        contentView.addArrangedSubview(statusLabel)
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 00),
            profileImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            //profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 40),
            //profileImage.widthAnchor.constraint(equalToConstant: 40),
            //profileImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            //nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            //nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            statusLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
    }
    
    func configureClique() {
        let clickRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.profileImageClick))
        
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(clickRecognizer)
    }
    
    @objc func profileImageClick(sender: UITapGestureRecognizer) {
        dismiss(animated: true,completion: nil)
    }
}
