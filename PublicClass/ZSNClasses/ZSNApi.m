//
//  ZSNApi.m
//  FBCircle
//
//  Created by soulnear on 14-5-14.
//  Copyright (c) 2014年 szk. All rights reserved.
//

#import "ZSNApi.h"
//#import "FriendAttribute.h"
//#import "FullyLoaded.h"

@implementation ZSNApi


//字体

#define HELVETICA_FONT [UIFont fontWithName:@"Helvetica" size:14.0]

//取图片
+(UIImage *)getImageWithName:(NSString *)name
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    UIImage * aImage = [UIImage imageWithContentsOfFile:path];
    return aImage;
}


//按比例缩放
+(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

///
+(UIImage *)scaleToSizeWithImage:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

+(NSString *)returnUrl:(NSString *)theUrl
{
    NSString * uid = theUrl;
    
    if (uid.length !=0 && uid.length < 9)
    {
        for (int i = 0;i < uid.length -9;i++)
        {
            uid = [NSString stringWithFormat:@"%d%@",0,uid];
        }
    }
    
    NSString * string;
    if (uid.length ==0)
    {
        string = @"";
    }else
    {
        string =  [NSString stringWithFormat:@"http://avatar.fblife.com/%@/%@/%@/%@_avatar_small.jpg",[[uid substringToIndex:3] substringFromIndex:0],[[uid substringToIndex:5] substringFromIndex:3],[[uid substringToIndex:7] substringFromIndex:5],[[uid substringToIndex:9] substringFromIndex:7]];
    }
    
    return string;
}

+(NSString *)returnMiddleUrl:(NSString *)theUrl
{
    NSString * uid = theUrl;
    
    if (uid.length !=0 && uid.length < 9)
    {
        for (int i = 0;i < uid.length -9;i++)
        {
            uid = [NSString stringWithFormat:@"%d%@",0,uid];
        }
    }
    
    NSString * string;
    if (uid.length ==0)
    {
        string = @"";
    }else
    {
        string =  [NSString stringWithFormat:@"http://avatar.fblife.com/%@/%@/%@/%@_avatar_middle.jpg",[[uid substringToIndex:3] substringFromIndex:0],[[uid substringToIndex:5] substringFromIndex:3],[[uid substringToIndex:7] substringFromIndex:5],[[uid substringToIndex:9] substringFromIndex:7]];
    }
    
    return string;
}

+(NSString *)timechange:(NSString *)placetime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[placetime doubleValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}
+(NSString *)timechange1:(NSString *)placetime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM-dd HH:mm:ss"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[placetime doubleValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

+(NSString *)timechangeByAll:(NSString *)placetime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[placetime doubleValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}


+(NSString *)timechangeToDateline
{
    return [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
}



+(NSArray *)stringExchange:(NSString *)string
{
    while ([string rangeOfString:@"[b]"].length || [string rangeOfString:@"[/b]"].length || [string rangeOfString:@"[i]"].length || [string rangeOfString:@"[/i]"].length || [string rangeOfString:@"[u]"].length || [string rangeOfString:@"[/u]"].length||[string rangeOfString:@"&nbsp;"].length)
    {
        string = [string stringByReplacingOccurrencesOfString:@"[b]" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"[/b]" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"[i]" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"[/i]" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"[u]" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"[/u]" withString:@""];
        string = [string stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
        
    }
    
    while ([string rangeOfString:@"\r"].length)
    {
        NSLog(@"去掉r");
        string = [string stringByReplacingOccurrencesOfString: @"\r" withString:@""];
    }
    
    string = [string stringByReplacingOccurrencesOfString:@"[/img]" withString:@"[/img]|@|"];
    
    string = [string stringByReplacingOccurrencesOfString:@"[img]" withString:@"|@|[img]"];
    
    NSArray * arr = [string componentsSeparatedByString:@"|@|"];
    
    return arr;
    
}

+(float)calculateheight:(NSArray *)array
{
    
    float height = 0.0;
    for (NSString * string in array)
    {
        if (string.length > 0)
        {
            if ([string rangeOfString:@"[img]"].length && [string rangeOfString:@"[/img]"].length)
            {
                height += 90;
                
            }else
            {
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,300,50)];
                CGPoint point = [self LinesWidth:string Label:label font:[UIFont systemFontOfSize:16]];
                
                height += point.y;
            }
        }
    }
    return height;
}


+(CGPoint)LinesWidth:(NSString *)string Label:(UILabel *)label font:(UIFont *)thefont
{
    CGSize titleSize = [string sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(label.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    CGPoint lastPoint;
    
    CGSize sz = [string sizeWithFont:thefont constrainedToSize:CGSizeMake(MAXFLOAT,40)];
    
    CGSize linesSz = [string sizeWithFont:thefont constrainedToSize:CGSizeMake(label.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    if(sz.width <= linesSz.width) //判断是否折行
    {
        lastPoint = CGPointMake(label.frame.origin.x + sz.width,titleSize.height + 2);
    }else
    {
        lastPoint = CGPointMake(label.frame.origin.x + (int)sz.width % (int)linesSz.width,titleSize.height);
    }
    
    return lastPoint;
}

+ (float)theHeight:(NSString *)content withHeight:(CGFloat)theheight WidthFont:(UIFont *)font
{
    return 0.0f;
}


+(NSString*)timestamp:(NSString*)myTime{
    
    NSString *timestamp;
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now,  [myTime integerValue]);
    if (distance < 0) distance = 0;
    
    if (distance < 60) {
        timestamp = [NSString stringWithFormat:@"%d%@", distance, @"秒钟前"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        timestamp = [NSString stringWithFormat:@"%d%@", distance, @"分钟前"];
    }
    else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        timestamp = [NSString stringWithFormat:@"%d%@", distance,@"小时前"];
    }
    else if (distance < 60 * 60 * 24 * 7) {
        distance = distance / 60 / 60 / 24;
        timestamp = [NSString stringWithFormat:@"%d%@", distance,@"天前"];
    }
    else if (distance < 60 * 60 * 24 * 7 * 4) {
        distance = distance / 60 / 60 / 24 / 7;
        timestamp = [NSString stringWithFormat:@"%d%@", distance, @"周前"];
    }else
    {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        }
        NSDate *date = [NSDate dateWithTimeIntervalSince1970: [myTime integerValue]];
        
        timestamp = [dateFormatter stringFromDate:date];
    }
    
    return timestamp;
}


+ (NSString*)FBImageChange:(NSString*)imgSrc
{
    NSString* img=imgSrc;
//    img= [img stringByReplacingOccurrencesOfString:@"[发呆]" withString:@"<img src=\"face1.png\">    </img>"] ;
//    img= [img stringByReplacingOccurrencesOfString:@"[无奈]" withString:@"<img src=\"face2.png\">    </img>"] ;
//    img= [img stringByReplacingOccurrencesOfString:@"[坏笑]" withString:@"<img src=\"face3.png\">    </img>"] ;
//    img= [img stringByReplacingOccurrencesOfString:@"[撇嘴]" withString:@"<img src=\"face4.png\">    </img>"] ;
//    img= [img stringByReplacingOccurrencesOfString:@"[可爱]" withString:@"<img src=\"face5.png\">    </img>"] ;
//    img= [img stringByReplacingOccurrencesOfString:@"[得意]" withString:@"<img src=\"face6.png\">    </img>"] ;
//    img= [img stringByReplacingOccurrencesOfString:@"[晕]" withString:@"<img src=\"face7.png\">    </img>"] ;
//    img= [img stringByReplacingOccurrencesOfString:@"[大哭]" withString:@"<img src=\"face8.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[衰]"   withString:@"<img src=\"face9.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[难过]" withString:@"<img src=\"face10.png\">    </img>"] ;
//    img= [img stringByReplacingOccurrencesOfString:@"[微笑]" withString:@"<img src=\"face11.png\">    </img>"] ;
//    img= [img stringByReplacingOccurrencesOfString:@"[傻笑]" withString:@"<img src=\"face12.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[愤怒]" withString:@"<img src=\"face13.png\">    </img>"] ;
//    img= [img stringByReplacingOccurrencesOfString:@"[酷]" withString:@"<img src=\"Expression_25.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[汗]" withString:@"<img src=\"face15.png\">    </img>"] ;
//    img= [img stringByReplacingOccurrencesOfString:@"[惊讶]" withString:@"<img src=\"face16.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[鼻涕]" withString:@"<img src=\"face17.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[美女]" withString:@"<img src=\"face18.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[帅哥]" withString:@"<img src=\"face19.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[流泪]" withString:@"<img src=\"face20.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[囧]" withString:@"<img src=\"face21.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[生气]" withString:@"<img src=\"face22.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[雷人]" withString:@"<img src=\"face23.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[吓]" withString:@"<img src=\"face24.png\">    </img>"] ;
//    img= [img stringByReplacingOccurrencesOfString:@"[大笑]" withString:@"<img src=\"face25.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[吐]" withString:@"<img src=\"face26.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[尴尬]" withString:@"<img src=\"face27.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[感动]" withString:@"<img src=\"face28.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[纠结]" withString:@"<img src=\"face29.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[宠物]" withString:@"<img src=\"face30.png\">    </img>"] ;
//    img= [img stringByReplacingOccurrencesOfString:@"[睡觉]" withString:@"<img src=\"face31.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[奋斗]" withString:@"<img src=\"face32.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[左哼]" withString:@"<img src=\"face33.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[右哼]" withString:@"<img src=\"face34.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[崩溃]" withString:@"<img src=\"face35.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[委屈]" withString:@"<img src=\"face36.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[疑问]"  withString:@"<img src=\"face37.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[太棒了]" withString:@"<img src=\"face38.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[鄙视]"   withString:@"<img src=\"face39.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[打哈欠]" withString:@"<img src=\"face40.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[无语]" withString:@"<img src=\"face41.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[亲亲]" withString:@"<img src=\"face42.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[恐惧]" withString:@"<img src=\"face43.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[骷髅]" withString:@"<img src=\"face44.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[俏皮]" withString:@"<img src=\"face45.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[爱财]" withString:@"<img src=\"face46.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[海盗]" withString:@"<img src=\"face47.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[难受]" withString:@"<img src=\"face48.png\">    </img>"] ;
//    img= [img stringByReplacingOccurrencesOfString:@"[思考]" withString:@"<img src=\"face49.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[感冒]" withString:@"<img src=\"face50.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[闭嘴]" withString:@"<img src=\"face51.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[菜刀]" withString:@"<img src=\"face52.png\">    </img>"] ;
//    img= [img stringByReplacingOccurrencesOfString:@"[礼物]" withString:@"<img src=\"face53.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[药水]" withString:@"<img src=\"face54.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[雨天]" withString:@"<img src=\"face55.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[砸]" withString:@"<img src=\"face56.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[炸弹]" withString:@"<img src=\"face57.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[胜利]" withString:@"<img src=\"face58.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[发飙]" withString:@"<img src=\"face59.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[喜欢]" withString:@"<img src=\"face60.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[不错]" withString:@"<img src=\"face61.png\">    </img>"] ;
//    img= [img stringByReplacingOccurrencesOfString:@"[大爱]" withString:@"<img src=\"face62.png\">    </img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[仰慕]" withString:@"<img src=\"face63.png\">    </img>"] ;
    
    
    

    
    img= [img stringByReplacingOccurrencesOfString:@"[愣神]" withString:@"<img src=\"Expression_1.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[思考]" withString:@"<img src=\"Expression_2.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[大笑]" withString:@"<img src=\"Expression_3.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[大哭]" withString:@"<img src=\"Expression_4.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[发怒]" withString:@"<img src=\"Expression_5.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[恶魔]" withString:@"<img src=\"Expression_6.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[撇嘴]" withString:@"<img src=\"Expression_7.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[害羞]" withString:@"<img src=\"Expression_8.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[霸气]" withString:@"<img src=\"Expression_9.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[睡觉]" withString:@"<img src=\"Expression_10.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[真棒]" withString:@"<img src=\"Expression_11.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[晕菜]" withString:@"<img src=\"Expression_12.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[礼物]" withString:@"<img src=\"Expression_13.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[微笑]" withString:@"<img src=\"Expression_14.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[鬼脸]" withString:@"<img src=\"Expression_15.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[傻笑]" withString:@"<img src=\"Expression_16.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[可爱]" withString:@"<img src=\"Expression_17.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[憨笑]" withString:@"<img src=\"Expression_18.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[伤心]" withString:@"<img src=\"Expression_19.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[惊讶]" withString:@"<img src=\"Expression_20.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[哈欠]" withString:@"<img src=\"Expression_21.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[劈掌]" withString:@"<img src=\"Expression_22.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[得意]" withString:@"<img src=\"Expression_23.png\"> 你l</img>"] ;
    img= [img stringByReplacingOccurrencesOfString:@"[大爱]" withString:@"<img src=\"Expression_24.png\"> 你l</img>"] ;
    

    
    
    //替换回车占位符
    img= [img stringByReplacingOccurrencesOfString:@"\n" withString:@" "] ;
    img= [img stringByReplacingOccurrencesOfString:@"\r" withString:@" "] ;
    //替换  &  这个符号
//    img= [img stringByReplacingOccurrencesOfString:@"&" withString:@" "] ;
    return img;
}

+ (NSString*)FBEximgreplace:(NSString*)imgSrc
{
    NSString* img=imgSrc;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face1.png\">    </img>" withString:@"[发呆]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face2.png\">    </img>" withString:@"[无奈]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face3.png\">    </img>" withString:@"[坏笑]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face4.png\">    </img>" withString:@"[撇嘴]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face5.png\">    </img>" withString:@"[可爱]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face6.png\">    </img>" withString:@"[得意]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face7.png\">    </img>" withString:@"[晕]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face8.png\">    </img>" withString:@"[大哭]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face9.png\">    </img>" withString:@"[衰]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face10.png\">    </img>" withString:@"[难过]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face11.png\">    </img>" withString:@"[微笑]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face12.png\">    </img>" withString:@"[傻笑]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face13.png\">    </img>" withString:@"[愤怒]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face14.png\">    </img>" withString:@"[酷]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face15.png\">    </img>" withString:@"[汗]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face16.png\">    </img>" withString:@"[惊讶]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face17.png\">    </img>" withString:@"[鼻涕]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face18.png\">    </img>" withString:@"[美女]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face19.png\">    </img>" withString:@"[帅哥]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face20.png\">    </img>" withString:@"[流泪]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face21.png\">    </img>" withString:@"[囧]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face22.png\">    </img>" withString:@"[生气]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face23.png\">    </img>" withString:@"[雷人]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face24.png\">    </img>" withString:@"[吓]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face25.png\">    </img>" withString:@"[大笑]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face26.png\">    </img>" withString:@"[吐]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face27.png\">    </img>" withString:@"[尴尬]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face28.png\">    </img>" withString:@"[感动]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face29.png\">    </img>" withString:@"[纠结]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face30.png\">    </img>" withString:@"[宠物]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face31.png\">    </img>" withString:@"[睡觉]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face32.png\">    </img>" withString:@"[奋斗]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face33.png\">    </img>" withString:@"[左哼]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face34.png\">    </img>" withString:@"[右哼]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face35.png\">    </img>" withString:@"[崩溃]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face36.png\">    </img>" withString:@"[委屈]"];
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face37.png\">    </img>" withString:@"[疑问]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face38.png\">    </img>" withString:@"[太棒了]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face39.png\">    </img>" withString:@"[鄙视]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face40.png\">    </img>" withString:@"[打哈欠]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face41.png\">    </img>" withString:@"[无语]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face42.png\">    </img>" withString:@"[亲亲]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face43.png\">    </img>" withString:@"[恐惧]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face44.png\">    </img>" withString:@"[骷髅]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face45.png\">    </img>" withString:@"[俏皮]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face46.png\">    </img>" withString:@"[爱财]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face47.png\">    </img>" withString:@"[海盗]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face48.png\">    </img>" withString:@"[难受]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face49.png\">    </img>" withString:@"[思考]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face50.png\">    </img>" withString:@"[感冒]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face51.png\">    </img>" withString:@"[闭嘴]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face52.png\">    </img>" withString:@"[菜刀]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face53.png\">    </img>" withString:@"[礼物]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face54.png\">    </img>" withString:@"[药水]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face55.png\">    </img>" withString:@"[雨天]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face56.png\">    </img>" withString:@"[砸]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face57.png\">    </img>" withString:@"[炸弹]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face58.png\">    </img>" withString:@"[胜利]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face59.png\">    </img>" withString:@"[发飙]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face60.png\">    </img>" withString:@"[喜欢]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face61.png\">    </img>" withString:@"[不错]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face62.png\">    </img>" withString:@"[大爱]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"face63.png\">    </img>" withString:@"[仰慕]"] ;
    
    
    
    
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_1.png\">    </img>" withString:@"[愣神]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_2.png\">    </img>" withString:@"[思考]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_3.png\">    </img>" withString:@"[大笑]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_4.png\">    </img>" withString:@"[大哭]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_5.png\">    </img>" withString:@"[发怒]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_6.png\">    </img>" withString:@"[恶魔]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_7.png\">    </img>" withString:@"[撇嘴]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_8.png\">    </img>" withString:@"[害羞]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_9.png\">    </img>"   withString:@"[霸气]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_10.png\">    </img>" withString:@"[睡觉]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_11.png\">    </img>" withString:@"[真棒]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_12.png\">    </img>" withString:@"[晕菜]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_13.png\">    </img>" withString:@"[礼物]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_14.png\">    </img>" withString:@"[微笑]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_15.png\">    </img>" withString:@"[鬼脸]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_16.png\">    </img>" withString:@"[傻笑]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_17.png\">    </img>" withString:@"[可爱]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_18.png\">    </img>" withString:@"[憨笑]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_19.png\">    </img>" withString:@"[伤心]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_20.png\">    </img>" withString:@"[惊讶]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_21.png\">    </img>" withString:@"[哈欠]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_22.png\">    </img>" withString:@"[劈掌]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_23.png\">    </img>" withString:@"[得意]"] ;
    img= [img stringByReplacingOccurrencesOfString:@"<img src=\"Expression_24.png\">    </img>" withString:@"[大爱]"] ;

    
    
    //替换回车占位符
    img= [img stringByReplacingOccurrencesOfString:@"\n" withString:@" "] ;
    img= [img stringByReplacingOccurrencesOfString:@"\r" withString:@" "] ;
    
    //替换  &  这个符号
//    img= [img stringByReplacingOccurrencesOfString:@"&" withString:@" "] ;
    return img;
}





+(UIViewAnimationOptions)animationOptionsForCurve:(UIViewAnimationCurve)curve
{
    switch (curve) {
        case UIViewAnimationCurveEaseInOut:
            return UIViewAnimationOptionCurveEaseInOut;
            break;
        case UIViewAnimationCurveEaseIn:
            return UIViewAnimationOptionCurveEaseIn;
            break;
        case UIViewAnimationCurveEaseOut:
            return UIViewAnimationOptionCurveEaseOut;
            break;
        case UIViewAnimationCurveLinear:
            return UIViewAnimationOptionCurveLinear;
            break;
    }
    
    return kNilOptions;
}


+(void)saveImageToDocWith:(NSString *)path WithImage:(UIImage *)image
{
    NSData *data;
    
    if (UIImagePNGRepresentation(image) == nil) {
        
        data = UIImageJPEGRepresentation(image, 1);
        
    } else {
        
        data = UIImagePNGRepresentation(image);
        
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString * string = [NSString stringWithFormat:@"/%@",path];
    
    NSString * thePath = [[ZSNApi docImagePath] stringByAppendingString:string];
    
    [fileManager createFileAtPath:thePath  contents:data attributes:nil];
}

+(void)deleteDocFileWith:(NSMutableArray *)fileNames
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        for (NSString * fileName in fileNames)
        {
            NSString * string = [NSString stringWithFormat:@"%@/%@",[ZSNApi docImagePath],fileName];
            
            [[NSFileManager defaultManager] removeItemAtPath:string error:nil];
        }
    });
}


+(NSString *)docImagePath
{
    NSString * path1 = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp/imagedata"];
    [[NSFileManager defaultManager] createDirectoryAtPath:path1 withIntermediateDirectories:YES attributes:nil error:nil];
    
    return path1;
}

#pragma mark - 弹出提示框
+ (MBProgressHUD *)showMBProgressWithText:(NSString *)text addToView:(UIView *)aView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 15.f;
    hud.yOffset = 0.0f;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (void)showAutoHiddenMBProgressWithText:(NSString *)text addToView:(UIView *)aView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:aView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 15.f;
    hud.yOffset = 0.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
}

///字符串编码
+(NSString *)encodeToPercentEscapeString: (NSString *) input
{
    if (input.length == 0 || input == nil)
    {
        return @"";
    }
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    NSString *outputStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                (CFStringRef)input,
                                                                                                NULL,
                                                                                                (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                kCFStringEncodingUTF8));
    return outputStr;
}
///字符串解码
+(NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    if (input.length == 0 || input == nil)
    {
        
        
        return @"";
    }
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


#pragma mark - 解码特殊字符
+(NSString *)decodeSpecialCharactersString:(NSString *)input
{
    input = [input stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    input = [input stringByReplacingOccurrencesOfString:@"quot;" withString:@"\""];
    input = [input stringByReplacingOccurrencesOfString:@"&#039;" withString:@"'"];
    input = [input stringByReplacingOccurrencesOfString:@"&lt;" withString:@"&lt"];
    input = [input stringByReplacingOccurrencesOfString:@"&gt;" withString:@"&gt"];
    
    input = [input stringByReplacingOccurrencesOfString:@"<" withString:@"&lt"];
    input = [input stringByReplacingOccurrencesOfString:@">" withString:@"&gt"];
    return input;
}

#pragma mark - 特殊字符编码
+(NSString *)encodeSpecialCharactersString:(NSString *)input
{
    input = [input stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    input = [input stringByReplacingOccurrencesOfString:@"\"" withString:@"quot;"];
    input = [input stringByReplacingOccurrencesOfString:@"'" withString:@"&#039;"];
    input = [input stringByReplacingOccurrencesOfString:@"<" withString:@"&lt"];
    input = [input stringByReplacingOccurrencesOfString:@">" withString:@"&gt"];
    return input;
}
#pragma mark - 特殊字符编码转换成特殊字符
+(NSString *)ddecodeSpecialCharactersStringWith:(NSString *)input
{
    input = [input stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    input = [input stringByReplacingOccurrencesOfString:@"quot;" withString:@"\""];
    input = [input stringByReplacingOccurrencesOfString:@"&#039;" withString:@"'"];
    input = [input stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    input = [input stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    return input;
}


#pragma mark - ios7计算字符串高度
+(float)returnLabelHeightForIos7:(NSString *)content WIthFont:(float)aFont WithWidth:(float)aWidth
{
   CGRect rectr = [content boundingRectWithSize:CGSizeMake(aWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:aFont]} context:nil];
    return rectr.size.height;
}

#pragma mark - 数组排序
+(NSArray *)sortArrayWith:(NSArray *)array
{
    //给keys排序降序
    NSMutableArray *arr11 = [[NSMutableArray alloc]init];
    for (int i=0; i<array.count; i++)
    {
        [arr11 addObject:[NSNumber numberWithInt:[[array objectAtIndex: i] intValue]]];
    }
    
    NSArray * arr1 = [NSArray arrayWithArray:arr11];
    arr1=  [ arr1 sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
            {
                return [obj2 compare:obj1];
            } ];
    
    return arr1;
}



@end









































