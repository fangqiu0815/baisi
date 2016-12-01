//
//  YJCommentCell.m
//  BaiSi
//
//  Created by 高方秋 on 2016/10/6.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJCommentCell.h"
#import "YJUser.h"
#import "YJComment.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+YJImageExtension.h"

/** 用户模型性别属性值-男*/
NSString *const YJUserSexMale = @"m";
/** 用户模型性别属性值-女*/
NSString *const YJUserSexFamale = @"f";

@interface YJCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@property (weak, nonatomic) IBOutlet UIButton *voiceButton;



@end



@implementation YJCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setComment:(YJComment *)comment {
    _comment = comment;
    
    [self.profileImageView setCircleHeader:comment.user.profile_image];
    self.sexView.image = [comment.user.sex isEqualToString:YJUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
}

-(void)setFrame:(CGRect)frame {
    frame.origin.x = 10;
    frame.size.width -= 2 * 10;
    //frame.size.height = 200;
    [super setFrame:frame];
}


@end
