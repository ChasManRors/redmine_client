module RedmineClient

  class JSONFormatter
    include ActiveResource::Formats::JsonFormat

    def decode(json)
      decoded = ActiveResource::Formats::JsonFormat.decode(json)

      if decoded.is_a? Hash
        # Because we don't know which class we're working with, we try all.
        keys = Base::descendants.map{|subclass|(subclass.name.split('::').last || '').tableize}
        keys.each do |key|
          return decoded[key] if decoded.has_key? key
        end
      end

      decoded
    end
  end

  class Base < ActiveResource::Base
    class << self

      def configure(&block)
        instance_eval &block
      end

      # Get your API key at "My account" page
      def token= val
        if val
          (descendants + [self]).each do |resource|
            resource.headers['X-Redmine-API-Key'] = val
          end
        end
      end
    end

    self.format = JSONFormatter.new
  end

end

