# Rails customization.
if ENV.include?('RAILS_ENV')
  # Custom prompt with environment hint.
  prompt = "#{File.basename(Dir.pwd)}[#{ENV['RAILS_ENV'].split('').first.upcase}]"

  IRB.conf[:PROMPT] ||= {}
  IRB.conf[:PROMPT][:RAILS] = {
    :PROMPT_I => "#{prompt}>> ",
    :PROMPT_S => "#{prompt}* ",
    :PROMPT_C => "#{prompt}? ",
    :RETURN   => "=> %s\n"
  }
  IRB.conf[:PROMPT_MODE] = :RAILS

  # Log ActiveRecord output to console and add a convenience method
  # for finds. Called after the irb session is initialized and Rails has
  # been loaded. (Mike Clark)
  IRB.conf[:IRB_RC] = Proc.new do
    if defined?(ActiveRecord)
      ActiveRecord::Base.logger = Logger.new(STDOUT)
    end
  end
end

# Autocomplete
require 'irb/completion'

# Prompt behavior
ARGV.concat [ "--readline" ]

# Easily print methods local to an object's class.
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end
