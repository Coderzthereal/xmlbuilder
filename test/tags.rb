require_relative '../xmlbuilder'

class XMLBuilderTagTest < Minitest::Test
  def setup
    @test_obj = XMLBuilder.new
  end

  def test_builder_can_create_tags
    @test_obj.add_element 'test_tag'
    assert_equal '<test_tag></test_tag>', @test_obj.to_s.chomp
    @test_obj.clear.add_element 'test_tag', true # Void element
    assert_equal '<test_tag />', @test_obj.to_s.chomp
  end

  def test_builder_can_create_attributes
    @test_obj.add_element 'test', attr: 'value'
    assert_equal '<test attr="value"></test>', @test_obj.to_s.chomp
  end

  def test_can_handle_non_string_attrs_and_contents
    @test_obj.add_element 'test', true, num: 37
    assert_equal '<test num="37" />', @test_obj.to_s.chomp
    @test_obj.clear.add_element 'test', 54
    assert_equal "<test>54</test>", @test_obj.to_s.chomp
  end

  # May move to 'test/examples.rb'
  def test_builder_can_nest_elements_correctly
    expected = <<~end
    <html>
      <head>
        <title>Test Title</title>
      </head>
      <body>
        <p class="content">This is a piece of test content.</p>
        <br />
      </body>
    </html>
    end

    xml = @test_obj
    xml.html do
      xml.head do
        xml.title 'Test Title'
      end
      xml.body do
        xml.p 'This is a piece of test content.', 'class': 'content'
        xml.br true
      end
    end
    assert_equal expected, xml.str
  end
end