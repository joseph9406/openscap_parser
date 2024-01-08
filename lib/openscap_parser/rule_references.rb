# frozen_string_literal: true

require 'openscap_parser/xml_file'
require 'openscap_parser/rule_reference'

module OpenscapParser
  # Methods related to finding and saving rule references
  module RuleReferences
    def self.included(base)
      base.class_eval do
        def rule_reference_strings
          @rule_reference_strings ||= rule_references.map do |rr|
            "#{rr.label}#{rr.href}"
          end
        end
        
        # # <reference> 元素是 <rule> 元素的子元素之一，用于提供与规则相关的外部引用或参考信息。
        def rule_references
          @rule_references ||= rule_reference_nodes.map do |node|
            OpenscapParser::RuleReference.new(parsed_xml: node)
          # "references.uniq do |reference| ... end"
          # 块中的条件是 [reference.label, reference.href]，即使用 label 和 href 两个属性的值来判断对象是否相同。
          # 假設數組中存在兩個元素a、b, 它們的两个 label 和 href 属性都相同, 即 a.label == b.label, a.href == b.href 
          # a 和 b 就被視為相同的元素, 其中一个会被去除，保留一个。
          end.uniq do |reference| 
            [reference.label, reference.href]
          end
        end
        alias :references :rule_references

        def rule_reference_nodes(xpath = ".//Rule/reference")
          xpath_nodes(xpath)
        end
      end
    end
  end
end
