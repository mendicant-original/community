module Support
  module Services
  
    class RestClientResourceStub
    
      class ResponseStub
        def initialize(response)
          @response = response
        end
        
        def get(*args)
          @response
        end
      end
      
      def initialize(mock_hash)
        @mock_hash = mock_hash
      end
      
      def [](key)
        ResponseStub.new(@mock_hash[key])
      end
   
    end
   
    def mock_uniweb_user(hash)
      service = RestClientResourceStub.new({::UniversityWeb::User::PATH => [hash].to_json})
      ::UniversityWeb.stubs(:service).returns(service)
    end
    
  end
end
