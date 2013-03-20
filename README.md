# Edir

Easily "edit" a directory in your editor.

## Installation

~~~
$ git clone ...
$ bundle
$ rake install
~~~

## Usage

~~~
$ edir
~~~

Presents an `ls` listing of the current directory in your `$EDITOR`. You 
can then edit this listing to what you want the directory contents to 
look like and save. Then, `edir` will use the differences to make those 
changes.

* Remove lines and those files will be deleted
* Change a line's filename to rename that file
* Duplicate a line and change its name to copy that file

## WARNING

This is a **prototype**. I take no responsibility if it deletes files 
unexpectedly.

## Existing tools

I'm pretty sure there are already editor-specific plugins that do this 
and then some. Vim's own file explore has a few commands to manipulate 
the file under cursor. However, I'm not sure of anything that provides 
this functionality in an editor-agnostic way. Regardless, it was (and 
is) fun to hack on.

## Upcoming

* Options like `--dry-run`, `--verbose`, etc
* Ability to pass additional options to the `ls` command
* See edits to permissions and ownership fields and execute the proper 
  `chmod` or `chown` commands
