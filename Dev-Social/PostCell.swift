//
//  PostCell.swift
//  Dev-Social
//
//  Created by Raycho Karaivanov on 09/02/2017.
//  Copyright © 2017 Raycho Karaivanov. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
  
    }

    func configureCell(post: Post) {
        self.post = post
        
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        
    }

}
