#--
# Copyright (c) 2010 Mateusz Bil 
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#++

require 'rubygems'
require 'haml'

module VIM
  class Buffer


    # Renders html from current haml buffer.
    # By default html will be rendered in new buffer
    # you can change it by passing hash:
    # * to render in new vsplitted buffer:
    #
    #   haml2html(:render => :new, :vsplit => true)
    #
    # * to preview in Vim's output:
    #   
    #   haml2html(:render => :preview)
    #
    # * to overwrite contents of current buffer:
    #
    #   haml2html(:render => :overwrite)
    #
    # * to insert after current line:
    #
    #   haml2html(:render => :insert)


    def haml2html(options = {})
      options[:render] ||= :new
      options[:vsplit] ||= false

      haml = nil 
      begin
        haml =  Haml::Engine.new( self.lines.join("\r\n"))
      rescue => e
        raise "Haml ERROR line #{e.line} >> #{e.message}"
      end

      case options[:render]
      when :new
        if options[:vsplit] == true
          VIM::command("vnew")
        else
          VIM::command("new")
        end
        buffer = VIM::Buffer.current
        buffer.insert(haml)

      when :preview
        haml.render.each {|l| puts l}

      when :overwrite
        self.clear
        self.insert(haml)

      when :insert
        self.insert(haml, :from => self.line_number)

      end

    end

    # returns buffer's lines in array 
    def lines
      ret = []
      for i in 1..self.count do
        ret << self[i]
      end
      ret
    end

    def clear
      for i in 1..self.count do
        self.delete(1)
      end
    end


    # Appends buffer with html rendered from given haml
    # you can pass hash to set the line number to start from
    #   
    #   insert(haml, :from => 10)
    #
    def insert(haml, options = {})
      from = options[:from].to_i || 1
      if from > self.count
        (from.to_i - self.count).times { |i| self.append( i+1, '') }
      end
      haml.render.each_with_index do |l,i|
        self.append(i+from, l.gsub(/(\r|\n)/,'')) 
      end
    end

  end
end

