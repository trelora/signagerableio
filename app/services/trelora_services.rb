class TreloraServices

  def initialize
    @_connection = Faraday.new(:url => "http://api.mytrelora.com")
  end

  def house_listing(role, limit = 40)
    response = connection.get do |req|
      req.url "/signage/?"
      req.params["role"]    = role
      req.params["limit"]   = limit
      req.params["api_key"] = ENV["trelora_api_key"]
    end

    results = parse(response)
    filter(results)
  end

  def get_roles
    response = connection.get do |req|
      req.url "/signage/roles?"
      req.params["api_key"] = ENV["trelora_api_key"]
    end
    parse(response)
  end

  private
    def connection
      @_connection
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def filter(results)
      results.select do |result|
        if result == :error
          false
        elsif result[:best_large_image] == nil
          false
        else
          prefix = result[:best_large_image].split("/")[0..2].join("/")
          final  = "/" + result[:best_large_image].split("/")[3..-1].join("/").gsub(" ", "%20")
          image = Faraday.new(prefix) { |b|
            b.use FaradayMiddleware::FollowRedirects
            b.adapter :net_http
          }
          status = image.head(final).status
          status < 400
        end
      end
    end
end
