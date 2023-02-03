# MyGlossary

This app is intended to support the creation of a fairly large glossary
of specific terms (with multiple users sharing the work).

<b>Please note:</b> Because of "bit rot," this app currently does not run
(as of 3 Feb 2023). For this reason, there are no screenshots of the views.

Each word (or term or "entry") will always be in one of these
states:

* <tt>unclaimed</tt> - No work has been done on this entry
* <tt>claimed</tt> - Now owned by a specific user
* <tt>in-progress</tt> - Owner has started work
* <tt>draft</tt> - Owner has finished and admin will review
* <tt>completed</tt> - Work finished and reviewed by admin
* <tt>hidden</tt> - The admin has hidden this entry

A user can "claim" an entry (ensuring no conflicts). The typical flow
will be: unclaimed -> claimed -> in-progress -> draft -> completed

The fields for an entry are:

* <tt>word</tt> - The word itself
* <tt>status</tt> - See above
* <tt>user</tt> - The entry owner
* <tt>definition</tt> - The definition (possibly including some metadata?)
* <tt>notes</tt> - Notes intended for admin or other users

What this app needs:

* Updating/cleaning of overall codebase
* (uncertain?) Support for uploading one or more images per term
* A way to import a list of terms into the database
* A way to export terms (honoring the "status")

The plan for embedded metadata is to process these items after export.
The intention is to avoid having too many fields (most of which would
be empty) and to permit future extension without changing the code for
the web app.

A metadata tag begins with an <tt>@</tt> (at the beginning of a line)
followed by arbitrary data on the rest of the line. The tags I envision
so far are:

* <tt>@pronunciation</tt> IPA notation (mostly omitted)
* <tt>@etymology</tt> Word origin (mostly omitted)
* <tt>@aka</tt> "Also known as..." Use if there is a common synonym that is not obvious. Example: <b><tt>@aka wombat</tt></b>
* <tt>@abbr</tt> Give the abbreviation (if any) for this term.  Example: <b><tt>@abbr CMB</tt></b>
* <tt>@expansion</tt> Opposite of <b><tt>@abbr</tt></b>. Give the expansion (if any) for this abbreviated term.  Example: <b><tt>@abbr Cosmic Microwave Background</tt></b>
* <tt>@see</tt> No definition here. Refer to another term instead.  Example: <b><tt>@see Urine dump</tt></b>
* <tt>@see_also</tt> Definition here. But refer also to this other term.  Example: <b><tt>@see_also Apollo 13</tt></b>
* <tt>@compare</tt> Refer to another term that may offer comparison or contrast.  Example: <b><tt>@compare azimuth</tt></b>
* <tt>@alt_sense</tt> A definition representing a different sense or usage of this term.  Example: <b><tt>@alt_sense speed of light (&lt; Latin celeritas)</tt></b>
* <tt>@sources</tt> Source(s) where this information came from.  Example: <b><tt>@sources nasa.gov, wikipedia, my fkn ouija board</tt></b>
* <tt>@image</tt> URL referring to a relevant image file. Use none or many as needed.  Example: <b><tt>@image http://example.com/images/some_pic.jpg</tt></b>
* <tt>@image_credits</tt> Credit the source or copyright of an image. Once per image used. Example: <b><tt>@image_credits Arizona State Univ, 2021</tt></b>

<hr>
<!--
* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
-->
