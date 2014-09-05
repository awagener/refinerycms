module Refinery
  module Seeds
    class PluginGenerator
      def initalize(name, options = {})
        @name = name
        @users = options[:users] || (defined?(Refinery::User) && Refinery::User.all)
      
      def generate
        @users.each do |user|
          user.plugins.where(name: @name).first_or_create!(
            position: plugin_position_for_user(user)
          )
        end
      end
      
      private
      
      def plugin_position_for_user(user)
        (user.plugins.maximum(:position) || -1) +1
      end
    end
  end
end
