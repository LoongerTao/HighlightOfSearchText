# HighlightOfSearchText  搜索高亮匹配


![示意图1](https://upload-images.jianshu.io/upload_images/3333500-b565a9973ef2c147.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![示意图2](https://upload-images.jianshu.io/upload_images/3333500-97b7acd3282b0ec3.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 1. 给`NSString分类`添加`搜索字段范围检索`的方法
- 思路：将一个`String`通过`searchText`分割成一个数组，然后通过`subString和searchText的长度和`来获取需要检索的`Range`

- 核心代码：
```
/** 遍历self中的searchText字段，通过block返回对应的range和索引
 * @param searchText    搜索(高亮)字段
 * @param block  检索到对象的回调, idx : 遍历对象的索引(从0开始)，range ：遍历对象所在范围。如果没有匹配到相关字段，block将不会被调用
 */
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
```

### 2.  给`NSString分类`添加`高亮显示搜索字段`的方法
```
/** 自动匹配搜索字段，将self生成富文本输出。 如果self == nil， 则返回 nil
 * @param searchText   搜索(高亮)字段
 * @param textColor      默认字体颜色
 * @param textFont       默认字体
 * @param searchTextColor       高亮文本颜色
 * @param searchTextFont         高亮文本字体。
 */
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
```

### 3. 进一步对`UILabel（分类）`进行拓展（可以省略）
```
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
```

### 4. 使用(在cell 中使用)
```
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.numberOfLines = 0;
    }
   
    NSString *text = self.searchResults[indexPath.row];
    [cell.textLabel setText:text
                 searchText:_searchBar.text
                  textColor:[UIColor colorWithWhite:0.03 alpha:1]
                   textFont:[UIFont systemFontOfSize:14]
            searchTextColor:[UIColor colorWithRed:239/255.0 green:75/255.0 blue:76/255.0 alpha:1]
             searchTextFont:[UIFont boldSystemFontOfSize:18]];
    return cell;
}

```
