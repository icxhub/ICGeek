set allitem [glob -nocomplain ./datain/*] ;

# {{{ #mydoc# Define mapping between extension and path
set moveto(doc) "material/doc" ;
set moveto(docx) "material/doc" ;
set moveto(pdf) "material/doc" ;
set moveto(jpg) "material/img" ;
set moveto(png) "material/img" ;
set moveto(gif) "material/img" ;
set moveto(xcf) "material/dgn" ;
set moveto(exe) "material/exe" ;
set moveto(zip) "material/zip" ;
set moveto(7z)  "material/zip" ;
set moveto(rar) "material/zip" ;
set moveto(tar) "material/zip" ;
set moveto(gz) "material/zip" ;
set moveto(folder) "material/sub" ;
set moveto(chm) "material/doc" ;
set moveto(pptx) "material/doc" ;
set moveto(epub) "material/doc" ;
set moveto(csv) "material/doc" ;
set moveto(js) "material/dgn" ;
set moveto(sb2) "material/dgn" ;
set moveto(jfif) "material/img" ;
set moveto(msi) "material/exe" ;
set moveto(crx) "material/exe" ;
set moveto(azw3) "material/doc" ;
set moveto(xlsx) "material/doc" ;
# }}}

#set fh [open sort.cmd w]

foreach itm $allitem {
    set fileext [lindex [split [file extension $itm] .] end] ;
    # #mydoc# If extension does not match, return.
    if {![info exists moveto($fileext)]} {
        puts "No match for $fileext" ;
        continue ;
    }
    # #mydoc# If extension does match, move.
    if {![file exists $moveto($fileext)]} {
        file mkdir $moveto($fileext) ;
    }
    if {![file exists $itm]} {
        puts $itm ;
        continue ;
    }
    # #mydoc# Move both file and folder
    if {[file type $itm]!="file"} {
        exec mv $itm $moveto(folder)/
        #puts $fh [subst { mv $itm $moveto([folder])/ }];
    } else {
        catch {exec mv $itm $moveto($fileext)/}
        #puts $fh [subst { mv $itm $moveto($fileext)/ }] ;
    }
    #close $fh ;
}

# vim: ft=tcl foldmethod=marker