.\"
.\"	$Id: xwdtohdf.m,v 1.6 1992-12-01 23:21:43 clyne Exp $
.\"
.TH XWDTOHDF 1NCARG "February 1990" NCARG "NCARG GRAPHICS"
.SH NAME
xwdtohdf \- Filter to convert from X11 raster file to hdf format.
.SH SYNOPSIS
.B xwdtohdf
.RB [ " \-o"
.IR "hdf_file " ]
[ 
.BR - ( c | r )
]
[ 
.B \-V
]
.RI [ " xdump_file " ".\|.\|." ]
.SH DESCRIPTION
.LP
.B xwdtohdf
will accept any number of input X11 raster files and convert them to
hdf format. By default
.B xwdtohdf 
reads from standard input. The default output file is 
.I ncar.hdf
.SH OPTIONS
.TP
.BI \-o " hdf_file"
Change the default output file to 
.IR hdf_file .
.TP
.B \-c
Compress the output.
.TP
.B \-r
Use run length encoding for data.
.TP
.B \-V
Print the version number and then exit.
.SH "SEE ALSO"
.BR xwd (1),
.BR xwud (1)
.br
.ne 5
.SH BUGS/CAVEATS
.LP
.B xwdtohdf 
does not support direct or true color encodings of X11 raster files. Nor 
does it accept color tables with greater than 256 entries.
