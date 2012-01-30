FactoryGirl.define do  
  factory :activity, :class =>  BadgevilleBerlin::Activity do
    _id '4f0b435ea768656ca400001b'
  end

  factory :activity_definition, :class =>  BadgevilleBerlin::ActivityDefinition do
    _id '4f0b435ea768656ca400001b'
    name 'A Cool Comment Behavior'
    site_id '4f079a04a76865329a000087'
    selector '{"verb" : "comment"}'
    adjustment '{"points" : 5}'
  end
  
  factory :group, :class => BadgevilleBerlin::Group do
    _id "4f05ef5ea768651b3500009f"
  end
  
  factory :leaderboard, :class => BadgevilleBerlin::Leaderboard do
    _id "4f05ef5ea768651b3500009f"
  end

  factory :player, :class => BadgevilleBerlin::Player  do
    _id '4f0b29bca76865329a0000ae'
    email 'supraja220494@BadgevilleBerlin-berlin.com'
  end
  
  factory :reward, :class => BadgevilleBerlin::Reward  do
    _id '4f0b29bca76865329a0000ae'
  end
  
  factory :reward_definition, :class => BadgevilleBerlin::RewardDefinition  do
    _id '4f0b29bca76865329a0000ae'
  end
  
  factory :site, :class =>  BadgevilleBerlin::Site do
    _id '4f079a04a76865329a000087'
    name "My Website"
    url "mydomain.com"
    network_id '4d5dc61ed0c0b32b79000001'
  end
  
  factory :track, :class => BadgevilleBerlin::Track  do
    _id '4f0b29bca76865329a0000ae'
  end
  
  factory :user, :class => BadgevilleBerlin::User do
    _id "4f05ef5ea768651b3500009f"
    name "visitor_username"
    network_id "4d5dc61ed0c0b32b79000001"
    email "visitor@emailserver.com"
    password "testing123"
  end
end

