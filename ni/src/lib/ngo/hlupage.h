/*
 *      $Id: hlupage.h,v 1.5 1998-12-16 23:51:36 dbrown Exp $
 */
/************************************************************************
*									*
*			     Copyright (C)  1996			*
*	     University Corporation for Atmospheric Research		*
*			     All Rights Reserved			*
*									*
************************************************************************/
/*
 *	File:		hlupage.h
 *
 *	Author:		David I. Brown
 *			National Center for Atmospheric Research
 *			PO 3000, Boulder, Colorado
 *
 *	Date:		Wed Jun 18 17:11:05 MDT 1997
 *
 *	Description:	
 */
#ifndef	_NG_HLUPAGE_H
#define	_NG_HLUPAGE_H

#include <ncarg/ngo/go.h>
#include <ncarg/ngo/datasourcegrid.h>
#include <ncarg/ngo/restree.h>

#ifndef _NCL_H_
#include <ncarg/ncl/defs.h>
#include <ncarg/ncl/NclDataDefs.h>
#include <ncarg/ncl/ApiRecords.h>
#include <ncarg/ncl/NclApi.h>
#define _NCL_H_
#endif

#include <ncarg/ngo/datasourcegrid.h>

typedef struct _NgHluPage
{
        NhlString class_name;
        NgDataProfileRec data_prof;
	NhlString plot_style;
	NhlString plot_style_dir;
} NgHluPage;
        
#endif	/* _NG_HLUPAGE_H */
