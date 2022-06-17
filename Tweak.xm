@interface AWEShareLinkModel
-(NSString *)parsedURL:(NSString *)fullURL;
@end

NSString* fullURLShared;

%hook AWEShareLinkModel
-(void)setTextForCopy:(id)arg1 {
	NSLog(@"omriku link is: %@", arg1);
	//NSString* fullURL;
	if ([(NSString*)arg1 containsString:@"www.tiktok.com"]) {
		fullURLShared = [self parsedURL:arg1];
	}
	%orig(fullURLShared);
}
-(void)setTextFormatForCopy:(id)arg1 {
	NSLog(@"omriku link2 is: %@", arg1);
	NSString* stam = @"asd";
	%orig(stam);
}

%new
-(NSString *)parsedURL:(NSString *)fullURL {
	
	NSRange  searchedRange = NSMakeRange(0, [fullURL length]);
	NSString *pattern = @"(.+?(?=\\\?))";
	NSError  *error = nil;
	NSLog(@"omriku pattern.. %@ and full url: %@", pattern, fullURL);
	NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
	NSArray* matches = [regex matchesInString:fullURL options:0 range: searchedRange];
	for (NSTextCheckingResult* match in matches) {
		//exit(0);
		NSString* matchText = [fullURL substringWithRange:[match range]];
		NSRange group1 = [match rangeAtIndex:1];
		NSLog(@"omriku 1: %@, omriku 2 %@", matchText,[fullURL substringWithRange:group1]);
		return [fullURL substringWithRange:group1];
	}
	return nil;
}
%end
 
 %hook AWESharePlatformChannel
 -(void)prepareBeforeSharing:(id)arg1 {
	 NSLog(@"omriku arg.. %@", arg1);
	 %orig(arg1);
 }
 %end
/*
%hook CKSMSComposeRemoteViewController
-(void)smsComposeControllerSendStartedWithText:(id)arg1 {
	NSLog(@"omriku composing sms? :%@", arg1);
	NSString *stam = @"smsstam";
	%orig(stam);
}
%end

%hook CKSMSComposeController
-(void)setContentText:(id)arg1 {
	NSLog(@"omriku composing sms? :%@", arg1);
	NSString *stam = @"smsstam";
	%orig(stam);
}
-(void)smsComposeControllerSendStartedWithText:(id)arg1 {
	NSLog(@"omriku composing sms? :%@", arg1);
	NSString *stam = @"smsstam";
	%orig(stam);
}
-(void)smsComposeControllerShouldSendMessageWithText:(id)arg1 toRecipients:(id)arg2 completion:(id)arg3 {
	NSLog(@"omriku composing sms? :%@", arg1);
	NSString *stam = @"smsstam";
	arg1 = stam;
	%orig(arg1,arg2,arg3);
}
%end
*/