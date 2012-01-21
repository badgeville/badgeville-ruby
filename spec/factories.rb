FactoryGirl.define do
  factory :user, :class => Badgeville::User do
    _id "4f05ef5ea768651b3500009f"
    name "visitor_username"
    network_id "4d5dc61ed0c0b32b79000001"
    email "visitor@emailserver.com"
    password "testing123"
  end

  factory :player, :class => Badgeville::Player  do
    email 'supraja220494@badgeville.com'
    id '4f0b29bca76865329a0000ae'
  end
  factory :site do
    name "My Website"
    url "mydomain.com"
    network_id '4d5dc61ed0c0b32b79000001'
  end
end

