#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BBWeeAppController-Protocol.h"

#define VIEW_HEIGHT 25.0f

@interface StatusGoogleController : NSObject <BBWeeAppController, UITextFieldDelegate>
{
	UIView *_view;
	UITextField *searchField;
	NSString *google;
	NSString *googleSearch;
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

		UIImage *bgImg = [[UIImage imageWithContentsOfFile:@"/System/Library/WeeAppPlugins/StocksWeeApp.bundle/WeeAppBackground.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:71];
        UIImageView *bg = [[UIImageView alloc] initWithImage:bgImg];
        bg.frame = CGRectMake(0.0f, 0.0f, 316.0f, VIEW_HEIGHT);
        
	searchField = [[UITextField alloc] initWithFrame:CGRectMake(2.0f, 0.0f, 316.0f, VIEW_HEIGHT)];
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
	google = [searchField.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
	googleSearch = [NSString stringWithFormat:@"http://google.com/?q=%@", google];
	NSURL *url = [NSURL URLWithString:googleSearch];
	searchField.text = nil;
	[[UIApplication sharedApplication] applicationOpenURL:url];
	
	return YES; //@Maximus: or return NO?
}

- (float)viewHeight
{
	return VIEW_HEIGHT;
}

@end
