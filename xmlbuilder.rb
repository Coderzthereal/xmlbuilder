# XMLBuilder is a library that allows you to easily create XML.
# 
# Licensed under CC-BY-NC-SA 4.0
# 
# Written by [redacted]
# 

#this part is super hacky, i'm just trying to pass my own tests before i rewrite this entire thing
module Boolean; end
class TrueClass; include Boolean; end
class FalseClass; include Boolean; end


class XMLBuilder
	attr_reader :str
	# Sets the stored string to "" and the depth (used in nesting tags) to 0.
	def initialize(separator="  ") # separator set to two spaces by default, used in nesting
		@str = ""
		@depth = 0
		@separator = separator
	end
	# #clear does the same thing as #initialize (by delegating to it).
	def clear
    initialize
    self
	end
	# Adds a string (with no preprocessing) to the object's string.
	def add(str)
		@str << str
	end
	def to_ary
		return [@str]
	end
	# Takes the name of the tag to add, an optional string to put in the tag, an optional boolean parameter which signifies whether to make it a single tag or not, any options to put in the tag, and a block to evaluate between the opening and closing tags. There is an alias, #add_element, which is used for already defined methods such as #send and #method_missing.
	def method_missing(name, *args, &block)
		internal = nil # Internal is a string that is put between the sides of the element
		if args.length == 2
      if args[0].is_a? Boolean
        one_tag, hash = *args
      else
        one_tag, internal, hash = false, *args
			end
		elsif args.length == 1
			if args[0].is_a? Hash
				one_tag, hash = *[false, args[0]]
			elsif args[0].is_a? Boolean
				one_tag, hash = args[0], {}
			else
				one_tag, internal, hash = false, args[0].to_s, {}
			end
		else
			one_tag, hash = false, {}
		end
		@str << @separator.to_s * @depth
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
      @str << ">"
      @str << ?\n if (block or internal)
      if !internal.nil?
        @depth += 1
        @str << (@separator*@depth + internal.to_str + "\n")
        @depth -= 1
			elsif block
				@depth += 1
				block.call
				@depth -= 1
			end
			@str << @separator * @depth
			@str << "</#{name}>\n"
		end
		return @str
	end
	alias :add_element :method_missing
	alias :to_s :str
	alias :to_str :str
	alias :inspect :str
	public :add_element
end
