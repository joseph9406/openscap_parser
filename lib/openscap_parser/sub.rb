# frozen_string_literal: true
require 'openscap_parser/xml_node'

module OpenscapParser
  # <sub> 元素允许在规则的修复文本中,引用其他 XCCDF 文件的配置,集成到当前文件中。
  # sub 元素包含一个 href 属性，该属性指定要引用的子配置文件的位置。以下是一个示例：
  # <sub href="other_xccdf_file.xml"/>
  # 上朮表示,当前XCCDF文件引用了名为 other_xccdf_file.xml 的其他文件。引用的文件可能包含额外的规则、配置和信息，
  class Sub < XmlNode  
    def id
      @id ||= @parsed_xml['idref']
    end

    def use
      @use ||= @parsed_xml['use']
    end

    def to_h
      { :id => id, :text => text, :use => use }
    end
  end
end
