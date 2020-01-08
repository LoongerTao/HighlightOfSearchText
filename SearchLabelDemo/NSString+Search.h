//
//  NSString+Search.h
//  SearchLabelDemo
//
//  Created by 故乡的云 on 2020/1/8.
//  Copyright © 2020 故乡的云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Search)

/** 遍历self中的searchText字段，通过block返回对应的range和索引
 * @param searchText    搜索(高亮)字段
 * @param block  遍历回调, idx : 遍历对象的索引(从0开始)，range ：遍历对象所在范围。如果没有匹配到相关字段，block将不会被调用
 */
- (void)enumerateSearchText:(NSString *)searchText
                 usingBlock:(void (NS_NOESCAPE ^)(NSUInteger idx, NSRange range, BOOL *stop))block;

/** 自动匹配搜索字段，将self生成富文本输出。 如果self == nil， 则返回 nil
 * @param searchText    搜索(高亮)字段
 * @param textColor      默认字体颜色
 * @param textFont        默认字体
 * @param searchTextColor       高亮文本颜色
 * @param searchTextFont         高亮文本字体。
 */
- (NSAttributedString *)attributedTextWithSearchText:(NSString *)searchText
                                           textColor:(UIColor *)textColor
                                            textFont:(UIFont *)textFont
                                     searchTextColor:(UIColor *)searchTextColor
                                      searchTextFont:(UIFont *)searchTextFont;
@end

NS_ASSUME_NONNULL_END
