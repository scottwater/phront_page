require "active_storage/service/s3_service"
module ActiveStorage
  class Service
    class S3WithPrefixService < S3Service
      def path_for(key)
        prefix = formatted_prefix
        if prefix.present?
          "#{prefix}/#{key}".gsub("//", "/")
        else
          key
        end
      end

      private

      def formatted_prefix
        prefix = ENV["UPLOAD_PREFIX"]&.strip
        (prefix && prefix[0] == "/") ? prefix[1..] : prefix
      end

      def object_for(key)
        bucket.object(path_for(key))
      end
    end
  end
end
