# coding: utf-8
module Gamobile
  module Generators
    class GamobileGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :gamobile_class, :type => :string, :default => 'mobile'
      argument :tracker_code, :type => :string, :default => 'xx-xxxxxxx-xx'

      desc <<DESC
Description:
  Copies Gamobile controllers and helpers files to your application's controllers and helpers directory.
DESC

      def generate_gamobile
        template 'gamobile_controller.rb', "app/controllers/#{file_name}_controller.rb"
        template 'gamobile_helper.rb', "app/helpers/#{file_name}_helper.rb"     
      end

      private

      def file_name
        gamobile_class.underscore.gsub("::", "/")
      end
    end
  end
end

