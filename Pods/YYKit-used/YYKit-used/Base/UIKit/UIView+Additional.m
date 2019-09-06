//
//  UIView+Additional.m
//  Pods
//
//  Created by 李永杰 on 2018/8/1.
//

#import "UIView+Additional.h"
#import "YYKit.h"

@implementation UIView (Additional)
- (UIView *)addTxtColor:(UIColor *)textColor
        backgroundColor:(UIColor *)backColor
              labelText:(NSString *)text
          textAlignment:(NSTextAlignment)alignment {
    UILabel *label       = [[UILabel alloc] init];
    label.textColor      = textColor;
    label.font           = [UIFont systemFontOfSize:14];
    label.text           = [NSString stringWithFormat:@"%@", text];
    label.numberOfLines  = 0;
    self.backgroundColor = backColor;

    // 根据字体得到NSString的尺寸
    CGSize lblSize = [label.text boundingRectWithSize:CGSizeMake(kScreenWidth, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{
                                               NSFontAttributeName : [UIFont systemFontOfSize:14]
                                           }
                                              context:nil]
                         .size;
    label.frame         = CGRectMake(0, 12, kScreenWidth, lblSize.height);
    label.textAlignment = alignment;

    [self addSubview:label];

    self.frame = CGRectMake(0, 0, kScreenWidth, lblSize.height + 24);

    return self;
}

- (UIView *)addLineWithY:(CGFloat)originY color:(UIColor *)color height:(CGFloat)height width:(CGFloat)width {
    CGFloat y            = (originY == 0) ? 0 : originY - height;
    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, y, width, height)];
    line.backgroundColor = color;
    [self addSubview:line];
    return line;
}

- (void)drawDashlineWithLength:(int)lineLength
                   lineSpacing:(int)lineSpacing
                     lineColor:(UIColor *)lineColor
                     direction:(UIViewDashLineDirection)direction {

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight(self.frame) / 2.0)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色
    [shapeLayer setStrokeColor:lineColor.CGColor];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    // 设置方向和虚线宽度
    if (direction == UIViewDashLineDirectionHorizontal) {
        [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
        CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame), 0);
    } else {
        [shapeLayer setLineWidth:CGRectGetWidth(self.frame)];
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(self.frame));
    }
    [shapeLayer setPath:path];
    CGPathRelease(path);

    [self.layer addSublayer:shapeLayer];
}

- (void)makeCornerWithrect:(UIRectCorner)rect radius:(CGFloat)radius {
    UIBezierPath *maskPath   = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rect cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer  = [[CAShapeLayer alloc] init];
    maskLayer.frame          = self.bounds;
    maskLayer.path           = maskPath.CGPath;
    self.layer.mask          = maskLayer;
    self.layer.masksToBounds = YES;
}

- (void)shadowWithColor:(UIColor *)color opacity:(float)opacity shadowRadius:(CGFloat)shadowRadius radius:(CGFloat)radius {
    self.layer.shadowColor     = color.CGColor;
    self.layer.shadowOpacity   = opacity;
    self.layer.shadowOffset    = CGSizeMake(0, 0);
    self.layer.shadowRadius    = shadowRadius;
    self.layer.shouldRasterize = NO;
    self.layer.shadowPath      = [[UIBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:0] CGPath];
    self.layer.masksToBounds   = NO;
    self.layer.cornerRadius    = radius;
}

- (void)setBorderWithtop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width {
    if (top) {
        CALayer *layer        = [CALayer layer];
        layer.frame           = CGRectMake(0, 0, self.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer        = [CALayer layer];
        layer.frame           = CGRectMake(0, 0, width, self.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer        = [CALayer layer];
        layer.frame           = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer        = [CALayer layer];
        layer.frame           = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
}

+ (void)setRowSpace:(UILabel *)label lineSpacing:(CGFloat)lineSpacing {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSMutableParagraphStyle *paragraphStyle     = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing]; //调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    label.attributedText = attributedString;
}

@end
