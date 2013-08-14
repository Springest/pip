require 'uri'
require 'net/http'
require 'net/https'
require 'json'
require 'cgi'

module Pip
  class Request
    def initialize path
      @path = path
      @uri = URI "https://api.pipelinedeals.com/api/v3#{@path}.json?api_key=#{config.api_key}"
    end

    def get options={}
      @results = []
      fetch :type => :get, :data => options
    end

    def post options={}
      @results = []
      fetch :type => :post, :data => options
    end

    private

    def fetch options={}
      uri = @uri

      type = options.fetch :type, :get
      req_data = options.fetch :data, nil
      url = uri.request_uri

      session = Net::HTTP.new uri.host, uri.port
      session.use_ssl = true
      session.start do |http|
        if type == :post
          post_data = req_data.to_json if req_data && req_data.instance_of?(Hash)
          request = Net::HTTP::Post.new url, {'Content-Type' => 'application/json'}
          request.body = post_data
        else
          unless req_data.nil?
            params = req_data.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')
            url = url.concat('&').concat(params)
          end

          request = Net::HTTP::Get.new url
        end

        response = http.request request

        data = JSON.parse response.body

        @results = data
      end
    end

    def config
      @config ||= Config.new
    end
  end
end
