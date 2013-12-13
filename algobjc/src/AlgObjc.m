
#import <Foundation/Foundation.h>

#import "AlgObjc.h"

NSString *AOVersionString()
{
    return [NSString stringWithFormat:@"%d.%d.%d", AO_VERSION_MAJOR, AO_VERSION_MINOR, AO_VERSION_PATCH];
}
