//
//  ViewController.m
//  STEmojiKeyboard
//
//  Created by zhenlintie on 15/5/29.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "ViewController.h"
#import "STEmojiKeyboard.h"

@interface ViewController ()
@property (weak, nonatomic) UITextView *textView;
@end

@implementation ViewController

- (void)loadView{
    self.view = [UITextView new];
    self.textView = (UITextView *)self.view;
    self.textView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    STEmojiKeyboard *keyboard = [STEmojiKeyboard keyboard];
    keyboard.textView = self.textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
