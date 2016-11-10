//
//  ASCharacterView.h
//  ASScrollCountView
//
//  Created by haohao on 16/11/7.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASConst.h"
@interface ASCharacterView : UIView
@property (nonatomic, assign) ASScrollDirectionStyle style;
@property (nonatomic, strong) NSArray *characterArray;
@property (nonatomic, assign) float duration;
@property (nonatomic, copy) NSString *showCharacter;
@property (nonatomic, assign) NSInteger showCharacterIndex;
-(instancetype)initWithFrame:(CGRect)frame WithTextLabel:(UILabel *)label;
-(void)setShowCharacter:(NSString *)showCharacter animated:(BOOL)animated;
@end
