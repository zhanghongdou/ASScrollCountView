//
//  ASScrollCountView.h
//  ASScrollCountView
//
//  Created by haohao on 16/11/7.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASCharacterView.h"

@interface ASScrollCountView : UIView
/**
 *  characterWidth
 */
@property (nonatomic, assign) float characterWidth;
/**
 *  textFont
 */
@property (nonatomic, strong) UIFont *textFont;
/**
 *  textColor
 */
@property (nonatomic, strong) UIColor *textColor;
/**
 *  duration
 */
@property (nonatomic, assign) float duration;
/**
 *  scrollDirection
 */
@property (nonatomic, assign) ASScrollDirectionStyle style;
/**
 *  numberText
 */
@property (nonatomic, copy) NSString *numberText;


@end
