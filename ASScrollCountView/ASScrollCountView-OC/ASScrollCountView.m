//
//  ASScrollCountView.m
//  ASScrollCountView
//
//  Created by haohao on 16/11/7.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASScrollCountView.h"
#define CountViewWidth self.frame.size.width
#define CountViewHeight self.frame.size.height
@interface ASScrollCountView ()
@property (nonatomic, strong) NSMutableArray *scrollViewArray;
@property (nonatomic, strong) NSArray *charactersArray;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@end
@implementation ASScrollCountView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setDefaultAttributes];
    }
    return self;
}


-(void)setDefaultAttributes
{
    self.backgroundColor = [UIColor whiteColor];
    self.characterWidth = 8.0f;
    self.textFont = [UIFont systemFontOfSize:12];
    self.textColor = [UIColor blackColor];
    self.scrollViewArray = [NSMutableArray array];
    self.style = ASScrollDirectionStyleUp;
    self.duration = 1.0f;
    [self addMaskLayer];
}

-(UIBezierPath *)creatBezierPath
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CountViewWidth, self.textFont.lineHeight + 2)];
    return bezierPath;
}

-(void)addMaskLayer
{
    self.maskLayer = [CAShapeLayer layer];
    self.maskLayer.path = [self creatBezierPath].CGPath;
    self.layer.mask = self.maskLayer;
}

-(void)updateMaskLayout
{
    self.layer.mask = nil;
    self.maskLayer = [CAShapeLayer layer];
    self.maskLayer.path = [self creatBezierPath].CGPath;
    self.layer.mask = self.maskLayer;
}

-(void)setNumberText:(NSString *)numberText
{
    if (![_numberText isEqualToString:numberText]) {
        NSInteger oldLength = _numberText.length;
        NSInteger newLength = numberText.length;
        if(newLength > oldLength){
            NSInteger needLength = newLength - oldLength;
            for(int i = 0 ; i < needLength; i++){
                [self addNewASCharacterView];
            }
        } else if(newLength < oldLength){
            NSInteger needLength = oldLength - newLength;
            for(int i = 0 ; i < needLength; i++){
                [self deleteRedundantCharacterView];
            }
        }
      //Update the layout about the array
        [self updateLayout];
    
        [self.scrollViewArray enumerateObjectsUsingBlock:^(ASCharacterView *characterView, NSUInteger idx, BOOL * _Nonnull stop) {
            [characterView setShowCharacter:[numberText substringWithRange:NSMakeRange(idx, 1)] animated:YES];
        }];
        _numberText = numberText;
    }
}


-(void)updateLayout
{
    __block float originX = 0;
    float originY = 0;
    if (self.style == ASScrollDirectionStyleDown) {
        originY = -((self.charactersArray.count - 1) * self.textFont.lineHeight);
    }else{
        originY = 0;
    }
    [self.scrollViewArray enumerateObjectsUsingBlock:^(ASCharacterView *characterView, NSUInteger idx, BOOL * _Nonnull stop) {
        characterView.frame = CGRectMake(originX, originY, self.characterWidth, self.charactersArray.count * self.textFont.lineHeight);
        originX += self.characterWidth;
    }];
}

- (void)addNewASCharacterView{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.characterWidth, self.charactersArray.count * self.textFont.lineHeight)];
    label.textColor = self.textColor;
    label.textAlignment = NSTextAlignmentRight;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.font = self.textFont;
    ASCharacterView *characterView = [[ASCharacterView alloc]initWithFrame:CGRectMake(0, 0, self.characterWidth, self.charactersArray.count * self.textFont.lineHeight) WithTextLabel:label];
    
    characterView.showCharacter = @"0";
    characterView.showCharacterIndex = self.charactersArray.count - 1;
    characterView.style = self.style;
    characterView.duration = self.duration;
    characterView.characterArray = self.charactersArray;
    [self addSubview:characterView];
    
    [self.scrollViewArray addObject:characterView];
}

-(void)deleteRedundantCharacterView
{
    if (self.scrollViewArray.count > 0) {
        ASCharacterView *characterView = (ASCharacterView *)self.scrollViewArray[0];
        [characterView removeFromSuperview];
        [self.scrollViewArray removeObject:characterView];
    }
}


-(void)setCharacterWidth:(float)characterWidth
{
    if (characterWidth != _characterWidth) {
       _characterWidth = characterWidth;
        //update mask
        [self updateMaskLayout];
    }
}

-(void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
}

-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
}

-(void)setDuration:(float)duration
{
    _duration = duration;
}

-(void)setStyle:(ASScrollDirectionStyle)style
{
    if (_style != style) {
        _style = style;
        if (style == ASScrollDirectionStyleDown) {
            self.charactersArray = @[@"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", @"1", @"0"];
        }else{
            self.charactersArray = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
        }
        
    }
}


- (void)drawRect:(CGRect)rect {
    
}

@end
