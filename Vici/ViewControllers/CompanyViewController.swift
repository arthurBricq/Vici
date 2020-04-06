//
//  CompanyViewController.swift
//  Vici
//
//  Created by Arthur BRICQ on 04/04/2020.
//  Copyright © 2020 ArthurBricq. All rights reserved.
//

import UIKit

class CompanyViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Constants
    
    /// Stands for the height of the row of a service, within the servicesStackView
    let serviceHeight: CGFloat = 50
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var helpHeaderLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var coverImateView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet var serviceImageViews: [UIImageView]!
    
    @IBOutlet weak var servicesStackView: UIStackView!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var pictures: [UIImage] = []
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var heartButton: UIButton!
    var helpImageView: UIImageView?
    
    // MARK: - Action
    
    @IBAction func heartButton(_ sender: Any) {
        self.company!.changeFavoriteSetting()
        self.setUpFavoriteButton()
    }
    
    // MARK: - Variables
    
    var company: Company?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(backButton)
        
        // Set the image collection view
        collectionView.dataSource = self
        collectionView.delegate = self
        self.pictures = [UIImage(named: "carrottes")!, UIImage(named: "vaches")!, UIImage(named: "velo1")!]
        
        // Set all the data on the screen
        heartButton.tintColor = UIColor.white
        setUpFavoriteButton()
        setUpServicesStackView()
        if let company = company {
            company.setScreenWithSelf(titleLabel: titleLabel, bodyLabel: bodyLabel, serviceImageViews: serviceImageViews)
            company.displayImages(coverImageView: coverImateView, logoImageView: logoImageView)
        }
        setUpCharitySection()
        setUpCommentSection()
        
        // Set round logo image
        self.logoImageView.layer.cornerRadius = self.logoImageView.frame.width/2
        self.logoImageView.layer.borderColor = UIColor.gray.cgColor
        self.logoImageView.layer.borderWidth = 1.0
        
        // Set up gradient
        let view = UIView(frame: coverImateView.frame)
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        coverImateView.addSubview(view)
        coverImateView.bringSubviewToFront(view)
    }
    
    // this hides the view if we leave using the bar menu
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.popViewController(animated: false)
    }
    
    private func setUpFavoriteButton() {
        let isFavorite: Bool = self.company!.isFavorite()
        if isFavorite {
            heartButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            heartButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    
    /**
        This function will programmatically update the stackview that shows all the services offered by the company
     */
    private func setUpServicesStackView() {
        // two things to do
        // 1. add one row for each service
        // 2. Update the overall height of the content view, so that it is not overbig
        
        let c = company!
        let services = c.services!
        let computedHeight = CGFloat(services.count) * (serviceHeight + servicesStackView.spacing)
        stackViewHeightConstraint.constant = computedHeight
        
        for s in services {
            let name = ServiceCategory(rawValue: s.category)!.getLogoName()
            let image = UIImage(named: name)
            let imageView = UIImageView(image: image)
            imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1.0, constant: 0.0))
            
            let label = UILabel()
            label.text = s.description
            label.font = UIFont.preferredFont(forTextStyle: .caption1)
            label.numberOfLines = 0
            
            let stack = UIStackView(arrangedSubviews: [imageView, label])
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .fill
            stack.spacing = 8
            self.servicesStackView.addArrangedSubview(stack)
        }
        
        // TODO (2)
    }
    
    // This section add the Charity part
    // Assume it is to be added
    private func setUpCharitySection() {
        let spacing: CGFloat = 30
        let imageSize: CGFloat = 30
        let y0 = self.servicesStackView.frame.origin.y + stackViewHeightConstraint.constant + spacing - 15
        let x0: CGFloat = 20
        
        let label = UILabel(frame: CGRect(x: x0, y: y0, width: 300, height: 50))
        label.text = "How to help us"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        
        let imageView = UIImageView(frame: CGRect(x: x0, y: y0+20+spacing, width: imageSize, height: imageSize))
        imageView.image = UIImage(named: "CharityLogo")
        self.helpImageView = imageView
        let f = imageView.frame
        
        let w: CGFloat = 280
        let helpLabel = UILabel(frame: CGRect(x: x0 + f.size.width + 20 , y: y0+20+spacing, width: w, height: 100))
        helpLabel.numberOfLines = 0
        helpLabel.text = "Aidez-moi s'il vous plait on a besoin de vous, je vous marque un text assez long qui explique comment est-ce que vous pouvez m'aidez mais soyons partielle svp"
        helpLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        helpLabel.textAlignment = .justified
        helpLabel.sizeToFit()
        
        self.contentView.addSubview(label)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(helpLabel)
    
    }
    
    private func setUpCommentSection() {
        // 1. Get the starting point where the add some comments
        var y0: CGFloat = 0
        let x0: CGFloat = 20
        let spacing: CGFloat = 20
        let imageSize: CGFloat = 3
        if let iv = helpImageView {
            y0 = iv.frame.origin.y + iv.frame.width + 50
        } else {
            y0 = servicesStackView.frame.origin.y + self.servicesStackView.frame.size.height + spacing
        }
        
        let label = UILabel(frame: CGRect(x: x0, y: y0, width: 300, height: 50))
        label.text = "Comments"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        
        let imageView = UIImageView(frame: CGRect(x: x0, y: y0+20+spacing, width: imageSize, height: imageSize))
        imageView.image = UIImage(named: "ProfileLogo")
        
        let h1: CGFloat = 70
        let line = UIView(frame: CGRect(x: 5, y: 5, width: 2, height: h1-10))
        line.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        let view1 = UIView(frame: CGRect(x: x0+imageSize+spacing , y: y0+20+spacing, width: 300, height: h1))
        let lbl1 = UILabel(frame: CGRect(x: 15, y: 4, width: view1.frame.width - 30, height: view1.frame.height - 20))
        lbl1.text = "aoiwhdo idoiwvh doia ci ifa iugsf uzg DUFAGZWF OIUSAG FOIUhd ouizgaduzgwa iduz<g douz<ag douigaouzg<a douzagw odiuzgd ouziag "
        lbl1.font = UIFont.preferredFont(forTextStyle: .caption1)
        lbl1.numberOfLines = 0
        lbl1.sizeToFit()
        view1.addSubview(line)
        view1.addSubview(lbl1)
        
        let h2: CGFloat = 70
        let line2 = UIView(frame: CGRect(x: 5, y: 5, width: 2, height: h2-10))
        line2.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
        let view2 = UIView(frame: CGRect(x: x0+imageSize+spacing , y: view1.frame.maxY + 10 , width: 300, height: h2))
        let lbl2 = UILabel(frame: CGRect(x: 15, y: 4, width: view1.frame.width - 30, height: view1.frame.height - 20))
        lbl2.text = "aoiwhdo idoiwvh doia ci ifa iugsf uzg DUFAGZWF OIUSAG FOIUhd ouizgaduzgwa iduz<g douz<ag douigaouzg<a douzagw odiuzgd ouziag "
        lbl2.font = UIFont.preferredFont(forTextStyle: .caption1)
        lbl2.numberOfLines = 0
        lbl2.sizeToFit()
        view2.addSubview(line2)
        view2.addSubview(lbl2)

        
        self.contentView.addSubview(label)
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(view1)
        self.contentView.addSubview(view2)
        
    }

}

extension CompanyViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        cell.setCell(legend: "Legend", image: self.pictures[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: collectionView.frame.height - 10)
    }
    
    
    
    
    
}
