require 'test_helper'

class AuthTest < ActionDispatch::IntegrationTest

  test "user not in university-web should flash not registered alert" do
    sign_user_in_with_mocks(Factory(:user), {})
    
    page.has_selector?("div#flash-alert")
    page.has_content?(
      'Your github account is not registered on University-web'
    )
  end
  
  [:alumnus, :staff, :visiting_teacher].each do |user_category|
    test "user not #{user_category} should flash not authorized alert" do      
      mock_user = Factory(:user)
      uniweb_hash = { :github  => mock_user.github, 
                      :name    => mock_user.name, 
                      :email   => mock_user.email, 
                      :alumnus => !(user_category == :alumnus), 
                      :staff   => !(user_category == :staff), 
                      :visiting_teacher => !(user_category == :visiting_teacher)
                    }
                    
      sign_user_in_with_mocks(mock_user, uniweb_hash)
      
      page.has_selector?("div#flash-alert")
      page.has_content?(
        'Sorry, but currently only Alumni and Staff have access to this site'
      )
    end
    
    test "#{user_category} user should not flash alert" do
      mock_user = Factory(:user)
      uniweb_hash = { :github  => mock_user.github, 
                      :name    => mock_user.name, 
                      :email   => mock_user.email, 
                      :alumnus => (user_category == :alumnus), 
                      :staff   => (user_category == :staff), 
                      :visiting_teacher => (user_category == :visiting_teacher)
                    }
                    
      sign_user_in_with_mocks(mock_user, uniweb_hash)
      
      page.has_no_selector?("div#flash-alert")
   
    end
  end
  
  test "non-existent authorized user should be added with name and email taken from university-web" do
    
    mock_user = Factory(:bart)
    uniweb_hash = { :github  => mock_user.github, 
                    :name    => "Evil Twin of Bart Simpson", 
                    :email   => "dont.have.a.cow.man@gmail.com", 
                    :alumnus => true, 
                    :staff   => false, 
                    :visiting_teacher => false
                  }
                                       
    sign_user_in_with_mocks(mock_user, uniweb_hash)
    
    page.has_no_selector?("div#flash-error")
    
    new_user = User.find_by_uid(mock_user.uid)
    
    assert_equal 'Evil Twin of Bart Simpson', new_user.name
    assert_equal 'dont.have.a.cow.man@gmail.com', new_user.email
    
  end
  
  
  
end