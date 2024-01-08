# frozen_string_literal: true
require 'openscap_parser/xml_node'

module OpenscapParser
  #============================= <set-value> =========================================
  # 在 XCCDF文件中，<set-value> 元素用于设置测试中的变量值，以便在测试过程中使用这些值。
  # <set-value> 元素包含对变量的赋值，这些变量可以在 OVAL 检查和其他测试中使用。
  # 以下是 <set-value> 元素可能包含的一些属性和子元素：
  # id 属性：定义变量的唯一标识符。
  # selector 属性：定义要设置值的具体元素或属性的 XPath 选择器。
  # type 属性：指定变量的数据类型，如字符串、数字等。
  # operator 属性：定义设置变量值时所使用的操作符，例如“equals”、“not equal”等。
  # flag 属性：提供关于设置值的进一步信息，可能表示某些特殊处理或行为。
  # 子元素：<value> 元素：包含要设置的具体值。可以有多个 <value> 元素，每个表示一个可能的值。
  # 例:  
  # 将测试结果中名为 "threshold" 的参数的值设置为 10。
  # 这样，其他依赖于这个参数值的测试规则或配置项就可以动态地使用这个设置的值。
  # <set-value id="set1" selector="//configuration/parameter[@name='timeout']" operator="equals">
  #   <value>10</value>
  # </set-value>  
  #
  # <Value> 用于"静态地"定义检查的可能取值，
  # 例:
  # <Value id="value-x" type="string" operator="equals">
  #   <default>default_value</default>
  #   <value selector="option1">Option 1</value>
  #   <value selector="option2">Option 2</value>
  # </Value>
  # 
  # 而 <set-value> 用于在运行时动态地设置检查的值，以便根据配置文件或环境的不同进行调整。
  # 例:
  # <set-value idref="value-x" selector="option1"/>
  #===================================================================================
  class SetValue < XmlNode
    def id
      @id ||= @parsed_xml['idref']
    end

    def text
      @text ||= @parsed_xml.text
    end

    def to_h
      { :id => id, :text => text }
    end
  end
end
