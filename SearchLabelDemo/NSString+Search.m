//
//  NSString+Search.m
//  SearchLabelDemo
//
//  Created by 故乡的云 on 2020/1/8.
//  Copyright © 2020 故乡的云. All rights reserved.
//

#import "NSString+Search.h"

@implementation NSString (Search)
- (void)enumerateSearchText:(NSString *)searchText
                 usingBlock:(void (NS_NOESCAPE ^)(NSUInteger idx, NSRange range, BOOL *stop))block {
    
    if (!self.length || !searchText.length || ![self containsString:searchText]) return;
    
    NSUInteger __block len = searchText.length;
    NSUInteger __block loc = 0;
    NSArray <NSString *>*subStrings = [self componentsSeparatedByString:searchText];
    [subStrings enumerateObjectsUsingBlock:^(NSString *subText, NSUInteger idx, BOOL *stop) {
        
        loc += subText.length; // 当前idx对应searchText的location
        NSRange range = NSMakeRange(loc, len);
        
        if (block) block(idx, range, stop);
        
        loc += len; // 下一个subText的location
        if (idx == subStrings.count - 2) *stop = YES; // 到最后一个截止（不包括最后一个）
    }];
}

- (NSAttributedString *)attributedTextWithSearchText:(NSString *)searchText
                                           textColor:(UIColor *)textColor
                                            textFont:(UIFont *)textFont
                                     searchTextColor:(UIColor *)searchTextColor
                                      searchTextFont:(UIFont *)searchTextFont {
    if(!self)   return nil;
    
    NSDictionary *textAttbs = @{
        NSFontAttributeName: textFont,
        NSForegroundColorAttributeName: textColor
    };
    NSMutableAttributedString *attbText = [[NSMutableAttributedString alloc] initWithString:self attributes:textAttbs];

    if (!self.length || !searchText.length || ![self containsString:searchText])
        return attbText;

    NSDictionary __block *highlightAttbs = @{
           NSFontAttributeName: searchTextFont,
           NSForegroundColorAttributeName: searchTextColor
    };
    [self enumerateSearchText:searchText usingBlock:^(NSUInteger idx, NSRange range, BOOL *stop) {
        [attbText setAttributes:highlightAttbs range:range];
    }];
        
    return attbText;
}

@end
