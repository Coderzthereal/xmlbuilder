# XMLBuilder is a class that allows you to easily create XML.
# Here's an example:
#   xml = XMLBuilder.new
#   xml.document :type => 'xml', :use => 'example' do |document|
#     document.description { |desc| desc.add "This is an example of using XMLBuilder.\n" }
#     document.nextmeeting :date => Time.now+100000 do |meeting|
#       meeting.agenda { |agenda| agenda.add "Nothing of importance will be decided.\n" }
#       meeting.clearance true, :level => :classified # Passing true in as the first parameter will cause it to be a tag with no closing tag.
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
class XMLBuilder
	attr_reader :str
	# #initialize simply sets the string to "".
	def initialize
		@str = ""
	end
	# #clear does the same thing as #initialize (by delegating to it).
	def clear
		initialize # That's essentially what it does.
	end
	# #add adds a string (with no processing) to the object's string.
	def add(str)
		@str << str
	end
	# #method_missing is the brains of the operation. It takes the name of the tag to add,
	# an optional boolean parameter which signifies whether to make it a single tag or not,
	# any options to put in the tag, and a block to evaluate between the opening and closing tags.
	# There is an alias, #add_element, which is used for already defined methods such as #send and 
	# #method_missing..
	def method_missing(name, *args, &block)
		if args.length == 2
			one_tag, hash = *args
		elsif args.length == 1
			if args[0].is_a? Hash
				one_tag, hash = *[false, args[0]]
			else
				one_tag, hash = *[args[0], {}]
			end
		else
			one_tag, hash = false, {}
		end
		@str << "<#{name}"
		if one_tag
			hash.each do |k, v|
				@str << " #{k}=\"#{v}\""
			end
			@str << " />\n"
		else
			hash.each do |k, v|
				@str << " #{k}=\"#{v}\""
			end
			@str << ">\n"
			if block
				block.call(self)
			end
			@str << "</#{name}>\n"
		end
		return @str
	end
	alias :add_element :method_missing
	alias :to_s :str
	alias :to_str :str
	alias :inspect :str
end
require 'irb'
IRB.start