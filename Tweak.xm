#import <Foundation/Foundation.h>

@interface AWEShareLinkModel
-(NSString *)parsedURL:(NSString *)fullURL;
@end

NSString* fullURLShared;

%hook AWEShareLinkModel
-(void)setTextForCopy:(id)arg1 {
	if ([(NSString*)arg1 containsString:@"@"]) {
		fullURLShared = [self parsedURL:arg1];
	}
	%orig(fullURLShared);
}

%new
-(NSString *)parsedURL:(NSString *)fullURL {
	
	NSRange  searchedRange = NSMakeRange(0, [fullURL length]);
	NSString *pattern = @"(.+?(?=\\\?))";
	NSError  *error = nil;
	NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
	NSArray* matches = [regex matchesInString:fullURL options:0 range: searchedRange];
	for (NSTextCheckingResult* match in matches) {
		NSString* matchText = [fullURL substringWithRange:[match range]];
		NSRange group1 = [match rangeAtIndex:1];
		return [fullURL substringWithRange:group1];
	}
	return nil;
}
%end