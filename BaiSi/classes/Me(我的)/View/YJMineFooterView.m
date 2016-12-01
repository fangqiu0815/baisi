
#import "YJMineFooterView.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "YJSquare.h"
#import "UIButton+WebCache.h"
#import "YJSquareButton.h"


@interface YJMineFooterView ()

@property (nonatomic,strong ) AFHTTPSessionManager *mgr;

@end


@implementation YJMineFooterView

- (AFHTTPSessionManager *)mgr{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}


-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 发送请求
        [self.mgr GET:YJHostUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *squares = [YJSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            // 创建方块
            [self createSquares:squares];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            YJLog(@"error = %@",error);
        }];
        
    }
    return self;
}

#pragma mark 创建方块YJSquareButton
-(void)createSquares:(NSArray *)squares {
    //一行最多 4 列
    int maxCols = 4;
    
    CGFloat buttonW = YJScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i < squares.count; i++) {
        
        YJSquareButton *button = [YJSquareButton buttonWithType:UIButtonTypeCustom];
        button.square = squares[i];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.yj_x = col * buttonW;
        button.yj_y = row * buttonH;
        button.yj_width = buttonW;
        button.yj_height = buttonH;
    }
    NSUInteger rows = (squares.count + maxCols - 1) / maxCols;
    //计算 footer 的长度
    self.yj_height = rows * buttonH;
    // 重绘
    [self setNeedsDisplay];
}

-(void)buttonClick:(YJSquareButton *)button {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:button.square.url]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:button.square.url]];
    }
}


@end
