//
//  CustomCellCode.swift
//  NewsFeed
//
//  Created by Arman Davidoff on 15.03.2020.
//  Copyright © 2020 Arman Davidoff. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {
    
    static let cellID = "customCellCode"
    weak var delegate: CustomCellDelegate?
    private var galaryCollectionView = GalaryCollectionView()
    let viewModel = NewsFeedTableViewCellViewModel()
    
    //Первый слой
    private var cardView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    //TopViews
    private var topView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var personImage: UIImageView = {
        var view = UIImageView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var nameLabel: UILabel = {
        var view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = .link
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var dateLabel: UILabel = {
        var view = UILabel()
        view.textColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
        view.font = UIFont.systemFont(ofSize: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //dynamic Views withoutConstreints
    private var postsImageView: UIImageView = {
        var view = UIImageView()
        return view
    }()
    private var postTextView: UITextView = {
        var view = UITextView()
        view.font = Constants.postsTextFont
        view.isScrollEnabled = false
        view.isEditable = false
        view.isSelectable = true
        view.isUserInteractionEnabled = true
        let padding = view.textContainer.lineFragmentPadding
        view.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        view.dataDetectorTypes = UIDataDetectorTypes.all
        return view
    }()
    private var fullTextButton : UIButton = {
        var view = UIButton(type: UIButton.ButtonType.system)
        view.titleLabel?.font = Constants.buttonFont
        view.setTitle("Показать полностью...", for: .normal)
        return view
    }()
    //ButtonView
    private var bottonView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var likesView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var likesImage: UIImageView = {
        var view = UIImageView()
        let config = UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.medium)
        view.image = UIImage(systemName: "heart",withConfiguration: config)
        view.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var likesCountLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.lineBreakMode = .byWordWrapping
        view.font = UIFont.systemFont(ofSize: 14,weight: .medium)
        return view
    }()
    //BottonViews subviews
    private var commentsView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var commentsImage: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        let config = UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.medium)
        view.image = UIImage(systemName: "bubble.left",withConfiguration: config)
        return view
    }()
    private var commentsCountLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 14,weight: .medium)
        view.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.lineBreakMode = .byWordWrapping
        return view
    }()
    
    private var repostsView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var repostsImage: UIImageView = {
        var view = UIImageView()
        let config = UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight.medium)
        view.image = UIImage(systemName: "arrowshape.turn.up.right",withConfiguration: config)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
     
        return view
    }()
    private var repostsCountLabel: UILabel = {
        var view = UILabel()
        view.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 14,weight: .medium)
        return view
    }()
    
    private var viewsView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var viewsImage: UIImageView = {
        var view = UIImageView()
        view.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        view.image = UIImage(systemName: "eye.fill")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var viewsCountLabel: UILabel = {
        var view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        view.lineBreakMode = .byWordWrapping
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        fullTextButton.addTarget(self, action: #selector(showHideText), for: .touchUpInside)
        setupConstreintsForCard()
        setupConstreintsForTopView()
        setupConstreintsForBottonView()
        setupConstreintsForIconImage()
        setupConstreintsForNameLabel()
        setupConstreintsForDateLabel()
        setupConstreintsForLikesView()
        setupConstreintsForCommentsView()
        setupConstreintsForRepostsView()
        setupConstreintsForViewsView()
        setupConstreintsForMini(image: likesImage, label: likesCountLabel, superView: likesView)
        setupConstreintsForMini(image: commentsImage, label: commentsCountLabel, superView: commentsView)
        setupConstreintsForMini(image: repostsImage, label: repostsCountLabel, superView: repostsView)
        setupConstreintsForMiniForViews(image: viewsImage, label: viewsCountLabel, superView: viewsView)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        personImage.image = nil
        postsImageView.image = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        personImage.layer.cornerRadius = Constants.personImageHeight/2
        personImage.clipsToBounds = true
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 2.5, height: 4)
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func config(model: NewsFeedsViewModel.ModelForCell) {
        viewModel.setup(model: model)
        personImage.sd_setImage(with: viewModel.personImageURL)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postTextView.text = viewModel.postText
        likesCountLabel.text = viewModel.likes
        commentsCountLabel.text = viewModel.comments
        repostsCountLabel.text = viewModel.reposts
        viewsCountLabel.text = viewModel.views
        postTextView.frame = viewModel.postFrame
        fullTextButton.frame = viewModel.buttonFrame
        
        configCellType()
    }
    @objc private func showHideText() {
        delegate?.showFullText(cell: self)
    }
    
    private func configCellType() {
        switch viewModel.modelType {
        case .textOnly:
            postsImageView.frame = .zero
            self.postsImageView.isHidden = true
            galaryCollectionView.isHidden = true
            galaryCollectionView.frame = .zero
        case .oneImage(let url):
            postsImageView.frame = viewModel.imageFrame
            postsImageView.sd_setImage(with: url, completed: nil)
            postsImageView.contentMode = .scaleAspectFit
            self.postsImageView.isHidden = false
            galaryCollectionView.isHidden = true
            galaryCollectionView.frame = CGRect.zero
        case .manyImages:
            galaryCollectionView.frame = viewModel.collectionViewFrame
            galaryCollectionView.setup(photoModels: viewModel.postImageModels)
            galaryCollectionView.isHidden = false
            postsImageView.isHidden = true
            postsImageView.frame = .zero
        }
    }
}
//Constreints setup
private extension NewsFeedTableViewCell {
    //Constreints main
    func setupConstreintsForCard() {
        self.addSubview(cardView)
        cardView.addSubview(postsImageView)
        cardView.addSubview(postTextView)
        cardView.addSubview(fullTextButton)
        cardView.addSubview(galaryCollectionView)
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.cardViewSideInset/2).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.cardViewSideInset/(-2)).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.cardViewBottonInset).isActive = true
        cardView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    //Constreints topView
    func setupConstreintsForTopView() {
        cardView.addSubview(topView)
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.heightTopView).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
    }
    func setupConstreintsForIconImage() {
        topView.addSubview(personImage)
        personImage.heightAnchor.constraint(equalToConstant: Constants.personImageHeight).isActive = true
        personImage.widthAnchor.constraint(equalToConstant: Constants.personImageHeight).isActive = true
        personImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 12).isActive = true
        personImage.topAnchor.constraint(equalTo: topView.topAnchor, constant: 8).isActive = true
    }
    func setupConstreintsForNameLabel() {
        topView.addSubview(nameLabel)
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: personImage.trailingAnchor, constant: 8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 14).isActive = true
    }
    func setupConstreintsForDateLabel() {
        topView.addSubview(dateLabel)
        dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: personImage.trailingAnchor, constant: 8).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -14).isActive = true
    }
    //Constreints bottonView
    func setupConstreintsForBottonView() {
        cardView.addSubview(bottonView)
        bottonView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        bottonView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        bottonView.heightAnchor.constraint(equalToConstant: Constants.heightButtonView).isActive = true
        bottonView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
    }
    func setupConstreintsForLikesView() {
        bottonView.addSubview(likesView)
        likesView.widthAnchor.constraint(greaterThanOrEqualToConstant: 70).isActive = true
        likesView.leadingAnchor.constraint(equalTo: bottonView.leadingAnchor, constant: 12).isActive = true
        likesView.centerYAnchor.constraint(equalTo: bottonView.centerYAnchor).isActive = true
    }
    func setupConstreintsForCommentsView() {
        bottonView.addSubview(commentsView)
        commentsView.widthAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        commentsView.leadingAnchor.constraint(equalTo: likesView.trailingAnchor, constant: 12).isActive = true
        commentsView.centerYAnchor.constraint(equalTo: bottonView.centerYAnchor).isActive = true
    }
    func setupConstreintsForRepostsView() {
        bottonView.addSubview(repostsView)
        repostsView.widthAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        repostsView.leadingAnchor.constraint(equalTo: commentsView.trailingAnchor, constant: 12).isActive = true
        repostsView.centerYAnchor.constraint(equalTo: bottonView.centerYAnchor).isActive = true
    }
    func setupConstreintsForViewsView() {
        bottonView.addSubview(viewsView)
        viewsView.widthAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        viewsView.leadingAnchor.constraint(greaterThanOrEqualTo: repostsView.trailingAnchor,constant: 4).isActive = true
        viewsView.centerYAnchor.constraint(equalTo: bottonView.centerYAnchor).isActive = true
        viewsView.trailingAnchor.constraint(equalTo: bottonView.trailingAnchor, constant: -12).isActive = true
    }
    func setupConstreintsForMini(image: UIImageView,label: UILabel, superView: UIView) {
        superView.addSubview(image)
        superView.addSubview(label)
        if image.image == UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration.init(weight: .medium)) {
            //image.tintColor = .red
            image.widthAnchor.constraint(equalToConstant: 29).isActive = true
            image.heightAnchor.constraint(equalToConstant: 26).isActive = true
        } else {
            image.widthAnchor.constraint(equalToConstant: 26).isActive = true
            image.heightAnchor.constraint(equalToConstant: 23).isActive = true }
        image.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: image.trailingAnchor,constant: 3).isActive = true
        label.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        
    }
    func setupConstreintsForMiniForViews(image: UIImageView,label: UILabel, superView: UIView) {
        superView.addSubview(image)
        superView.addSubview(label)
        image.widthAnchor.constraint(equalToConstant: 17).isActive = true
        image.heightAnchor.constraint(equalToConstant: 15).isActive = true
        image.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: image.trailingAnchor,constant: 3).isActive = true
        label.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        
        
        
    }
}

