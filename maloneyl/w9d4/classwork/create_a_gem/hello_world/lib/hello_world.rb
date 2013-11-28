require "hello_world/version"
require "yaml"

module HelloWorld

  def self.say_hello language=nil, name=nil
    raise ArgumentError, "You need to provide a language key" if language.nil? # give explicit error msg for developers using the gem
    [hash[language.to_sym], name].join(" ")
  end

  def self.languages
    hash.keys
  end

  def self.random
    key = hash.keys.sample
    hash.assoc key # returns array of key and value, e.g. => [:serbian, "dobar dan"]
  end

  def self.hash # loaded yml file is a hash
    @@hello_hash ||= YAML.load_file File.expand_path("../../resources/hello.yml", __FILE__)
    @@hello_hash[:hello] # :hello is the key in our yml
    # class variable: @@
    # always use absolute path for files by creating it with __FILE__
  end

end
