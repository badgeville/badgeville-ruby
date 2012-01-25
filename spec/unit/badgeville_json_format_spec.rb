describe BadgevilleBerlinJsonFormat, ".decode" do
  it "should convert a string into a hash" do
    BadgevilleBerlinJsonFormat.decode('{}').should == {}
  end

  it "should handle nils" do
    BadgevilleBerlinJsonFormat.decode(nil).should == nil
  end

  context "with a single object" do
    before do
      @json_record_w_root = "{\"data\":{\"name\":\"visitor_username\",\"created_at\":\"2012-01-05T10:43:42-08:00\",\"email\":\"revised_visitor@emailserver.com\",\"_id\":\"4f05ef5ea768651b3500009f\"},\"paging\":null}"
      @json_record_without_root = "{\"name\":\"visitor_username\",\"created_at\":\"2012-01-05T10:43:42-08:00\",\"email\":\"revised_visitor@emailserver.com\",\"_id\":\"4f05ef5ea768651b3500009f\"}"
    end

    it "should handle it" do
      BadgevilleBerlinJsonFormat.decode(@json_record_w_root).should == {"name"=>"visitor_username", "created_at"=>"2012-01-05T10:43:42-08:00", "email"=>"revised_visitor@emailserver.com", "_id"=>"4f05ef5ea768651b3500009f"}
    end

    it "should handle when there's no root key" do
      BadgevilleBerlinJsonFormat.decode(@json_record_without_root).should == {"name"=>"visitor_username", "created_at"=>"2012-01-05T10:43:42-08:00", "email"=>"revised_visitor@emailserver.com", "_id"=>"4f05ef5ea768651b3500009f"}
    end
  end

  context "with multiple objects" do
    before do
      @json_collection_w_root = '{"data":[{"name":"visitor1","_id":"4dfa6cbc888bae20b0000016"},{"name":"visitor2","_id":"4dfa8908888bae20b50000d1"}],"paging":{"current_page":1,"per_page":10}}'
      @json_collection_without_root = '[{"name":"visitor1","_id":"4dfa6cbc888bae20b0000016"},{"name":"visitor2","_id":"4dfa8908888bae20b50000d1"}]'
    end

    it "should handle it" do
      BadgevilleBerlinJsonFormat.decode(@json_collection_w_root).should  == [ {"name" => "visitor1", "_id" => "4dfa6cbc888bae20b0000016"},
                                                                              {"name" => "visitor2", "_id" => "4dfa8908888bae20b50000d1"} ]
    end

    it "should handle when there's no root key" do
      BadgevilleBerlinJsonFormat.decode(@json_collection_without_root).should  == [ {"name" => "visitor1", "_id" => "4dfa6cbc888bae20b0000016"},
                                                                                    {"name" => "visitor2", "_id" => "4dfa8908888bae20b50000d1"} ]
    end
  end


  # context "where root key data present, value at :data is a single record (hash of a hash)" do
  #   before do
  #     @json_record_w_root =
  #       "{\"data\":{\"name\":\"visitor_username\",\"created_at\":\"2012-01-05T10:43:42-08:00\",\"email\":\"revised_visitor@emailserver.com\",\"_id\":\"4f05ef5ea768651b3500009f\"},\"paging\":null}"
  #     @decoded_json = BadgevilleBerlinJsonFormat.decode(@json_record_w_root)
  #   end
  #
  #   it "should use the value at the key :data and convert it into a hash" do
  #     @decoded_json.should == {"name"=>"visitor_username", "created_at"=>"2012-01-05T10:43:42-08:00", "email"=>"revised_visitor@emailserver.com", "_id"=>"4f05ef5ea768651b3500009f"}
  #   end
  # end
  #
  #
  # context "where root key :data present, value at :data is a collection (array of hashes)" do
  #   before do
  #      @json_collection_w_root = '{"data":[{"name":"visitor1","_id":"4dfa6cbc888bae20b0000016"},{"name":"visitor2","_id":"4dfa8908888bae20b50000d1"}],"paging":{"current_page":1,"per_page":10}}'
  #      @decoded_json = BadgevilleBerlinJsonFormat.decode(@json_collection_w_root)
  #   end
  #
  #   it "should use the value at the key :data and convert it into an array of hashes" do
  #       @decoded_json.should  == [ {"name" => "visitor1", "_id" => "4dfa6cbc888bae20b0000016"},
  #                                  {"name" => "visitor2", "_id" => "4dfa8908888bae20b50000d1"} ]
  #   end
  #
  # end
  #
  #
  # context "root key :data present, but value at :data is an empty hash" do
  #    before do
  #       @json_empty_hash_at_data =
  #         "{\"data\":{},\"paging\":null}"
  #       @decoded_json = BadgevilleBerlinJsonFormat.decode(@json_empty_hash_at_data)
  #     end
  #
  #     it "should return an empty hash" do
  #       @decoded_json.should == {}
  #     end
  # end
  #
  #
  # context "where root key :data present, but value at :data is an empty array" do
  #   before do
  #     @json_empty_array_at_data =
  #       "{\"data\":[],\"paging\":null}"
  #     @decoded_json = BadgevilleBerlinJsonFormat.decode(@json_empty_array_at_data)
  #   end
  #
  #   it "should return an empty array" do
  #       @decoded_json.should == []
  #   end
  # end
  #
  #
  # context "where root key :data and a nested key :data are both present" do
  #   before do
  #     @json_w_2_keys_data =
  #       "{\"data\":{\"name\":\"visitor_username\",\"data\":\"value_of_nested_key_data\"},\"paging\":null}"
  #     @decoded_json = BadgevilleBerlinJsonFormat.decode(@json_w_2_keys_data)
  #   end
  #   it "should use the value at the key root key :data (ignoring the second key :data) and convert it into a hash" do
  #     @decoded_json.should == {"name"=>"visitor_username", "data" => "value_of_nested_key_data"}
  #   end
  # end
  #
  #
  # context "where root key data is missing, and json (hash of hash) string represents a single record (hash)" do
  #   before do
  #     @json_record_without_root =
  #         "{\"name\":\"visitor_username\",\"created_at\":\"2012-01-05T10:43:42-08:00\",\"email\":\"revised_visitor@emailserver.com\",\"_id\":\"4f05ef5ea768651b3500009f\"}"
  #     @decoded_json = BadgevilleBerlinJsonFormat.decode( @json_record_without_root)
  #   end
  #
  #   it "should use the entire json string to create a hash" do
  #     @decoded_json.should == {"name"=>"visitor_username", "created_at"=>"2012-01-05T10:43:42-08:00", "email"=>"revised_visitor@emailserver.com", "_id"=>"4f05ef5ea768651b3500009f"}
  #   end
  # end
  #
  #
  # context "where root key data is not :data, and json string represents a collection" do
  #     before do
  #        @json_collection_with_diff_root = '{"users":[{"name":"visitor1","_id":"4dfa6cbc888bae20b0000016"},{"name":"visitor2","_id":"4dfa8908888bae20b50000d1"}],"paging":{"current_page":1}}'
  #        @decoded_json = BadgevilleBerlinJsonFormat.decode(@json_collection_with_diff_root)
  #     end
  #
  #     it "should use the entire json string to create a hash with a nested array of hashes" do
  #         @decoded_json.should  == {"users" =>
  #                                     [{"name"=>"visitor1", "_id"=>"4dfa6cbc888bae20b0000016"}, {"name"=>"visitor2", "_id"=>"4dfa8908888bae20b50000d1"}],
  #                                   "paging"=>{ "current_page" => 1 } }
  #     end
  # end
  #
  #
  # #********* EXAMPLE FOR ALEX TO REVIEW **********#
  # context "where root key data is missing, and json string represents a collection (array of hashes)" do
  #     before do
  #        @json_collection_without_root = '[{"name":"visitor1","_id":"4dfa6cbc888bae20b0000016"},{"name":"visitor2","_id":"4dfa8908888bae20b50000d1"}]'
  #        @decoded_json = BadgevilleBerlinJsonFormat.decode(@json_collection_without_root)
  #     end
  #
  #     it "should use the value at the key :data and convert it into an array of hashes" # do
  #           @decoded_json.should  == [ {"name" => "visitor1", "_id" => "4dfa6cbc888bae20b0000016"},
  #                                      {"name" => "visitor2", "_id" => "4dfa8908888bae20b50000d1"} ]
  #     end
  # end
  #
  # context do "where the entire json string represents an empty hash"
  #   before do
  #     @empty_hash_string = "{}"
  #     @decoded_json = BadgevilleBerlinJsonFormat.decode( @empty_hash_string )
  #   end
  #   it "should return an empty hash" do
  #     @decoded_json.should == {}
  #   end
  # end
  #
  #
  # context "where the json is nil" do
  #   before do
  #     @nil_string = nil
  #   end
  #   it "should raise TypeError" do
  #     lambda{ @decoded_json = BadgevilleBerlinJsonFormat.decode( @nil_string ) }.should raise_error(TypeError)
  #   end
  # end
end

