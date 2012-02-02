module Support
  module Auth
    include Support::Services

    def mock_auth_for(user)
      OmniAuth.config.mock_auth[:github] = {
        'provider' => 'github',
        'uid'      => user.uid,
        'info'     => {
          'name'     => user.name,
          'nickname' => user.github,
          'email'    => user.email
        }
      }
    end

    def sign_user_in_with_mocks(user, hash)
      mock_auth_for(user)
      mock_uniweb_user(hash)

      visit root_path
      click_link 'Sign in with Github'

      user
    end

    def sign_user_in(user=Factory(:user))
      sign_user_in_with_mocks(user,
        'github'           => user.github,
        'alumnus'          => true,
        'staff'            => false,
        'visiting_teacher' => false
      )
    end

    def sign_admin_in(admin=Factory(:admin))
      sign_user_in_with_mocks(admin,
        'github'           => user.github,
        'alumnus'          => false,
        'staff'            => true,
        'visiting_teacher' => false
      )
    end

    def sign_out
      click_link 'Sign out'
    end

  end
end
