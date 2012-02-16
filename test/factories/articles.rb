FactoryGirl.define do
  factory :article do
    title       'Article'
    body        'Lorem ipsum...'
    association :author, factory: 'user'

    factory :sticky_article do
      sticky    true
    end
  end
end
