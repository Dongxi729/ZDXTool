//
//  Header.h
//  TestObjc
//
//  Created by 郑东喜 on 2019/9/16.
//  Copyright © 2019 郑东喜. All rights reserved.
//

#ifndef Header_h
#define Header_h

#if DEBUG
#define ZLOG(format, ...) do {\
fprintf(stderr, "-----------------------------------------\n");             \
fprintf(stderr, "File: %s\nFunc: %s\nLine: %d / Time: [%s]\n",         \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__func__, __LINE__, __TIME__);                                              \
fprintf(stderr, "Format:\n %s \n",                                          \
[[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);            \
fprintf(stderr, "-----------------------------------------\n\n");           \
} while (0)

#define _po(o) ZLOG(@"%@", (o))
#define _pn(o) ZLOG(@"%d", (o))
#define _pf(o) ZLOG(@"%f", (o))
#define _ps(o) ZLOG(@"CGSize: {%.0f, %.0f}", (o).width, (o).height)
#define _pr(o) ZLOG(@"CGRect: {{%.0f, %.0f}, {%.0f, %.0f}}", (o).origin.x, (o).origin.y, (o).size.width, (o).size.height)

#define OBJ(obj)  ZLOG(@"%s: %@", #obj, [(obj) description])

#define MARK    ZLOG(@"\nMARK: %s, %d", __PRETTY_FUNCTION__, __LINE__)
#else
#define ZLOG(format, ...) nil
#endif



#endif /* Header_h */
