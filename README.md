# xmlbuilder: A simple way to build XML
This library is very short. All it does is allow you to write XML in a very Ruby-ish way.

## Examples:
This is a basic example:
```
# XMLBuilder is a class that allows you to easily create XML.
# Here's an example:
#   xml = XMLBuilder.new
#   xml.document :type => 'xml', :use => 'example' do
#     xml.description "This is an example of using XMLBuilder.\n" # If you pass in a string, it will automatically input it into
#     xml.nextmeeting :date => Time.now+100000 do                 # the output string. You can't use a block with it, though.
#       xml.agenda "Nothing of importance will be decided.\n"
#       xml.clearance true, :level => :classified # Passing true in as the first parameter will cause it to be a standalone tag.
#     end
#     xml.add "I hope that this has been a good example."
#   end
#   p xml.str
#   <document type="xml" use="example">
#   <description>
#   This is an example of using XMLBuilder.
#   </description>
#   <nextmeeting date="2017-02-10 21:56:56 -0800">
#   <agenda>
#   Nothing of importance will be decided.
#   </agenda>
#   <clearance level="classified" />
#   </nextmeeting>
#   I hope that this has been a good example.
#   </document>
```
**NOTE:** XMLBuilder doesn't indent its output.
[Here](https://rubygems.org/gems/xmlbuilder) is the gem repo.

## Installation
`gem install xmlbuilder`

## License
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
