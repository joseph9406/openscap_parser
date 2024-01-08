# frozen_string_literal: true

# RuleReference interface as an object
module OpenscapParser
  # 而 <reference> 元素是 <rule> 元素的子元素之一，用于提供与规则相关的外部引用或参考信息。
  # <reference> 元素通常包含一个 href 属性，指向一个外部资源（通常是一个网址），
  # 该资源提供有关规则的额外信息、解释、文档或其他相关内容。这样可以将规则与外部知识库、标准或其他信息关联起来，使得规则更具可读性和解释性。
  class RuleReference < XmlNode
    def href
      @href ||= @parsed_xml && @parsed_xml['href']
    end

    def label
      @label ||= @parsed_xml && @parsed_xml.text
    end
  end
end
