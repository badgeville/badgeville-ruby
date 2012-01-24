describe BadgevilleJsonFormat do


  context do "where the json has a root key :data and the JSON string represents a single remote member (hash of a hash)"
    before do
      @json_w_root_key_data =
        "{\"data\":{\"name\":\"visitor_username\",\"created_at\":\"2012-01-05T10:43:42-08:00\",\"email\":\"revised_visitor@emailserver.com\",\"_id\":\"4f05ef5ea768651b3500009f\"},\"paging\":null}"
      @decoded_json = BadgevilleJsonFormat.decode(@json_w_root_key_data)
    end

    it "should use the value at the key :data and convert it into a hash" do
      @decoded_json.should == {"name"=>"visitor_username", "created_at"=>"2012-01-05T10:43:42-08:00", "email"=>"revised_visitor@emailserver.com", "_id"=>"4f05ef5ea768651b3500009f"}
    end
  end

  context do "where the json has a root key :data and the JSON string represents a remote collection (hash of hash of arrays)"
    before do
    end

    it "should use the value at the key :data and convert it into an array" do
    end
  end


  context do "where the json is missing a root key :data"
    before do
      @json_without_root_key_data =
          "{\"name\":\"visitor_username\",\"created_at\":\"2012-01-05T10:43:42-08:00\",\"email\":\"revised_visitor@emailserver.com\",\"_id\":\"4f05ef5ea768651b3500009f\"}"
      @decoded_json = BadgevilleJsonFormat.decode(@json_without_root_key_data)
    end

    it "should use the entire json string" do
      @decoded_json.should == {"name"=>"visitor_username", "created_at"=>"2012-01-05T10:43:42-08:00", "email"=>"revised_visitor@emailserver.com", "_id"=>"4f05ef5ea768651b3500009f"}
    end
  end


  context do "where the json has a root key :data, but the value of :data is an empty hash"
     before do
        @json_empty_hash_at_data =
          "{\"data\":{},\"paging\":null}"
        @decoded_json = BadgevilleJsonFormat.decode(@json_empty_hash_at_data)
      end

      it "should return an empty hash" do
        @decoded_json.should == {}
      end
  end


  context do "where the json has a root key :data, but the value of :data is an empty array"
    before do
      @json_empty_array_at_data =
        "{\"data\":[],\"paging\":null}"
      @decoded_json = BadgevilleJsonFormat.decode(@json_empty_array_at_data)
    end

    it "should return an empty array" do
        @decoded_json.should == []
    end
  end


  context do "where the json is a string representing an empty hash"
    before do
      @empty_hash_string = "{}"
      @decoded_json = BadgevilleJsonFormat.decode( @empty_hash_string )
    end
    it "should return an empty hash" do
      @decoded_json.should == {}
    end
  end

  context do "where the json has a root key :data and a nested key :data"
  end


  context do "where the json is missing a root key :data but has a nested key :data"
  end


  context do "where the json is nil"
    before do
      @nil_string = nil
    end
    it "should raise TypeError" do
      lambda{ @decoded_json = BadgevilleJsonFormat.decode( @nil_string ) }.should raise_error(TypeError)
    end
  end


end

