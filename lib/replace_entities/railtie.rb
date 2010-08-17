require 'replace_entities'
require 'rails'

module ReplaceEntities
  class Railtie < Rails::Railtie

    initializer "replace_entities.active_record" do |app|
      if defined?(::ActiveRecord)
        ::ActiveRecord::Base.extend(ReplaceEntities::ArExtend)
      end
    end

  end
end
