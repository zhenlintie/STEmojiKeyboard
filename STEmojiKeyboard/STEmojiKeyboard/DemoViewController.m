//
//  DemoViewController.m
//  STEmojiKeyboard
//
//  Created by zhenlintie on 15/5/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "DemoViewController.h"
#import "STInputBar.h"

@interface DemoViewController ()

@end

@implementation DemoViewController{
    STInputBar *_inputBar;
    UIScrollView *_scrollView;
    UILabel *_textWindow;
    NSArray *_names;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _inputBar = [STInputBar inputBar];
    _inputBar.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.bounds)-CGRectGetHeight(_inputBar.frame)+CGRectGetHeight(_inputBar.frame)/2);
    [_inputBar setFitWhenKeyboardShowOrHide:YES];
    _inputBar.placeHolder = @"小明的故事...";
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:_scrollView];
    [self updateEdgeInsets];
    
    _textWindow = [[UILabel alloc] initWithFrame:_scrollView.bounds];
    _textWindow.numberOfLines = 0;
    _textWindow.tag = 0;
    [_scrollView addSubview:_textWindow];
    
    [self.view addSubview:_inputBar];
    
    __weak typeof(self) weakSelf = self;
    [_inputBar setDidSendClicked:^(NSString *text) {
        [weakSelf updateMessage:text];
    }];
    [_inputBar setInputBarSizeChangedHandle:^{
        [weakSelf updateEdgeInsets];
    }];
    
    _names = @[@"小明",@"老师"];
}

- (void)updateMessage:(NSString *)message{
    
    static NSDictionary *_txtAtt = nil;
    if (!_txtAtt){
        _txtAtt = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                    NSForegroundColorAttributeName:[UIColor darkTextColor]};
    }
    static NSDictionary *_timeAtt = nil;
    if (!_timeAtt){
        _timeAtt = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:13],
                     NSForegroundColorAttributeName:[UIColor colorWithWhite:0.2 alpha:0.5]};
    }
    
    NSString *name = _names[_textWindow.tag];
    _inputBar.placeHolder = @"对话...";
    NSString *reply = [NSString stringWithFormat:@"回复 %@",_names[0]];
    if (1 == _textWindow.tag){
        name = [NSString stringWithFormat:@"%@ %@",name,reply];
    }
    else{
        _inputBar.placeHolder = reply;
    }
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:_textWindow.attributedText];
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n\n--- %@ ---\n%@\n",[self time],name] attributes:_timeAtt]];
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:message attributes:_txtAtt]];
    [_textWindow setAttributedText:text];
    CGSize size = [_textWindow sizeThatFits:CGSizeMake(CGRectGetWidth(self.view.frame), 100000)];
    _textWindow.frame = CGRectMake(0, 0, size.width, size.height);
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(_textWindow.frame));
    
    _textWindow.tag = (_textWindow.tag+1)%_names.count;
}

- (void)updateEdgeInsets{
    _scrollView.contentInset = UIEdgeInsetsMake(-10, 0, CGRectGetHeight(_inputBar.frame)+10, 0);
}

- (NSString *)time{
    static NSDateFormatter *_dateFormatter = nil;
    if (!_dateFormatter){
        _dateFormatter = [NSDateFormatter new];
        _dateFormatter.dateFormat = @"HH:mm:ss";
    }
    return [_dateFormatter stringFromDate:[NSDate date]];
}


@end

