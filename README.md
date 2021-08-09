# vim-templates ([vimawesome](http://vimawesome.com/plugin/vim-templates-are-made-of))

Create files from predefined templates. Templates are files with `.template` extension.

## Installation

### Vundle

```vim
Plugin 'tibabit/vim-templates'
```

### vim-plug

```vim
Plug 'tibabit/vim-templates'
```

## Usage

### Using default templates

- `TemplateInit` - Takes 0 or 1 argument, initializes file with the template and expands all placeholders defined in the template.
  The argument provided can be either the name of the template file, in most cases the extension of the file, but it can be anything. e.g. you can define template for all java files in java.template and you can define template for Program.java in Program.java.template or for Makefile in Makefile.template. (e.g. `:TemplateInit cpp`, `:TemplateInit main.cpp`)
  If no argument is provided filename and extension is extracted from file name (e.g. `:TemplateInit`).

> **NOTE**: All file names are case sensitive.

- `TemplateExpand`-  Does not take any argument, expands all the placeholders present in file.
  Helpful for updating an existing file

### Auto initialization

By default auto initialization is set to true, so whenever a new file is created,
the file is automatically initialized if a template matches (**for file name or file extension, since file name is more specific, it is given priority over file extension**).
This can be disabled by setting `g:tmpl_auto_initialize` to `0` in your `.vimrc`.

## Customization

### Creating your own templates

- Create a file `<template_name>.template` inside a folder which is searched
  by the plugin( [see below](#search-paths)),
  e.g. if you want to create a template file for a c++ main file you
  can name it `cppmain.template` or `cppm.template`
- Open the file and edit, for example

h.template

```cpp
/**
 * @author      : {{NAME}} ({{EMAIL}})
 * @created     : {{TODAY}}
 * @filename    : {{FILE}}
 */
#ifndef {{MACRO_GUARD}}
#define {{MACRO_GUARD}}

/* declarations */

#endif /* {{MACRO_GUARD}} */
```

generates this for a file named **header.h**

```cpp
/**
 * @author      : Vikas Kesarwani (vikash@abc.com)
 * @created     : 07/09/2018
 * @filename    : header
 */

#ifndef HEADER_H
#define HEADER_H

/* declarations */

#endif /* HEADER_H */
```

- `{{NAME}}`, `{{EMAIL}}`, `{{FILE}}` and `{{TODAY}}`
defined above are placeholders, which are expanded as soon as you call
``:TemplateExpand``.
- In a new file type ``:TemplateInit cppmain`` to both place the above
  content inside the file and expand the placeholders.
- If templte file name (after removing `.template` from file name) matches the current file name or extension it is automatically imported and expnded when you create a new file.
- You can also use `TemplateAutoInit` vim command to import and expand templates. This command will insert and expand the template at line below the cursor.

### Search paths

The plugin searches for templates as follows

1. In folders named `templates` recursively up the directory tree,
   i.e. first in a directory `templates` under the current working
   directory, then in `../templates`, then '../../templates', ...
2. In search paths defined by `g:tmpl_search_paths` in your `.vimrc` file
3. The `templates` folder in this plugin's directory

If you want to add a custom directory to the search path,
e.g. if you placed them inside a ``templates`` directory under ``$HOME`` then
add the following line in your ``.vimrc`` file:

```vim
let g:tmpl_search_paths = ['~/templates']
```

### Configuring the placeholder values

- The values into which certain placeholders expand may be influenced
  by settings in your `.vimrc`. For example `PROJECT` expands into the
  value of the variable `g:tmpl_project`. For more details see the
  list below.
- Other than that the expansion may also be influenced on a per-directory basis.
  If a matching template file is found in one of the directories of the
  search path, the plugin also checks whether a file called `tmpl_settings.vim`
  exists in the *same* directory. Note, than *no other* search directories
  are checked.
  If this is the case all its settings take preference over the ``.vimrc``
- For example: In general you want the placeholder ``EMAIL`` to expand to
  ``john.doe@example.com`` in your templates, hence you place

  ```vim
  let g:tmpl_author_email = 'john.doe@example.com'
  ```

  in your ``.vimrc``.
  In the projects inside the folder `$HOME/my_cool_stuff`, however,
  you want your templates to show the email address ``johns_projects@example.com``.
  So inside ``$HOME/templates`` you place a file ``$HOME/my_cool_stuff/tmpl_settings.vim``
  with content

  ```vim
  let g:tmpl_author_email = 'johns_projects@example.com'
  ```

  and all template files in ``$HOME/my_cool_stuff`` will now have `EMAIL`
  expanding to the latter value.

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
- `FILED` : Absolute path of the file's parent directory `/path/to/directory`
- `FILEP` : The file's parent directory `/path/to/directory -> directory`
- `FILERD` : Directory relative to the current directory (pwd)`/relative/to/`

#### License and Copyright

- `LICENSE` : License of the project, `g:tmpl_license`, default : `MIT`
- `LICENSE_FILE` : Reads lincese from license file onto the next line, `g:tmpl_license_file`. If no file path is provided then file is read in following order-
  - LICENSE
  - LICENSE.txt
  - LICENSE.md
  - license.txt
  - license.md
- `COPYRIGHT` : Copyright message, `g:tmpl_copyright`, default : `Copyright (c) g:tmpl_company`

### Others

- `PROJECT` : Name of the project, `g:tmpl_project`, default: not expanded
- `COMPANY` : Name of the company, `g:tmpl_company`, default: not expanded
- `MACRO_GUARD` : Macro guard for use in c/c++ files. `filename.h -> FILENAME_H`. All dots(.) and dashes (-) present in filename are converted into underscores (_).
- `MACRO_GUARD_FULL` : Same as `MACRO_GUARD`, except relative path is used in place of file name. e.g. `relative/to/filename.h -> RELATIVE_TO_FILENAME_H`
- `CLASS` : class name, same as `FILE`
- `CAMEL_CLASS` : class name converted to camel case `long_file_name.txt -> LongFileName`
- `SNAKE_CLASS` : class name converted to snake case `LongFileName.txt -> long_file_name`
- `CURSOR` : This is a spacial placeholder, it does not expand into anything but the cursor is placed at this location after the template expansion
