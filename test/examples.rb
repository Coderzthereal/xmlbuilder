require_relative '../xmlbuilder'

# This test file contains various HTML snippets and fragments
# in order to "stress-test" the library. Also I can't think of
# edge cases so hopefully this will find them.

$expected = [] # array of strings
$actual = [] # array of procs

$expected << <<-end
<html>
  <head>
    <title>
      Page Title
    </title>
  </head>
  <body>
    <h1>
      My First Heading
    </h1>
    <p>
      My first paragraph.
    </p>
  </body>
</html>
end

$actual << Proc.new do |xml|
  xml.html do
    xml.head do
      xml.title 'Page Title'
    end
    xml.body do
      xml.h1 'My First Heading'
      xml.p 'My first paragraph.'
    end
  end
end

$expected << <<-end
<note>
  <to>
    Dave
  </to>
  <from>
    The Empress of Death
  </from>
  <heading>
    Reminder
  </heading>
  <body>
    Don't forget me this weekend!
  </body>
</note>
end

$actual << Proc.new do |xml|
  xml.note do
    xml.to 'Dave'
    xml.from 'The Empress of Death'
    xml.heading 'Reminder'
    xml.body 'Don\'t forget me this weekend!'
  end
end

$expected << <<-end
<bookstore>
  <book category="COOKING">
    <title lang="en">
      Everyday Italian
    </title>
    <author>
      Giada De Laurentiis
    </author>
    <year>
      2005
    </year>
    <price>
      30.00
    </price>
  </book>
  <book category="CHILDREN">
    <title lang="en">
      Harry Potter
    </title>
    <author>
      J K. Rowling
    </author>
    <year>
      2005
    </year>
    <price>
      29.99
    </price>
  </book>
</bookstore>
end

$actual << Proc.new do |xml|
  xml.bookstore do
    xml.book category: 'COOKING' do
      xml.title 'Everyday Italian', lang: 'en'
      xml.author 'Giada De Laurentiis'
      xml.year '2005'
      xml.price '30.00'
    end
    xml.book category: 'CHILDREN' do
      xml.title 'Harry Potter', lang: 'en'
      xml.author 'J K. Rowling'
      xml.year '2005'
      xml.price '29.99'
    end
  end
end



class XMLBuilderStressTest < Minitest::Test
  @@cases = $expected.zip($actual)
  def setup
    @test_obj = XMLBuilder.new
  end
  def test_all_cases
    @@cases.each do |expected, actual|
      actual = actual[@test_obj]
      assert_equal expected.to_s, actual.to_s
      @test_obj.clear
    end
  end
end