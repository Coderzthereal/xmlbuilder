## This is not the original XmlBuilder library.
It is a separate library that uses a different interface. I did not write the original XmlBuilder gem, whose owner yanked it from rubygems.org in 2012.


# xmlbuilder: A simple way to build XML
This library allows you to generate XML in an idiomatic, human-readable way. It's designed to be easy to use to automatically generate XML on the fly or as needed inside your terminal.

## Examples:
A hard-coded example:
```
xml = XMLBuilder.new
xml.document type: 'xml', use: 'example' do
  xml.description "This is an example of using XMLBuilder."
  xml.nextmeeting date: Time.now+100000 do
    xml.agenda "Nothing of importance will be decided."
    xml.clearance true, level: 'classified'
    # Passing in true creates a void tag
  end
end

p xml.str

# =>
<document type="xml" use="example">
  <description>
    This is an example of using XMLBuilder.
  </description>
  <nextmeeting date="2017-02-10 21:56:56 -0800">
    <agenda>
      Nothing of importance will be decided.
    </agenda>
    <clearance level="classified" />
  </nextmeeting>
</document>
```

Automatically encoding a data structure:
```
data = [
  {
    title: "Assassin's Apprentice",
    author: "Robin Hobb",
    published: 1995,
    rating: 4.5
  },
  {
    title: "The Fifth Season",
    author: "N. K. Jemisin",
    published: 2015,
    rating: 4.6
  },
  ...
].sort_by { |book| book['rating'] }

output = XMLBuilder.new
output.collection genre: 'fantasy' do
  data.each do |book|
    output.book do
      book.each { |field, value| output.add_element field, value }
    end
  end
end

p output

# =>
<collection genre="fantasy">
  <book>
    <title>
      Assassin's Apprentice
    </title>
    <author>
      Robin Hobb
    </author>
    <published>
      1995
    </published>
    <rating>
      4.5
    </rating>
  </book>
  ...
</collection>
```

## Installation
`gem install xmlbuilder`
or add `gem 'xmlbuilder'` to your Gemfile

[Here is the gem repo](https://rubygems.org/gems/xmlbuilder)

## License
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.