# frozen_string_literal: true

require 'openscap_parser/sub'

module OpenscapParser
  module Subs
    def self.included(base)
      base.class_eval do
        def subs
          return [] unless sub_nodes
          @subs ||= sub_nodes.map do |xml|
            Sub.new(parsed_xml: xml)
          end
        end

        def sub_nodes(xpath = './/sub')
          @sub_nodes ||= xpath_nodes(xpath)
        end

        def map_sub_nodes(children, set_values)  # children 表示当前节点的所有子节点，set_values 表示要设置的值。
          children.map do |child|
            # next child if child.name == 'text'
            #  <sub> 元素允许在规则的修复文本中,引用其他 XCCDF 文件的配置,集成到当前文件中。
            #  表示該<sub>節點是引用 set_values 中某個元素,所以用該被引用的 set_value 值來取代。
            # next replace_sub(Sub.new(parsed_xml: child), set_values) if child.name == 'sub' # 這行代碼有問題,若條件成立,就直接跳下一個迭代了,replace_sub 方法跟本不會執行            
            # child

            if child.name == 'text'
              next child
            elsif child.name == 'sub'
              replace_sub(Sub.new(id: child['id'], parsed_xml: child), set_values)
            else
              child
            end

          end
        end

        private

        def replace_sub(sub, set_values)
          set_value = set_values.find { |set_value| set_value.id == sub.id }
          return unless set_value
          # children 方法用于获取当前节点的所有直接子节点(集合)。这些子节点是当前节点在文档结构中的直接下一级。
          # 但是,使用 children 方法可能會包含了更多的节点，其中可能包括文本节点、注释节点等，而不仅仅是直接子元素。
          # 所以,为了获取真正的子元素个数，你可以使用 elements 方法，它返回当前节点的所有直接子元素节点。
          set_value.parsed_xml.children.first  
        end
      end
    end
  end
end
