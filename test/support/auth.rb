module Support
  module Auth
    include Support::Services
    
    def mock_auth_for(auth)
      OmniAuth.config.mock_auth[:github] = {
        'provider' => auth.provider,
        'uid' => auth.uid,
        'user_info' => { 'name' => auth.user.name,
                         'nickname' => auth.user.github, 
                         'email' => auth.user.email
                       }
      }
    end
            
    def sign_user_in_with_mocks(user, hash)
      mock_auth_for(user.authorizations.first)
      mock_uniweb_user(hash)
      visit '/auth/github'   # TODO should be click_link 'Sign In' ?
    end
    
    def sign_user_in(user=Factory(:user))
      sign_user_in_with_mocks(user, 
                              {'github' => 'dummy', 'alumnus' => true, 'staff' => false}
                             )
    end

    def sign_admin_in(admin=Factory(:admin))
      sign_user_in_with_mocks(admin, 
                              {'github' => 'dummy', 'alumnus' => true, 'staff' => false}
                             )
    end

    def sign_out
      click_link 'Sign Out'
    end

  end
end
