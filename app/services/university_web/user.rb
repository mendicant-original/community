module UniversityWeb

  SITE = "http://school.mendicantuniversity.org"

  def self.service
    RestClient::Resource.new(SITE, SERVICE_ID, SERVICE_PASS)
  end

  class User < Struct.new(:github, :name, :email, :alumnus, :staff, :visiting_teacher)

    PATH = "/users.json"

    def self.find_by_github(nick)
      find(:github => nick).first
    end

    def initialize(hash)
      self.github           = hash["github"]
      self.name             = hash["name"]
      self.email            = hash["email"]
      self.staff            = hash["staff"]
      self.alumnus          = hash["alumnus"]
      self.visiting_teacher = hash["visiting_teacher"]
    end

    private

    class << self

      def find(params = {})
        return [ new(params.merge("staff" => true)) ] if Rails.env.development?

        response = ::UniversityWeb.service[PATH].get :params => params

        parse(response).map {|hash| new(hash) }
      end

      def parse(response)
        JSON.parse(response.to_s)
      end

    end

  end

end
