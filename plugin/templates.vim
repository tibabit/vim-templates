
" disabled plugin cache for now so that it can be sourced each time
" if exists("g:vt_plugin_loaded")
"     finish
" endif
" 
" let g:vt_plugin_loaded = 1

" Templates
" TIMESTAMP:    DAY, DAY_FULL DATE, MONTH, MONTH_SHORT, MONTH_FULL,
"               YEAR, TODAY, TIME, TIME_12, TIMESTAMP
" AUTHOR:       NAME, HOSTNAME, EMAIL
" FILE:         FILE, FILE_EXT, FILE_FULL
" PROJECT:      PROJECT
" LICENSE:      LICENSE, LICENSE_FILE, COPYRIGHT
" COMPANY:      COMAPNY
" CURSOR:       CURSOR

function <SID>EscapeTemplate(tmpl)
    return escape(a:tmpl, "/")
endfunction

function <SID>ExpandTemplate(tmpl, value)
    silent! execute "%s/%". <SID>EscapeTemplate(a:tmpl) ."%/". <SID>EscapeTemplate(a:value) ."/gI"
endfunction

function <SID>ExpandTimestampTemplates()
    let l:day               = strftime("%a")
    let l:day_full          = strftime("%A")
    let l:date              = strftime("%d")
    let l:month             = strftime("%m")
    let l:month_short       = strftime("%b")
    let l:month_full        = strftime("%B")
    let l:year              = strftime("%Y")
    let l:today             = strftime("%d/%m/%Y")
    let l:time              = strftime("%T %Z")
    let l:time_12           = strftime("%r")
    let l:timestamp         = strftime("%A %b %d, %Y %T %Z")

    call <SID>ExpandTemplate("DAY", l:day)
    call <SID>ExpandTemplate("DAY_FULL", l:day_full)
    call <SID>ExpandTemplate("DATE", l:date)
    call <SID>ExpandTemplate("MONTH", l:month)
    call <SID>ExpandTemplate("MONTH_SHORT", l:month_short)
    call <SID>ExpandTemplate("MONTH_FULL", l:month_full)
    call <SID>ExpandTemplate("YEAR", l:year)
    call <SID>ExpandTemplate("TODAY", l:today)
    call <SID>ExpandTemplate("TIME", l:time)
    call <SID>ExpandTemplate("TIME_12", l:time_12)
    call <SID>ExpandTemplate("TIMESTAMP", l:timestamp)
endfunction

function <SID>ExpandAuthoringTemplate()

    let g:tmpl_author_email = "vikash@gmail.com"

    let l:author_name = exists("g:tmpl_author_name") ? g:tmpl_author_name : expand("$USER")
    let l:author_hostname = exists("g:tmpl_author_hostname") ? g:tmpl_author_name : expand("$HOSTNAME")
    let l:author_email = exists("g:tmpl_author_email") ? g:tmpl_author_email :
                \ expand("$USER") ."@". expand("$HOSTNAME")

    call <SID>ExpandTemplate("NAME", l:author_name)
    call <SID>ExpandTemplate("HOSTNAME", l:author_hostname)
    call <SID>ExpandTemplate("EMAIL", l:author_email)
endfunction

function <SID>ExpandAllTemplates()
    call <SID>ExpandTimestampTemplates()
    call <SID>ExpandAuthoringTemplate()
endfunction


" Define commands
command -nargs=0 TmpltExpand         :call <SID>ExpandAllTemplates()
