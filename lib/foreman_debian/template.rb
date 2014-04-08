module ForemanDebian
  class Template
    class Storage < OpenStruct

      def render(template_name)
        templates_dir = Pathname.new(__FILE__).dirname.dirname.dirname.join('templates')
        template = templates_dir.join("#{template_name}.erb")
        ERB.new(template.read).result(binding)
      end
    end

    def initialize(template_name)
      @template_name = template_name
    end

    def render(hash)
      Storage.new(hash).render(@template_name)
    end
  end
end
