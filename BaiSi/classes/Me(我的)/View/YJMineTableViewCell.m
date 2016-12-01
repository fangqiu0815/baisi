

#import "YJMineTableViewCell.h"

@implementation YJMineTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        self.textLabel.textColor = [UIColor lightGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if (self.imageView.image == nil) return;
    
    self.imageView.yj_width = 30;
    self.imageView.yj_height = self.imageView.yj_width;
    self.imageView.yj_centerY = self.contentView.yj_height * 0.5;
    
    self.textLabel.yj_x = CGRectGetMaxX(self.imageView.frame) + 10;
}

//-(void)setFrame:(CGRect)frame {
//    frame.origin.y -= (35 - 10);
//    [super setFrame:frame];
//}



@end
