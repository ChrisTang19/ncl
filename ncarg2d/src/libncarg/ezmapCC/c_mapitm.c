/*
 *	$Id: c_mapitm.c,v 1.1 2001-10-10 02:51:20 haley Exp $
 */
/************************************************************************
*                                                                       *
*                Copyright (C)  2000                                    *
*        University Corporation for Atmospheric Research                *
*                All Rights Reserved                                    *
*                                                                       *
* This file is free software; you can redistribute it and/or modify     *
* it under the terms of the GNU General Public License as published     *
* by the Free Software Foundation; either version 2 of the License, or  *
* (at your option) any later version.                                   *
*                                                                       *
* This software is distributed in the hope that it will be useful, but  *
* WITHOUT ANY WARRANTY; without even the implied warranty of            *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU     *
* General Public License for more details.                              *
*                                                                       *
* You should have received a copy of the GNU General Public License     *
* along with this software; if not, write to the Free Software         *
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307   *
* USA.                                                                  *
*                                                                       *
************************************************************************/

#include <ncarg/ncargC.h>

extern void NGCALLF(mapitm,MAPITM)(float*,float*,int*,int*,float*,float*,
                                   int*,int*,int*,int*,int (*lpr_)());

void c_mapitm 
#ifdef NeedFuncProto
(
    float xlat,
    float xlon,
    int ifst,
    int *iam,
    float *xcs,
    float *ycs,
    int mcs,
    int *iai,
    int *iag,
    int mai,
    int (*lpr_)(
        float *xcs,
        float *ycs,
        int *ncs,
        int *iai,
        int *iag,
        int *nai
            )
)
#else
 (xlat,xlon,ifst,iam,xcs,ycs,mcs,iai,iag,mai,lpr_)
    float xlat;
    float xlon;
    int ifst;
    int *iam;
    float *xcs;
    float *ycs;
    int mcs;
    int *iai;
    int *iag;
    int mai;
    int (*lpr_)();
#endif
{
    NGCALLF(mapitm,MAPITM)(&xlat,&xlon,&ifst,iam,xcs,ycs,&mcs,iai,iag,&mai,
                           lpr_);
}
