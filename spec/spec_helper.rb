require_relative '../lib/meta_programming'
require 'minitest/spec'
require 'minitest/autorun'

class Talker 
  attr_accessor :my_var

  def initialize
    @my_var = "dave"
  end
  
  def say(str)
    str 
  end
end

Talker.class_eval do
  def say(str)
    str + "a"
  end
end

class Changer
  @my_var = "o boy"

  def self.wrap2 klass, method
    klass.class_eval %Q(
      alias_method :changer_#{method.to_s}
      def #{method.to_s}(opt)
        opt + "o ya"
      end
    )
  end

  def self.wrap klass, method
    puts klass.instance_methods(false).include?(method)
    puts klass.instance_methods(false).include?("charger_{method.to_s}.to_sym")
    klass.class_eval %Q(
      alias_method :changer_#{method.to_s}, :#{method.to_s}
      def #{method.to_s}(opt)
        "VALUE FROM ORIGINAL=\#{changer_#{method.to_s}(opt)}"
      end
    )
    tmp = "charger_#{method.to_s}".to_sym
    puts tmp
    puts klass.instance_methods(false).include?(tmp)
  end
end
