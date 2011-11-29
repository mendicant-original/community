module UniversityWeb

  SITE = "http://university.rubymendicant.com"

  def self.service
    RestClient::Resource.new(SITE, SERVICE_ID, SERVICE_PASS)
  end

  class User < Struct.new(:github, :alumnus, :staff)

    PATH = "/users.json"

    def self.find_by_github(nick)
      find(:github => nick).first
    end

    def initialize(hash)
      self.github  = hash["github"]
      self.staff   = hash["staff"]
      self.alumnus = hash["alumnus"]
    end

    private

    class << self

      def find(params = {})
        return [ new(params.merge("staff" => true)) ] if Rails.env.development?

        resp = ::UniversityWeb.service[PATH].get :params => params

        parse(resp).map {|hash| new(hash)}
      end

      def parse(response)
        JSON.parse(response.to_s)
      end

    end

  end

end
