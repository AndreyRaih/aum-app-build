#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ShadePlayer.h"
#import "SoundPlayer.h"
#import "SoundRecorder.h"
#import "Sounds.h"
#import "Track.h"

FOUNDATION_EXPORT double soundsVersionNumber;
FOUNDATION_EXPORT const unsigned char soundsVersionString[];

