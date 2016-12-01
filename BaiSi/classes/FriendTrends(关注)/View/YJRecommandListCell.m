//
//  YJRecommandListCell.m
//  BaiSi
//
//  Created by 高方秋 on 2016/10/5.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJRecommandListCell.h"
#import "YJRecommandList.h"

@interface YJRecommandListCell ()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicater;



@end

@implementation YJRecommandListCell

-(void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = YJColor(244, 244, 244);
    self.selectedIndicater.backgroundColor = YJColor(219, 21, 26);
}

-(void)setRecommandList:(YJRecommandList *)recommandList{
    _recommandList = recommandList;
    self.textLabel.text = recommandList.name;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    //重新调整内部textLabel的frame
    self.textLabel.yj_y = 2;
    self.textLabel.yj_height = self.contentView.yj_height - 2*self.textLabel.yj_y;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedIndicater.hidden = !selected;
    self.textLabel.textColor = selected ?  self.selectedIndicater.backgroundColor = [UIColor redColor]: YJColor(78, 78, 78);
}




@end
