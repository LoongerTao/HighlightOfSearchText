//
//  UILabel+SearchText.h
//  SearchLabelDemo
//
//  Created by 故乡的云 on 2020/1/7.
//  Copyright © 2020 故乡的云. All rights reserved.
//
//  给UILabel拓展搜索匹配功能，对搜索字段进行高亮显示

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (SearchText)

/** 自动匹配搜索字段，并高亮显示
 * @param text 赋值给label的text（即label.text）
 * @param searchText 搜索字段
 * @param textColor 默认样式字体颜色
 * @param searchTextColor 高亮文本颜色
 */
- (void)setText:(nullable NSString *)text
     searchText:(nullable NSString *)searchText
      textColor:(nonnull UIColor *)textColor
searchTextColor:(nonnull UIColor *)searchTextColor;


/** 自动匹配搜索字段，并高亮显示
 * @param text 赋值给label的text（即label.text）
 * @param searchText 搜索字段
 * @param textColor 默认样式字体颜色
 * @param textFont 默认样式字体
 * @param searchTextColor 高亮文本颜色。传nil时，默认为 0xFE5621
 * @param searchTextFont 高亮文本字体。
 */
- (void)setText:(nullable NSString *)text
     searchText:(nullable NSString *)searchText
      textColor:(nonnull UIColor *)textColor
       textFont:(nonnull UIFont *)textFont
searchTextColor:(nonnull UIColor *)searchTextColor
 searchTextFont:(nonnull UIFont *)searchTextFont;
@end

NS_ASSUME_NONNULL_END
