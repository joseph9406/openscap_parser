# frozen_string_literal: true

require 'openscap_parser/benchmark'

module OpenscapParser
  # Methods related to saving profiles and finding which hosts
  # they belong to
  module Benchmarks
    # included 是Ruby提供的一个钩子方法，当該 module 被 include 到其他的 module 或 class 时它会被调用。
    # 在此處 self 是指 Benchmarks 模塊, base 是指誰(module 或 class)包含了本模塊。
    def self.included(base)  
      base.class_eval do    # 给"包含此模塊的类"添加下列兩個实例方法 #benchmark、#benchmark_node
        def benchmark
          @benchmark ||= OpenscapParser::Benchmark.new(parsed_xml: benchmark_node)
        end        
        # ".//Benchmark中;其中, 表示在当前节点開始的子孙节点中查找。"當前節點"不見得只有一個節點,是滿足當前節點的所有節點。      
        # "//Benchmark";其中, "//" 代表从文档的根节点开始查找所有的節點。
        def benchmark_node(xpath = ".//Benchmark")  
          xpath_node(xpath)
        end
      end
    end
  end
end
