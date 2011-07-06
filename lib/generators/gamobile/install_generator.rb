# coding: utf-8
module Gamobile
  module Generators
    class InstallGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)
      argument :tracker_code, :type => :string, :default => 'xx-xxxxxxx-xx'

      desc <<DESC
Description:
  Copies Gamobile controllers and helpers files to your application's controllers and helpers directory.
DESC

      def generate_gamobile
        template 'gamobile_controller.rb', File.join("app/controllers", class_path, "#{file_name}_controller.rb")
        template 'gamobile_helper.rb', File.join("app/helpers/", class_path, "#{file_name}_helper.rb")     
      end
   end
  end
end

