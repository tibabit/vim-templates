# vim-templates
Create files from predefined templates

## Installation
### Vundle
```
Plugin 'tibabit/vim-templates'
```
### vim-plug
```
Plug 'tibabit/vim-templates'
```

# Usage
## Using default templates
- `TemplateInit` - Takes 0 or more arguments, initializes file with the template and expands all placeholders defined in the template.
  The argument provided is the name of the template file, in most cases the extension of the file.
  If no argument is provided file extension is extracted from file name (e.g. ``:TemplateInit cpp``)


- `TemplateExpand`-  Does not take any argument, expands all the placeholders present in file.
  Helpful for updating an existing file

# Customization
## Creating your own templates

- Create a file <template_name>.template. e.g if you want to create a template file for a c++ main file
  you can name it cppmain.template or cppm.template
- Open the file and edit template

```CPP
/**
 * @author		: {{NAME}} ({{EMAIL}})
 * @created		: {{TODAY}}
 * @filename	: {{FILE}}
 */

#include <iostream>

using namespace std;

int main(int argc, char** argv)
{
	return 0;
}
```
- Add template directory to template search path in .vimrc file.
  For example if your template is present in the ``templates`` directory under ``$HOME`` then
  add following line in your ``.vimrc`` file

```
set g:tmpl_search_paths = ['~/templates']
```
- Reopen vim and you are good to go.

**NOTE:** Templates are searched in following order
1. `templates` folder under current working directory
2. search paths defined by g:tmpl_search_paths in .vimrc file
3. `templates` folder in plugin directory

`{{NAME}}`, `{{EMAIL}}`, `{{FILE}}` and `{{TODAY}}`, defined above are placeholders
which are expanded to their default values or as configured in your `.vimrc` file

### Placeholders
The Following placeholders are currently supported by this plugin

#### Date & Time
- `DAY` : Day of the week in short form (Mon, Tue, Wed, etc,)
- `DAY_FULL` : Day of the week in full (Monday, Tueseday, etc.)
- `DATE` : Date of the month (01 to 31)
- `MONTH`: Month of the year (01 to 12)
- `MONTH_SHORT` : Short name of the month (Jan, Feb, Mar, etc.)
- `MONTH_FULL` : Full month name (January, February, etc.)
- `YEAR` : current year (2016)
- `TODAY`: Todays date in dd/mm/yyyy format
- `TIME` : Current time in 24 our format
- `TIME_12` : Current time in 12 hour format
- `TIMESTAMP` : Current Timestamp, e.g.: Sunday Nov 27, 2016 15:33:33 IST 

#### Authoring
- `NAME` : Name of the author, `g:tmpl_author_name`, default : `$USER`
- `HOSTNAME` : Name of the host machine, `g:tmpl_author_hostname`, default : `$HOSTNAME`
- `EMAIL` : Email of the author, `g:tmpl_author_email`, default : `$USER@$HOSTNAME`

#### File name
- `FILE` : Basename of the file `filename.ext -> filename`
- `FILEE` : Filename with extension `filename.ext -> filename.ext`
- `FILEF` : Absolute path of the file `/path/to/directory/filename.ext`
- `FILER` : Filepath relative to the current directory (pwd)`/relative/to/filename.ext`

#### License and Copyright
- `LICENSE` : License of the project, `g:tmpl_license`, default : `MIT`
- `COPYRIGHT` : Copyright message, `g:tmpl_copyright`, default : `Copyright (c) g:tmpl_company`

#### Others
- `PROJECT` : Name of the project, `g:tmpl_project`, default: `''`
- `COMPANY` : Name of the company, `g:tmpl_company`, default: `''`
- `MACRO_GUARD` : Macro guard for use in c/c++ files. `filename.h -> FILENAME_H`. All dots(.) and dashes (-) present in filename are converted into underscores (_).
- `MACRO_GUARD_FULL` : Same as `MACRO_GUARD`, except relative path is used in place of file name. e.g. `relative/to/filename.h -> RELATIVE_TO_FILENAME_H`
- `CLASS` : class name, same as `FILE`
- `CURSOR` : This is a spacial placeholder, it does not expand into anything but the cursor is placed at this location after the template expansion

## Auto initialization
By default auto initialization is set to true, so whenever a new file is created, file is automatically initialized with matching template. However you can dissable it by seting `g:tmpl_auto_initialize` to `0` in your .vimrc file.

