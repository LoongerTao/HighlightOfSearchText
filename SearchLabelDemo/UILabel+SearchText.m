//
//  UILabel+SearchText.m
//  SearchLabelDemo
//
//  Created by 故乡的云 on 2020/1/7.
//  Copyright © 2020 故乡的云. All rights reserved.
//

#import "UILabel+SearchText.h"
#import "NSString+Search.h"

@implementation UILabel (SearchText)
- (void)setText:(nullable NSString *)text
     searchText:(nullable NSString *)searchText
      textColor:(nonnull UIColor *)textColor
searchTextColor:(nonnull UIColor *)searchTextColor {
    
    [self setText:text searchText:searchText textColor:textColor
         textFont:self.font searchTextColor:searchTextColor searchTextFont:self.font];
}

- (void)setText:(nullable NSString *)text
     searchText:(nullable NSString *)searchText
      textColor:(nonnull UIColor *)textColor
       textFont:(nonnull UIFont *)textFont
searchTextColor:(nonnull UIColor *)searchTextColor
 searchTextFont:(nonnull UIFont *)searchTextFont {

    self.attributedText = [text attributedTextWithSearchText:searchText
                                                   textColor:textColor
                                                    textFont:textFont
                                             searchTextColor:searchTextColor
                                              searchTextFont:searchTextFont];
}

@end
