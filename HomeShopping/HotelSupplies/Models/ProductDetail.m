//
//  ProductDetail.m
//
//  Created by sooncong  on 15/12/31
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ProductDetail.h"
#import "Comments.h"


NSString *const kProductCoinreturn = @"coinreturn";
NSString *const kProductIshavetv = @"ishavetv";
NSString *const kProductCoordinatey = @"coordinatey";
NSString *const kProductLogo = @"logo";
NSString *const kProductCoordinatex = @"coordinatex";
NSString *const kProductIshaveac = @"ishaveac";
NSString *const kProductIshavepc = @"ishavepc";
NSString *const kProductComments = @"comments";
NSString *const kProductAddress = @"address";
NSString *const kProductIshavewifi = @"ishavewifi";
NSString *const kProductProductid = @"productid";
NSString *const kProductScore = @"score";
NSString *const kProductSellername = @"sellername";
NSString *const kProductCityname = @"cityname";
NSString *const kProductIsneedbook = @"isneedbook";
NSString *const kProductTurnover = @"turnover";
NSString *const kProductDistance = @"distance";
NSString *const kProductSellerlogo = @"sellerlogo";
NSString *const kProductCommentcount = @"commentcount";
NSString *const kProductPrice = @"price";
NSString *const kProductProducttype = @"producttype";
NSString *const kProductNormintro = @"normintro";
NSString *const kProductImagelist = @"imagelist";
NSString *const kProductServicephone = @"servicephone";
NSString *const kProductNorms = @"norms";
NSString *const kProductCoinprice = @"coinprice";
NSString *const kProductCitycode = @"citycode";
NSString *const kProductShortintro = @"shortintro";
NSString *const kProductTitle = @"title";
NSString *const kProductStarlevel = @"starlevel";
NSString *const kProductPackafserv = @"packafserv";
NSString *const kProductIsspecial = @"isspecial";
NSString *const kProductSellerscore = @"sellerscore";
NSString *const kProductLongintro = @"longintro";
NSString *const kProductSellerid = @"sellerid";


@interface ProductDetail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ProductDetail

@synthesize coinreturn = _coinreturn;
@synthesize ishavetv = _ishavetv;
@synthesize coordinatey = _coordinatey;
@synthesize logo = _logo;
@synthesize coordinatex = _coordinatex;
@synthesize ishaveac = _ishaveac;
@synthesize ishavepc = _ishavepc;
@synthesize comments = _comments;
@synthesize address = _address;
@synthesize ishavewifi = _ishavewifi;
@synthesize productid = _productid;
@synthesize score = _score;
@synthesize sellername = _sellername;
@synthesize cityname = _cityname;
@synthesize isneedbook = _isneedbook;
@synthesize turnover = _turnover;
@synthesize distance = _distance;
@synthesize sellerlogo = _sellerlogo;
@synthesize commentcount = _commentcount;
@synthesize price = _price;
@synthesize producttype = _producttype;
@synthesize normintro = _normintro;
@synthesize imagelist = _imagelist;
@synthesize servicephone = _servicephone;
@synthesize norms = _norms;
@synthesize coinprice = _coinprice;
@synthesize citycode = _citycode;
@synthesize shortintro = _shortintro;
@synthesize title = _title;
@synthesize starlevel = _starlevel;
@synthesize packafserv = _packafserv;
@synthesize isspecial = _isspecial;
@synthesize sellerscore = _sellerscore;
@synthesize longintro = _longintro;
@synthesize sellerid = _sellerid;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.coinreturn = [self objectOrNilForKey:kProductCoinreturn fromDictionary:dict];
        self.ishavetv = [self objectOrNilForKey:kProductIshavetv fromDictionary:dict];
        self.coordinatey = [self objectOrNilForKey:kProductCoordinatey fromDictionary:dict];
        self.logo = [self objectOrNilForKey:kProductLogo fromDictionary:dict];
        self.coordinatex = [self objectOrNilForKey:kProductCoordinatex fromDictionary:dict];
        self.ishaveac = [self objectOrNilForKey:kProductIshaveac fromDictionary:dict];
        self.ishavepc = [self objectOrNilForKey:kProductIshavepc fromDictionary:dict];
        NSObject *receivedComments = [dict objectForKey:kProductComments];
        NSMutableArray *parsedComments = [NSMutableArray array];
        if ([receivedComments isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedComments) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedComments addObject:[Comments modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedComments isKindOfClass:[NSDictionary class]]) {
            [parsedComments addObject:[Comments modelObjectWithDictionary:(NSDictionary *)receivedComments]];
        }
        
        self.comments = [NSArray arrayWithArray:parsedComments];
        self.address = [self objectOrNilForKey:kProductAddress fromDictionary:dict];
        self.ishavewifi = [self objectOrNilForKey:kProductIshavewifi fromDictionary:dict];
        self.productid = [self objectOrNilForKey:kProductProductid fromDictionary:dict];
        self.score = [self objectOrNilForKey:kProductScore fromDictionary:dict];
        self.sellername = [self objectOrNilForKey:kProductSellername fromDictionary:dict];
        self.cityname = [self objectOrNilForKey:kProductCityname fromDictionary:dict];
        self.isneedbook = [self objectOrNilForKey:kProductIsneedbook fromDictionary:dict];
        self.turnover = [self objectOrNilForKey:kProductTurnover fromDictionary:dict];
        self.distance = [self objectOrNilForKey:kProductDistance fromDictionary:dict];
        self.sellerlogo = [self objectOrNilForKey:kProductSellerlogo fromDictionary:dict];
        self.commentcount = [self objectOrNilForKey:kProductCommentcount fromDictionary:dict];
        self.price = [self objectOrNilForKey:kProductPrice fromDictionary:dict];
        self.producttype = [self objectOrNilForKey:kProductProducttype fromDictionary:dict];
        self.normintro = [self objectOrNilForKey:kProductNormintro fromDictionary:dict];
        self.imagelist = [self objectOrNilForKey:kProductImagelist fromDictionary:dict];
        self.servicephone = [self objectOrNilForKey:kProductServicephone fromDictionary:dict];
        self.norms = [self objectOrNilForKey:kProductNorms fromDictionary:dict];
        self.coinprice = [self objectOrNilForKey:kProductCoinprice fromDictionary:dict];
        self.citycode = [self objectOrNilForKey:kProductCitycode fromDictionary:dict];
        self.shortintro = [self objectOrNilForKey:kProductShortintro fromDictionary:dict];
        self.title = [self objectOrNilForKey:kProductTitle fromDictionary:dict];
        self.starlevel = [self objectOrNilForKey:kProductStarlevel fromDictionary:dict];
        self.packafserv = [self objectOrNilForKey:kProductPackafserv fromDictionary:dict];
        self.isspecial = [self objectOrNilForKey:kProductIsspecial fromDictionary:dict];
        self.sellerscore = [self objectOrNilForKey:kProductSellerscore fromDictionary:dict];
        self.longintro = [self objectOrNilForKey:kProductLongintro fromDictionary:dict];
        self.sellerid = [self objectOrNilForKey:kProductSellerid fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.coinreturn forKey:kProductCoinreturn];
    [mutableDict setValue:self.ishavetv forKey:kProductIshavetv];
    [mutableDict setValue:self.coordinatey forKey:kProductCoordinatey];
    [mutableDict setValue:self.logo forKey:kProductLogo];
    [mutableDict setValue:self.coordinatex forKey:kProductCoordinatex];
    [mutableDict setValue:self.ishaveac forKey:kProductIshaveac];
    [mutableDict setValue:self.ishavepc forKey:kProductIshavepc];
    NSMutableArray *tempArrayForComments = [NSMutableArray array];
    for (NSObject *subArrayObject in self.comments) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForComments addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForComments addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForComments] forKey:kProductComments];
    [mutableDict setValue:self.address forKey:kProductAddress];
    [mutableDict setValue:self.ishavewifi forKey:kProductIshavewifi];
    [mutableDict setValue:self.productid forKey:kProductProductid];
    [mutableDict setValue:self.score forKey:kProductScore];
    [mutableDict setValue:self.sellername forKey:kProductSellername];
    [mutableDict setValue:self.cityname forKey:kProductCityname];
    [mutableDict setValue:self.isneedbook forKey:kProductIsneedbook];
    [mutableDict setValue:self.turnover forKey:kProductTurnover];
    [mutableDict setValue:self.distance forKey:kProductDistance];
    [mutableDict setValue:self.sellerlogo forKey:kProductSellerlogo];
    [mutableDict setValue:self.commentcount forKey:kProductCommentcount];
    [mutableDict setValue:self.price forKey:kProductPrice];
    [mutableDict setValue:self.producttype forKey:kProductProducttype];
    [mutableDict setValue:self.normintro forKey:kProductNormintro];
    NSMutableArray *tempArrayForImagelist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.imagelist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForImagelist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForImagelist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForImagelist] forKey:kProductImagelist];
    [mutableDict setValue:self.servicephone forKey:kProductServicephone];
    NSMutableArray *tempArrayForNorms = [NSMutableArray array];
    for (NSObject *subArrayObject in self.norms) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForNorms addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForNorms addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForNorms] forKey:kProductNorms];
    [mutableDict setValue:self.coinprice forKey:kProductCoinprice];
    [mutableDict setValue:self.citycode forKey:kProductCitycode];
    [mutableDict setValue:self.shortintro forKey:kProductShortintro];
    [mutableDict setValue:self.title forKey:kProductTitle];
    [mutableDict setValue:self.starlevel forKey:kProductStarlevel];
    [mutableDict setValue:self.packafserv forKey:kProductPackafserv];
    [mutableDict setValue:self.isspecial forKey:kProductIsspecial];
    [mutableDict setValue:self.sellerscore forKey:kProductSellerscore];
    [mutableDict setValue:self.longintro forKey:kProductLongintro];
    [mutableDict setValue:self.sellerid forKey:kProductSellerid];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.coinreturn = [aDecoder decodeObjectForKey:kProductCoinreturn];
    self.ishavetv = [aDecoder decodeObjectForKey:kProductIshavetv];
    self.coordinatey = [aDecoder decodeObjectForKey:kProductCoordinatey];
    self.logo = [aDecoder decodeObjectForKey:kProductLogo];
    self.coordinatex = [aDecoder decodeObjectForKey:kProductCoordinatex];
    self.ishaveac = [aDecoder decodeObjectForKey:kProductIshaveac];
    self.ishavepc = [aDecoder decodeObjectForKey:kProductIshavepc];
    self.comments = [aDecoder decodeObjectForKey:kProductComments];
    self.address = [aDecoder decodeObjectForKey:kProductAddress];
    self.ishavewifi = [aDecoder decodeObjectForKey:kProductIshavewifi];
    self.productid = [aDecoder decodeObjectForKey:kProductProductid];
    self.score = [aDecoder decodeObjectForKey:kProductScore];
    self.sellername = [aDecoder decodeObjectForKey:kProductSellername];
    self.cityname = [aDecoder decodeObjectForKey:kProductCityname];
    self.isneedbook = [aDecoder decodeObjectForKey:kProductIsneedbook];
    self.turnover = [aDecoder decodeObjectForKey:kProductTurnover];
    self.distance = [aDecoder decodeObjectForKey:kProductDistance];
    self.sellerlogo = [aDecoder decodeObjectForKey:kProductSellerlogo];
    self.commentcount = [aDecoder decodeObjectForKey:kProductCommentcount];
    self.price = [aDecoder decodeObjectForKey:kProductPrice];
    self.producttype = [aDecoder decodeObjectForKey:kProductProducttype];
    self.normintro = [aDecoder decodeObjectForKey:kProductNormintro];
    self.imagelist = [aDecoder decodeObjectForKey:kProductImagelist];
    self.servicephone = [aDecoder decodeObjectForKey:kProductServicephone];
    self.norms = [aDecoder decodeObjectForKey:kProductNorms];
    self.coinprice = [aDecoder decodeObjectForKey:kProductCoinprice];
    self.citycode = [aDecoder decodeObjectForKey:kProductCitycode];
    self.shortintro = [aDecoder decodeObjectForKey:kProductShortintro];
    self.title = [aDecoder decodeObjectForKey:kProductTitle];
    self.starlevel = [aDecoder decodeObjectForKey:kProductStarlevel];
    self.packafserv = [aDecoder decodeObjectForKey:kProductPackafserv];
    self.isspecial = [aDecoder decodeObjectForKey:kProductIsspecial];
    self.sellerscore = [aDecoder decodeObjectForKey:kProductSellerscore];
    self.longintro = [aDecoder decodeObjectForKey:kProductLongintro];
    self.sellerid = [aDecoder decodeObjectForKey:kProductSellerid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_coinreturn forKey:kProductCoinreturn];
    [aCoder encodeObject:_ishavetv forKey:kProductIshavetv];
    [aCoder encodeObject:_coordinatey forKey:kProductCoordinatey];
    [aCoder encodeObject:_logo forKey:kProductLogo];
    [aCoder encodeObject:_coordinatex forKey:kProductCoordinatex];
    [aCoder encodeObject:_ishaveac forKey:kProductIshaveac];
    [aCoder encodeObject:_ishavepc forKey:kProductIshavepc];
    [aCoder encodeObject:_comments forKey:kProductComments];
    [aCoder encodeObject:_address forKey:kProductAddress];
    [aCoder encodeObject:_ishavewifi forKey:kProductIshavewifi];
    [aCoder encodeObject:_productid forKey:kProductProductid];
    [aCoder encodeObject:_score forKey:kProductScore];
    [aCoder encodeObject:_sellername forKey:kProductSellername];
    [aCoder encodeObject:_cityname forKey:kProductCityname];
    [aCoder encodeObject:_isneedbook forKey:kProductIsneedbook];
    [aCoder encodeObject:_turnover forKey:kProductTurnover];
    [aCoder encodeObject:_distance forKey:kProductDistance];
    [aCoder encodeObject:_sellerlogo forKey:kProductSellerlogo];
    [aCoder encodeObject:_commentcount forKey:kProductCommentcount];
    [aCoder encodeObject:_price forKey:kProductPrice];
    [aCoder encodeObject:_producttype forKey:kProductProducttype];
    [aCoder encodeObject:_normintro forKey:kProductNormintro];
    [aCoder encodeObject:_imagelist forKey:kProductImagelist];
    [aCoder encodeObject:_servicephone forKey:kProductServicephone];
    [aCoder encodeObject:_norms forKey:kProductNorms];
    [aCoder encodeObject:_coinprice forKey:kProductCoinprice];
    [aCoder encodeObject:_citycode forKey:kProductCitycode];
    [aCoder encodeObject:_shortintro forKey:kProductShortintro];
    [aCoder encodeObject:_title forKey:kProductTitle];
    [aCoder encodeObject:_starlevel forKey:kProductStarlevel];
    [aCoder encodeObject:_packafserv forKey:kProductPackafserv];
    [aCoder encodeObject:_isspecial forKey:kProductIsspecial];
    [aCoder encodeObject:_sellerscore forKey:kProductSellerscore];
    [aCoder encodeObject:_longintro forKey:kProductLongintro];
    [aCoder encodeObject:_sellerid forKey:kProductSellerid];
}

- (id)copyWithZone:(NSZone *)zone
{
    ProductDetail *copy = [[ProductDetail alloc] init];
    
    if (copy) {
        
        copy.coinreturn = [self.coinreturn copyWithZone:zone];
        copy.ishavetv = [self.ishavetv copyWithZone:zone];
        copy.coordinatey = [self.coordinatey copyWithZone:zone];
        copy.logo = [self.logo copyWithZone:zone];
        copy.coordinatex = [self.coordinatex copyWithZone:zone];
        copy.ishaveac = [self.ishaveac copyWithZone:zone];
        copy.ishavepc = [self.ishavepc copyWithZone:zone];
        copy.comments = [self.comments copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.ishavewifi = [self.ishavewifi copyWithZone:zone];
        copy.productid = [self.productid copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.sellername = [self.sellername copyWithZone:zone];
        copy.cityname = [self.cityname copyWithZone:zone];
        copy.isneedbook = [self.isneedbook copyWithZone:zone];
        copy.turnover = [self.turnover copyWithZone:zone];
        copy.distance = [self.distance copyWithZone:zone];
        copy.sellerlogo = [self.sellerlogo copyWithZone:zone];
        copy.commentcount = [self.commentcount copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.producttype = [self.producttype copyWithZone:zone];
        copy.normintro = [self.normintro copyWithZone:zone];
        copy.imagelist = [self.imagelist copyWithZone:zone];
        copy.servicephone = [self.servicephone copyWithZone:zone];
        copy.norms = [self.norms copyWithZone:zone];
        copy.coinprice = [self.coinprice copyWithZone:zone];
        copy.citycode = [self.citycode copyWithZone:zone];
        copy.shortintro = [self.shortintro copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.starlevel = [self.starlevel copyWithZone:zone];
        copy.packafserv = [self.packafserv copyWithZone:zone];
        copy.isspecial = [self.isspecial copyWithZone:zone];
        copy.sellerscore = [self.sellerscore copyWithZone:zone];
        copy.longintro = [self.longintro copyWithZone:zone];
        copy.sellerid = [self.sellerid copyWithZone:zone];
    }
    
    return copy;
}

@end
