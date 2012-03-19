#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BBWeeAppController-Protocol.h"

#define VIEW_HEIGHT 28.0f

@interface UIApplication (theiostream)
- (void)applicationOpenURL:(id)url;
@end

@interface UIDevice (theiostream)
- (BOOL)isWildcat;
@end

@interface StatusGoogleController : NSObject <BBWeeAppController, UITextFieldDelegate>
{
	UIView *_view;
	UITextField *searchField;
}

@end

@implementation StatusGoogleController

- (id)init
{
	if ((self = [super init]))
	{
		
	}
	return self;
}

- (void)dealloc {
	[_view release];
	[super dealloc];
}

- (UIView *)view
{
	if (!_view)
	{
	_view = [[UIView alloc] initWithFrame:CGRectMake(2.0f, 0.0f, 316.0f, VIEW_HEIGHT)];

	UIImage *bgImg = [[UIImage imageWithContentsOfFile:@"/System/Library/WeeAppPlugins/StatusGoogle.bundle/WeeAppBackground.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:71];
    UIImageView *bg = [[UIImageView alloc] initWithImage:bgImg];
    bg.frame = [[UIDevice currentDevice] isWildcat] ? CGRectMake(40.0f, 0.0f, 395.0f, VIEW_HEIGHT) : CGRectMake(4.0f, 0.0f, 316.0f, VIEW_HEIGHT); //450 = x on teh iPad
    
    CGRect frame = [[UIDevice currentDevice] isWildcat] ? CGRectMake(45.0f, 0.0f, 390.0f, VIEW_HEIGHT) : CGRectMake(4.0f, 0.0f, 316.0f, VIEW_HEIGHT);
	searchField = [[UITextField alloc] initWithFrame:frame];
	searchField.placeholder = @"Search here!";
	searchField.textColor = [UIColor whiteColor];
	searchField.textAlignment = UITextAlignmentCenter;
	searchField.delegate = self;
	
	[_view addSubview:searchField];
	[_view addSubview:bg];
    [bg release];
	[searchField release];
	}

	return _view;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[searchField resignFirstResponder];
        // stolen from SpotURL by FilippoBiga!
	NSString *str = [NSString stringWithFormat:@"http://www.google.com/search?q=%@&ie=utf-8&oe=utf-8", [searchField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSArray *keys = [[NSArray alloc] initWithObjects:@"http://",@"https://",@"www.",@".com",@".net",@".org",@".us",@".me",@".it",@".uk",@".de",nil];
        for (NSString *k in keys) {
        	if ([searchField.text rangeOfString:k].location != NSNotFound) {
        		if ([searchField.text hasPrefix:@"http://"]) str = searchField.text;
        		else str = [NSString stringWithFormat:@"http://%@", searchField.text];
        	}
	}
	[[UIApplication sharedApplication] applicationOpenURL:[NSURL URLWithString:str]];
	[keys release];
	[str release];
	searchField.text = nil;
	return YES;
}

- (float)viewHeight
{
	return VIEW_HEIGHT;
}

@end
