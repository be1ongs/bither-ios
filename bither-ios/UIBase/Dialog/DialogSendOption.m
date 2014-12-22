//
//  DialogSendOption.m
//  bither-ios
//
//  Created by 宋辰文 on 14/12/22.
//  Copyright (c) 2014年 宋辰文. All rights reserved.
//

#import "DialogSendOption.h"
#import "NSString+Size.h"

#define kButtonHeight (44)
#define kButtonEdgeInsets (UIEdgeInsetsMake(0, 10, 0, 10))
#define kMinWidth (160)
#define kFontSize (16)

@implementation DialogSendOption

-(instancetype)initWithDelegate:(NSObject<DialogSendOptionDelegate>*)delegate{
    NSString* str = NSLocalizedString(@"select_change_address_option_name", nil);
    CGFloat width = [str sizeWithRestrict:CGSizeMake(CGFLOAT_MAX, kButtonHeight) font:[UIFont systemFontOfSize:kFontSize]].width + kButtonEdgeInsets.left + kButtonEdgeInsets.right;
    width = MAX(kMinWidth, width);
    self = [super initWithFrame:CGRectMake(0, 0, width, kButtonHeight * 2 + 1)];
    if(self){
        self.delegate = delegate;
        [self firstConfigure];
    }
    return self;
}

-(void)firstConfigure{
    self.bgInsets = UIEdgeInsetsMake(4, 16, 4, 16);
    CGFloat bottom = 0;
    bottom = [self createButtonWithText:NSLocalizedString(@"select_change_address_option_name", nil) top:bottom action:@selector(selectChangeAddressPressed:)];
    UIView *seperator = [[UIView alloc]initWithFrame:CGRectMake(0, bottom, self.frame.size.width, 1)];
    seperator.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    seperator.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [self addSubview:seperator];
    
    bottom += 1;
    bottom = [self createButtonWithText:NSLocalizedString(@"Cancel", nil) top:bottom action:@selector(cancelPressed:)];
    CGRect frame = self.frame;
    frame.size.height = bottom;
    self.frame = frame;
}

-(void)selectChangeAddressPressed:(id)sender{
    __weak __block NSObject<DialogSendOptionDelegate>* d = self.delegate;
    [self dismissWithCompletion:^{
        if(d && [d respondsToSelector:@selector(selectChangeAddress)]){
            [d selectChangeAddress];
        }
    }];
}

-(void)cancelPressed:(id)sender{
    [self dismiss];
}

-(CGFloat)createButtonWithText:(NSString*)text top:(CGFloat)top action:(SEL)selector{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, top, self.frame.size.width, kButtonHeight)];
    [btn setBackgroundImage:nil forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"card_foreground_pressed"] forState:UIControlStateHighlighted];
    btn.contentEdgeInsets = kButtonEdgeInsets;
    btn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.titleLabel.font = [UIFont systemFontOfSize:kFontSize];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithWhite:1 alpha:0.6] forState:UIControlStateHighlighted];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return CGRectGetMaxY(btn.frame);
}


@end
