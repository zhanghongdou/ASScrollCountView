//
//  ASCharacterView.m
//  ASScrollCountView
//
//  Created by haohao on 16/11/7.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASCharacterView.h"

@interface ASCharacterView ()
@property (nonatomic, strong) UILabel *textLabel;
@end
@implementation ASCharacterView

-(instancetype)initWithFrame:(CGRect)frame WithTextLabel:(UILabel *)label
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.textLabel = label;
        [self addSubview:label];
    }
    return self;
}

-(void)setCharacterArray:(NSArray *)characterArray
{
    _characterArray = characterArray;
    NSMutableString *string = [NSMutableString string];
    for(int i = 0; i < characterArray.count; i++){
        
        [string appendString: characterArray[i]];
        if(i != (characterArray.count - 1)){
            [string appendString: @"\n"];
        }
    }
    
    self.textLabel.text = string;
}

-(CGFloat)getPositionYWithIndex:(NSInteger)index
{
    return -index * (self.textLabel.frame.size.height / self.characterArray.count);
}

-(void)animationToPositionY:(CGFloat)positionY withCallback:(void(^)(void))callback {
    CGRect newFrame = self.frame;
    newFrame.origin.y = positionY;
    [UIView animateWithDuration:self.duration animations:^{
        self.frame = newFrame;
    } completion:^(BOOL finished) {
        callback();
    }];
}

-(void)setShowCharacter:(NSString *)showCharacter animated:(BOOL)animated
{
    if (self.style == ASScrollDirectionStyleUp) {
        NSInteger showCharacterIndex = showCharacter.integerValue;
        if (showCharacterIndex < self.showCharacterIndex) {
            [self animationToPositionY:[self getPositionYWithIndex:showCharacterIndex] withCallback:^{
                self.showCharacterIndex = showCharacterIndex;
                self.showCharacter = showCharacter;
            }];
        } else if (showCharacterIndex >= self.showCharacterIndex) {
            for (NSInteger i = self.characterArray.count / 2; i < self.characterArray.count; i++) {
                if ([self.characterArray[i] isEqualToString:showCharacter]) {
                    showCharacterIndex = i;
                    break;
                }
            }
            [self animationToPositionY:[self getPositionYWithIndex:showCharacterIndex] withCallback:^{
                self.showCharacterIndex = showCharacterIndex;
                self.showCharacter = showCharacter;
            }];
        }
    } else {
        NSInteger showCharacterIndex = self.characterArray.count - 1 - showCharacter.integerValue;
//        if (showCharacterIndex < self.showCharacterIndex) {
//            [self animationToPositionY:[self getPositionYWithIndex:showCharacterIndex] withCallback:^{
//                self.showCharacterIndex = showCharacterIndex;
//                self.showCharacter = showCharacter;
//            }];
//        }else if (showCharacterIndex > self.showCharacterIndex) {
            for (NSInteger i = 0; i < self.characterArray.count; i++) {
                if ([self.characterArray[i] isEqualToString:showCharacter]) {
                    showCharacterIndex = i;
                    break;
                }
            }
            [self animationToPositionY:[self getPositionYWithIndex:showCharacterIndex] withCallback:^{
                self.showCharacterIndex =  [self.characterArray indexOfObject: showCharacter];
                self.showCharacter = showCharacter;
            }];
//        }
    }
}


- (void)drawRect:(CGRect)rect {
    
}


@end
