//
//  ViewController.m
//  SearchLabelDemo
//
//  Created by 故乡的云 on 2020/1/7.
//  Copyright © 2020 故乡的云. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+SearchText.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIColor *highlightColor;
@property(nonatomic, strong) NSArray *items;
@property(nonatomic, strong) NSMutableArray *searchResults;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _searchBar.delegate = self;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorInset = UIEdgeInsetsZero;
}

// MARK: - UITableViewDataSource
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.numberOfLines = 0;
    }
    
    /// 由于富文本会覆盖label原本的textColor，所以每次都要重新设置字体颜色
//    cell.textLabel.textColor = [UIColor colorWithWhite:0.03 alpha:1];
 
    NSString *text = self.searchResults[indexPath.row];
    [cell.textLabel setText:text
                 searchText:_searchBar.text
                  textColor:[UIColor colorWithWhite:0.03 alpha:1]
                   textFont:[UIFont systemFontOfSize:14]
            searchTextColor:[UIColor colorWithRed:239/255.0 green:75/255.0 blue:76/255.0 alpha:1]
             searchTextFont:[UIFont boldSystemFontOfSize:18]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar endEditing:YES];
}

// MARK: - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length) {
        [self.searchResults removeAllObjects];
        [self.items enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([text containsString:searchText]) {
                [self.searchResults addObject:text];
            }
        }];
    }else {
        [self.searchResults addObjectsFromArray:self.items];
    }
    
    [_tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
}

// MARK: - lazy
- (NSMutableArray *)searchResults {
    if (!_searchResults) {
        _searchResults = [NSMutableArray arrayWithArray:self.items];
    }
    return _searchResults;
}

- (NSArray *)items {
    if (!_items) {
        _items = @[
            @"1234567890-00112233445566778899",
            @"ABCDEFGHIGKLMNOPQRSTUVWXYZ-AABBCCDDEEFFGGHHIIGGKK-KKLLMMNNOOPPQQRRSSTTUUVVWWXYYZZ",
            @"欢天喜地度佳节 张灯结彩迎新春 横批：家庭幸福",
            @"迎新春事事如意 接鸿福步步高升 横批：好事临门",
            @"万事如意展宏图 心想事成兴伟业 横批：五福临门",
            @"绿竹别其三分景 红梅正报万家春 横批：春回大地",
            @"年年顺景则源广 岁岁平安福寿多 横批：吉星高照",
            @"五更分两年年年称心 一夜连两岁岁岁如意 横批：恭贺新春",
            @"五湖四海皆春色 万水千山尽得辉 横批：万象更新",
            @"喜居宝地千年旺 福照家门万事兴 横批：喜迎新春",
            @"喜滋滋迎新年 笑盈盈辞旧岁 横批：喜迎新春",
            @"天增岁月人增寿 春满乾坤福满楼 横批：四季长安",
            @"一帆风顺吉星到 万事如意福临门 横批：财源广进",
            @"一帆风顺年年好 万事如意步步高 横批：吉星高照",
            @"一干二净除旧习 五讲四美树新风 横批：辞旧迎春",
            @"一年好运随春到 四季彩云滚滚来 横批：万事如意",
            @"一年四季春常在 万紫千红永开花 横批：喜迎新春",
            @"一年四季行好运 八方财宝进家门 横批：家和万事兴",
            @"悠悠乾坤共老 昭昭日月争光 横批：欢度佳节",
            @"佳节迎春春生笑脸 丰收报喜喜上眉梢 横批：喜笑颜开",
            @"一年四季春常在 万紫千红永开花 横批：喜迎新春",
            @"春满人间百花吐艳 福临小院四季常安 横批：欢度春节",
            @"百世岁月当代好 千古江山今朝新 横批：万象更新",
            @"喜居宝地千年旺 福照家门万事兴 横批：喜迎新春",
            @"一帆风顺年年好 万事如意步步高 横批：吉星高照",
            @"百年天地回元气 一统山河际太平 横批：国泰民安",
            @"春雨丝丝润万物 红梅点点绣千山 横批：春意盎然",
            @"一干二净除旧习 五讲四美树新风 横批：辞旧迎春",
            @"五湖四海皆春色 万水千山尽得辉 横批：万象更新",
            @"一帆风顺吉星到 万事如意福临门 横批：财源广进",
            @"一年四季行好运 八方财宝进家门 横批：家和万事兴",
            @"绿竹别其三分景 红梅正报万家春 横批：春回大地",
            @"红梅含苞傲冬雪 绿柳吐絮迎新春 横批：欢度春节",
            @"日出江花红胜火 春来江水绿如蓝 横批：鸟语花香",
            @"春满人间欢歌阵阵 福临门第喜气洋洋 横批：五福四海",
            @"春临大地百花艳 节至人间万象新 横批：万事如意",
            @"福星高照全家福省 春光耀辉满堂春 横批：春意盎然",
            @"事事如意大吉祥 家家顺心永安康 横批：四季兴隆",
            @"春色明媚山河披锦绣 华夏腾飞祖国万年轻 横批：山河壮丽",
            @"迎新春江山锦绣 辞旧岁事泰辉煌 横批：春意盎然",
            @"旧岁又添几个喜 新年更上一层楼 横批：辞旧迎新",
            @"东风化雨山山翠 政策归心处处春 横批：春风化雨",
            @"家过小康欢乐日 春回大地艳阳天 横批：人心欢畅",
            @"多劳多得人人乐 丰产丰收岁岁甜 横批：形势喜人",
            @"壮丽山河多异彩 文明国度遍高风 横批：山河壮丽",
            @"财连亨通步步高 日子红火腾腾起 横批：迎春接福",
            @"福旺财旺运气旺 家兴人兴事业兴 横批：喜气盈门",
            @"大地流金万事通 冬去春来万象新 横批：欢度春节",
            @"大地歌唤彩云 满园春关不住 横批：春色满园",
            @"盛世千家乐 新春百家兴 横批：欢度佳节",
            @"千年迎新春 瑞雪兆丰年 横批：年年有余",
            @"欢声笑语贺新春 欢聚一堂迎新年 横批：合家欢乐",
            @"财源滚滚随春到 喜气洋洋伴福来 横批：财源广进",
            @"春风入喜财入户 岁月更新福满门 横批：新春大吉",
            @"大顺大财大吉利 新春新喜新世纪 横批：万事如意",
            @"占天时地利人和 取九州四海财宝 横批：财源不断",
            @"高居宝地财兴旺 福照家门富生辉 横批：心想事成",
            @"天地和顺家添财 平安如意人多福 横批：四季平安",
            @"春归大地人间暖 福降神州喜临门 横批：福喜盈门",
            @"内外平安好运来 合家欢乐财源进 横批：吉星高照",
            @"日日财源顺意来 年年福禄随春到 横批：新春大吉",
            @"迎喜迎春迎富贵 接财接福接平安 横批：吉祥如意",
            @"创大业千秋昌盛 展宏图再就辉煌 横批：大展宏图",
            @"一帆风顺年年好 万事如意步步高 横批：五福临门",
            @"民安国泰逢盛世 风调雨顺颂华年 横批：民泰国安",
            @"精耕细作丰收岁 勤俭持家有余年 横批：国强富民"
        ];
    }
    
    return _items;
}
@end
