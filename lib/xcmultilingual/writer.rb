require 'erb'

module Xcmultilingual
  class Writer
    attr_accessor :name, :verbose

    def initialize(destination, bundle_data)
      @destination = destination
      @bundle_data = bundle_data
      @filename = File.basename(@destination)
    end

    def write
      puts "+ START UPDATING\n\n" if @verbose

      if !File.exist?("#{@destination}")
        puts "  There is no destination file." if @verbose
        puts "\n+ FAILED UPDATING\n" if @verbose
        return
      end

      File.open("#{@destination}", "w") do |file|
        template_file = templates_file(default_templates_dir)
        body = ERB.new(File.open(template_file).read, nil, '-').result(binding)
        file.write(body)
      end
      puts "+ END UPDATING\n\n" if @verbose
    end

    private

    def default_templates_dir
      File.dirname(__FILE__) + '/templates'
    end

    def templates_file(dir)
      dir + "/swift.erb"
    end
  end
end