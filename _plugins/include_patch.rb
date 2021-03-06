# _plugins/include_patch.rb
module Jekyll

  class IncludeTag < Liquid::Tag
    def render(context)
#      return "HELLO"

      file = context[@file] || @file
      includes_dir = File.join(context.registers[:site].source, '_includes')

      if File.symlink?(includes_dir)
        return "Includes directory '#{includes_dir}' cannot be a symlink"
      end

      if file !~ /^[a-zA-Z0-9_\/\.-]+$/ || file =~ /\.\// || file =~ /\/\./
        return "Include file '#{file}' contains invalid characters or sequences"
      end

#      "QWE"
#      includes_dir

#      return "QWE"

      #return file
      #return includes_dir
      

      Dir.chdir(includes_dir) do
        choices = Dir['**/*'].reject { |x| File.symlink?(x) } 

        if choices.include?(file)
          
          source = File.read(file)
          partial = Liquid::Template.parse(source)
  
          context.stack do
            partial.render(context)
          end
#          return "ok!"
        else
          "Included file '#{file}' not found in _includes directory"
        end
      end

    end
  end

end

Liquid::Template.register_tag('include', Jekyll::IncludeTag)
