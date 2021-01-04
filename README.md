# NetCopy

## Utility for copying files from one location to another, but was overwrites NEWER files with OLDER, and delete new created files.

1. Check files list, copy all unexisted files from 'SouceFolderName' to 'DestFolderName'.
2. Replace newer files in 'DestFolderName' with **older** files from 'SouceFolderName'. !!!OWERWITES NEWER FILES WITH OLDER!!!
3. Remove all unexisted in 'DestFolderName', for matching file list with 'SouceFolderName'


> Usage from command line:
> 
> **CopyReplaceNewerWithOlder.exe "SouceFolderName" "DestFolderName" -wait|-nowait -textout|-notextout**
> 
> >    - "SouceFolderName" - Source folder name with full path, can be local network location
> >       - "C:\temp\MSO2007"
> >       - "\\10.99.129.64\c$\temp\MSO2007"
> 
> >    - "DestFolderName" - Destibation folder name with full path, [can be local network location] (not tested)  
> 
> >    - -wait|-nowait - Wait or not after all operation completed
> 
> >    - -textout|-notextout - Out text information into console or not

___See Win32\Release folder for .bat sample___
