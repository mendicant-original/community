module Support
  module Auth
    include Support::Services

    def mock_auth(hash)
      OmniAuth.config.mock_auth[:github] = {
        'provider' => 'github',
        'uid'      => hash[:uid],
        'info'     => {
          'name'     => hash[:name],
          'nickname' => hash[:github],
          'email'    => hash[:email]
        }
      }
    end

    def sign_in(auth_hash, uniweb_hash)
      visit root_path

      mock_auth(auth_hash)
      mock_uniweb_user(uniweb_hash)

      click_link 'Sign in with Github'

      auth_hash
    end

    # Sign in existing user
    #
    # Example:
    #   sign_user_in_with_mocks(Factory(:user), uniweb_hash)
    def sign_user_in_with_mocks(user, uniweb_hash)
      sign_in(user_auth_hash(user), uniweb_hash)
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

    private

    def user_auth_hash(user)
      {
        :uid    => user.uid,
        :name   => user.name,
        :github => user.github,
        :email  => user.email
      }
    end

  end
end
