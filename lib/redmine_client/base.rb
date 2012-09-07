module RedmineClient

  class JSONFormatter
    include ActiveResource::Formats::JsonFormat

    def decode(json)
      decoded = ActiveResource::Formats::JsonFormat.decode(json)
      return decoded unless decoded.is_a? Hash

      # Because we don't know which class we're working with, we try all.
      key = RedmineClient::Base::descendants.select do |subclass|
        decoded.has_key? (subclass.name.split('::').last || '').tableize
      end
      key = key.first

      key.nil? ? decoded : decoded['issues']
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

