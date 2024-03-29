# frozen_string_literal: true

require 'openscap_parser/util'
require 'openscap_parser/xml_file'
require 'openscap_parser/rules'
require 'openscap_parser/profiles'
require 'openscap_parser/rule_references'

# Mimics openscap-ruby Benchmark interface
module OpenscapParser
  class Benchmark < XmlNode
    include OpenscapParser::Util
    include OpenscapParser::Rules
    include OpenscapParser::RuleReferences
    include OpenscapParser::Profiles

    def id
      @id ||= @parsed_xml['id']  # 获取具有名为 'id' 的属性值。
    end

    def title
      # @parsed_xml.xpath('title') 查詢當前節點內的第一代"title"子節點,不會再往下查詢孫節點。
      @title ||= @parsed_xml.xpath('title') && @parsed_xml.xpath('title').text
    end

    def description
      @description ||= newline_to_whitespace( @parsed_xml.xpath('description') && @parsed_xml.xpath('description').text || '' )
    end

    def version
      @version ||= @parsed_xml.xpath('version') && @parsed_xml.xpath('version').text
    end
  end
end
