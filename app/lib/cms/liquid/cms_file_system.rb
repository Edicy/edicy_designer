module CMS
  module Liquid
    class CmsFileSystem
      
      def initialize(design)
        @design = design
      end
      
      def read_template_file(template)
        File.read(File.expand_path(File.join(@design, "#{template}.tpl")))
      end
    end
  end
end