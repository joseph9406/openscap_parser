# frozen_string_literal: true

require 'openscap_parser/set_value'

module OpenscapParser
  module SetValues
    def self.included(base)
      base.class_eval do
        def set_values
          @set_values ||= set_value_nodes.map do |set_value_node|
            OpenscapParser::SetValue.new(parsed_xml: set_value_node)
          end
        end

        # <set-value> 元素用于设置变量的值，这些变量可以在规则的检查和修复阶段中使用。
        # <set-value> 元素通常用于动态地为规则中的参数提供值。
        def set_value_nodes(xpath = ".//set-value") 
          xpath_nodes(xpath)
        end
      end
    end
  end
end
