# frozen_string_literal: true

require 'openscap_parser/rule_results'
require 'openscap_parser/selectors'

module OpenscapParser
  # <TestResult> 元素用于表示执行安全策略测试的结果。它包含了有关测试的信息，例如测试的标识符、结果状态、详细说明等。
  class TestResult < XmlNode
    include OpenscapParser::RuleResults
    include OpenscapParser::Selectors

    def target
      @target ||= parsed_xml.at_xpath('target') && parsed_xml.at_xpath('target').text || ''
    end
    alias :host :target

    def target_fact_nodes
      @target_fact_nodes ||= parsed_xml.xpath('target-facts/fact')
    end

    def platform_nodes
      @platform_nodes ||= parsed_xml.xpath('platform')
    end

    def title
      @title ||= parsed_xml.at_xpath('title') && parsed_xml.at_xpath('title').text || ''
    end

    def identity
      @identity ||= parsed_xml.at_xpath('identity') && parsed_xml.at_xpath('identity').text || ''
    end

    def profile_id
      @profile_id ||= parsed_xml.at_xpath('profile') && parsed_xml.at_xpath('profile')['idref'] || ''
    end

    def benchmark_id
      @benchmark_id ||= parsed_xml.at_xpath('benchmark') && parsed_xml.at_xpath('benchmark')['id'] || ''
    end

    def set_value_nodes
      @set_value_nodes ||= parsed_xml.xpath('set-value')
    end

    def score
      @score ||= parsed_xml.at_xpath('score') && parsed_xml.at_xpath('score').text.to_f
    end

    def start_time
      @start_time ||= DateTime.parse(parsed_xml['start-time'])
    end

    def end_time
      @end_time ||= DateTime.parse(parsed_xml['end-time'])
    end
  end
end
