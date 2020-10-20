# XMLBuilder is a library that allows you to easily create XML.
# 
# Licensed under CC-BY-NC-SA 4.0
# 
# Written by Coderzthereal
# 

#this part is super hacky, i'm just trying to pass my own tests before i rewrite this entire thing
module Boolean; end
class TrueClass; include Boolean; end
class FalseClass; include Boolean; end


class XMLBuilder
  @@default_separator = "  "
  # separator set to two spaces by default, used in nesting

  attr_reader :str
  attr_accessor :separator
  
	def initialize(separator=@@default_separator)
		@str = ""
		@depth = 0
		@separator = separator
  end
  
	# Sets the stored string to "" and the depth to 0.
	def clear
    initialize(@separator)
    self
  end
  
	# Adds a string (with no preprocessing) to the object's string.
	def add(*strs)
		@str << strs.flatten.join('')
  end
  
	# Takes the name of the tag to add, an optional string to put in the tag, an optional boolean parameter which signifies whether to make it a single tag or not, any options to put in the tag, and a block to evaluate between the opening and closing tags. Aliased to #method_missing to allow dynamic tag creation.
  def add_element(name, *args)
    one_tag, internal, attrs = process_args args
    
    # logic time
    add indentation, ?<, name
    attrs.each do |attr, value|
      add " #{attr}=\"#{value}\""
    end unless attrs.empty?
    if one_tag
      add " />\n"
      return self
    else
      add ?>
    end
    @depth += 1
    if internal
      add internal
    elsif block_given?
      add "\n"
      yield
    end
    @depth -= 1
    add indentation unless internal
    add "</#{name}>\n"
    return self
  end

  def process_args(args)
    # Argument cheat sheet:
    #  <name hash[0]="hash[1]">
    #    internal
    #  </name>
    
		internal = nil
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
    return one_tag, internal, hash
  end
  def indentation; @separator * @depth; end
	alias :method_missing :add_element
	alias :to_s :str
	alias :to_str :str
  alias :inspect :str
  private :process_args, :indentation
	public :add_element
end
