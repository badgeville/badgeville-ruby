FactoryGirl.define do  
  factory :activity, :class =>  Badgeville::Activity do
    _id '4f0b435ea768656ca400001b'
  end
  
  factory :activity_definition, :class =>  Badgeville::ActivityDefinition do
    _id '4f0b435ea768656ca400001b'
  end
  
  factory :group, :class => Badgeville::Group do
    _id "4f05ef5ea768651b3500009f"
  end
  
  factory :leaderboard, :class => Badgeville::Leaderboard do
    _id "4f05ef5ea768651b3500009f"
  end

  factory :player, :class => Badgeville::Player  do
    _id '4f0b29bca76865329a0000ae'
    email 'supraja220494@badgeville.com'
  end
  
  factory :reward, :class => Badgeville::Reward  do
    _id '4f0b29bca76865329a0000ae'
  end
  
  factory :reward_definition, :class => Badgeville::RewardDefinition  do
    _id '4f0b29bca76865329a0000ae'
  end
  
  factory :site, :class =>  Badgeville::Site do
    _id '4f079a04a76865329a000087'
    name "My Website"
    url "mydomain.com"
    network_id '4d5dc61ed0c0b32b79000001'
  end
  
  factory :track, :class => Badgeville::Track  do
    _id '4f0b29bca76865329a0000ae'
  end
  
  factory :user, :class => Badgeville::User do
    _id "4f05ef5ea768651b3500009f"
    name "visitor_username"
    network_id "4d5dc61ed0c0b32b79000001"
    email "visitor@emailserver.com"
    password "testing123"
  end
end

