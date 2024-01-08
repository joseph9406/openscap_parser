# frozen_string_literal: true

# Utility functions for OpenscapParser
module OpenscapParser
  module Util
    def newline_to_whitespace(string)
      # gsub(/ *\n+/, " "): 这是一个正则表达式替换操作。
      # 正则表达式中的 + 是一个量词，表示匹配前面的模式（在这里是 \n，表示换行符）一次或多次。
      # 它会查找字符串 string 中的零个或多个空格（*表示零个或多个），接着是一个或多个换行符（+ 表示匹配前面的模式（即换行符 \n）一次或多次。）。
      # 找到匹配的部分后，将其替换为一个空格。
      string.gsub(/ *\n+/, " ").strip
    end
  end
end
